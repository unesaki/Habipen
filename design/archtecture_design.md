# 技術要件定義書 - Habit Penguin (ハビペン)

| 項目 | 内容 |
| --- | --- |
| バージョン | 1.1 (Final Fix + Schema Patch) |
| 対象OS | iOS先行 (Target SDK: 最新安定版) |
| 開発言語 | Dart (Flutter), TypeScript (Cloud Functions) |
| インフラ | Firebase (GCP) |
| パッケージ名 | com.habitpenguin.app |

## 1. システムアーキテクチャ概要

### 1.1 全体構成
*   **クライアント (Mobile App):** Flutterによるクロスプラットフォーム開発。MVVM + Repositoryパターンを採用。
*   **バックエンド (BaaS):** Firebaseエコシステムをフル活用したサーバーレス構成。
*   **決済基盤:** RevenueCatをミドルウェアとして採用し、ストアごとの差異を吸収する。

### 1.2 技術スタック選定

| カテゴリ | 技術・サービス | 選定理由 |
| --- | --- | --- |
| Framework | Flutter | iOS/Android同時展開を見据えた効率化。Riverpodによる状態管理。 |
| Auth | Firebase Auth | Google, Apple, 匿名認証の実装。 |
| Database | Cloud Firestore | リアルタイム同期、オフライン対応、スケーラビリティ。 |
| Backend Logic | Cloud Functions | 決済、ガチャ、定期実行などのセキュアな処理。 |
| Hosting | Firebase Hosting | 招待用Webクッションページ、規約ページのホスティング。 |
| Config | Remote Config | メンテナンスモード、強制アップデート制御。 |
| IAP | RevenueCat | 課金実装工数の削減とレシート検証。 |
| Deep Link | Flutter Deep Linking | 招待URLのハンドリング (Webクッションページ併用)。 |

## 2. データベース設計 (Cloud Firestore Schema)
NoSQLの特性を活かし、読み取りコストを最適化する設計とする。

### 2.1 users (Root Collection)
ユーザー個人の資産・設定を管理。

```json
{
  "uid": "user_xyz",
  "name": "タロウ", // 初回起動時に設定
  "groupId": "group_abc", // 所属グループID
  "currentSkinId": "skin_default",
  "unlockedSkins": ["skin_default", "skin_crown"], // 資産 (Server Side管理推奨)
  "currentPoints": 150,
  "ticketCount": 2, // ガチャ被り救済チケット
  // 広告視聴制限用 (Lazy Reset方式)
  "adWatchCount": 2, // 本日の視聴回数
  "lastAdWatchedAt": timestamp, // 最終視聴日時 (日付判定用)
  // 設定・状態
  "fcmToken": "token_abc",
  "settings": {
    "isPushEnabled": true,
    "isSoundEnabled": true
  },
  "status": "active", // active | deleted_reserved
  "deletedAt": null, // 退会予約日時
  "createdAt": timestamp
}
```

### 2.2 groups (Root Collection)
グループのメタデータとメンバー管理。

```json
{
  "groupId": "group_abc",
  "members": ["user_xyz", "user_123"], // 最大5名
  "inviteId": "inv_001", // 手動入力用ID (ランダム文字列)
  "taskCount": 45, // 未完了タスク数キャッシュ（上限100件制限用）
  "createdAt": timestamp
}
```

### 2.3 groups/{groupId}/tasks (Sub Collection)
タスクの実体。

```json
{
  "taskId": "task_001",
  "title": "燃えるゴミ",
  "description": "8時までに",
  "categoryId": "cat_trash",
  "assigneeId": "user_xyz", // null許容 (未定)
  "createdBy": "user_abc", // 作成者UID (完了通知の宛先用)
  // 期限 (時間は00:00固定)
  "dueDate": timestamp,
  // 繰り返し設定 (作成時に定義)
  "repeatRule": {
    "type": "weekly", // daily, weekly, monthly, none
    "weekdays": [1, 4] // 月・木
  },
  "isCompleted": false,
  "completedBy": null,
  "completedAt": null,
  // 催促クールタイム判定用
  "lastNudgedAt": timestamp
}
```

### 2.4 groups/{groupId}/categories (Sub Collection)
ユーザー定義カテゴリ。

```json
{
  "categoryId": "cat_custom_001",
  "name": "犬の散歩",
  "iconKey": "dog_walking", // アプリ内アセットキー
  "color": "#FF5733"
}
```

## 3. バックエンドロジック (Cloud Functions)
整合性担保のため、以下の処理はTypeScript (Node.js) で実装する。

### 3.1 Callable Functions (クライアントトリガー)

**drawGacha**
*   **機能:** ポイントを消費してガチャを引く（トランザクション処理）。
*   **入力:** なし (Auth Context使用)
*   **ロジック:**
    1.  ポイント残高確認 (100pt未満エラー)。
    2.  ランダム抽選。
    3.  被り判定: ■所持済み→チケット+1付与。 ■未所持→unlockedSkinsに追加。
    4.  ポイント -100 減算。

**watchAdReward**
*   **機能:** 動画広告視聴後のポイント付与 & 回数制限チェック (Lazy Reset)。
*   **ロジック:**
    1.  lastAdWatchedAt を確認。日付が変わっていれば adWatchCount を0にリセット。
    2.  adWatchCount を確認 (5回以上ならエラー)。
    3.  ポイント +20 付与。
    4.  adWatchCount インクリメント、lastAdWatchedAt を現在時刻に更新。

**joinGroup**
*   **機能:** グループへの参加処理。
*   **入力:** inviteId または groupId
*   **ロジック:**
    1.  参加先グループのメンバー数確認 (5名以上ならエラー)。
    2.  ユーザーがソロプレイ等で持っていた既存タスクを物理削除 (リセット)。
    3.  groups.members にUID追加。
    4.  users.groupId 更新。

### 3.2 Firestore Triggers (DBイベント)

**onTaskCompleted**
*   **Trigger:** tasks/{taskId} の isCompleted が true に変化
*   **処理:**
    1.  完了ユーザーにポイント +5 付与 (Daily Cap 30ptチェック含む)。
    2.  repeatRule ありの場合、次回のタスクを新規作成 (dueDate 計算)。
    3.  通知: createdBy (作成者) と assigneeId (担当者) にのみFCM送信。

**onTaskCreated/Deleted**
*   **Trigger:** tasks ドキュメントの増減
*   **処理:**
    1.  親ドキュメント groups.taskCount を増減。
    2.  上限 (100件) チェック (Server側でもガード)。

### 3.3 Scheduled Functions (定期実行)

**dailyCleanup (毎日 04:00 JST)**
*   **処理:**
    1.  履歴削除: completedAt が90日以前のタスクを物理削除。
    2.  退会実行: status: deleted_reserved かつ30日経過したユーザーを物理削除。
    3.  ※広告回数のリセットは watchAdReward 内のLazy Resetで行うため不要。

**morningReminder (毎日 08:00 JST)**
*   **処理:**
    1.  dueDate が今日の未完了タスクを抽出。
    2.  各タスクの担当者・作成者にPush通知。

## 4. クライアントサイド設計方針 (Flutter)

### 4.1 アーキテクチャ
*   **State Management:** Riverpod (Generator)。
*   **Router:** GoRouter (Deep Link対応)。
*   **Directory:** Feature-first構成。

### 4.2 初期データ (Seed Data)
*   **初回起動時:** アプリ内ローカルロジックにて、以下のチュートリアルタスクを自動生成してDBに登録する。
    1.  「パートナーを招待してみよう」（期限なし）
    2.  「このタスクをスワイプで完了させてみて！」（期限：今日）

### 4.3 オフライン制御
*   **Firestore:** enablePersistence: true。タスク閲覧・操作は可能。
*   **Gacha/Ad:** ネットワーク接続がない場合、ボタンをグレーアウトまたはエラーダイアログ表示。

### 4.4 招待フロー
*   **URL:** `https://habitpenguin.web.app/invite?gid=xxx`
*   **挙動:** Webクッションページを経由し、アプリインストール済みなら起動、未ならストアへ誘導。

## 5. 定数・パラメータ定義 (Constants)

| パラメータ名 | 設定値 | 備考 |
| --- | --- | --- |
| Gacha Cost | 100 pt | ガチャ1回 |
| Task Reward | 5 pt | タスク完了報酬 |
| Daily Point Cap | 30 pt | 1日あたりの獲得上限 |
| Ad Reward | 20 pt | 動画広告1回 |
| Ad Daily Limit | 5回 | 1日あたりの視聴上限 (Lazy Reset) |
| Nudge Cooldown | 60分 | 催促ボタンの再押下待ち時間 |
| Group Capacity | 5名 | グループ最大人数 |
| Task Capacity | 100件 | 1グループあたりの未完了タスク上限 |
| History Retention | 90日 | 完了タスク保存期間 |
| Deletion Grace | 30日 | 退会猶予期間 |

## 6. セキュリティ & インフラ設定

### 6.1 Firestore Security Rules
*   **User Data:** 本人のみ読み書き可 (ポイント等の資産フィールドは書き込み禁止)。
*   **Group Data:** members 配列に含まれるUIDのみ読み書き可。
*   **Task Data:** グループメンバーのみ読み書き可。

### 6.2 Remote Config (緊急制御)
*   **min_required_version:** 文字列 (例: "1.0.2")。これ未満のアプリは操作ブロック。
*   **is_maintenance_mode:** Boolean。Trueならメンテ画面を表示。

## 7. 外部サービス連携

### 7.1 RevenueCat (課金)
*   **Product:** ad_free_lifetime (¥480 / Non-Consumable)。
*   **Logic:** 購入状態 (entitlements.active) を監視し、バナー広告Widgetを非表示にする。

### 7.2 AdMob (広告)
*   **Banner:** タスクリスト画面下部。
*   **Rewarded:** ガチャ画面にてポイント不足時または任意視聴ボタンとして配置。