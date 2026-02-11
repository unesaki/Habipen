import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/user_provider.dart';
import '../../core/firestore_repository.dart';
import '../../providers/auth_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  // Local state for UI toggles (normally would persist to shared_preferences)
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;

  Future<void> _launchUrl(BuildContext context, String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _showAccountSettings(BuildContext context, WidgetRef ref) {
    final user = ref.read(userStreamProvider).value;
    if (user == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('アカウント設定'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('名前: ${user.name}'),
            const SizedBox(height: 8),
            SelectableText('ユーザーID:\n${user.uid}'),
            const SizedBox(height: 16),
            const Text('※ アカウント連携機能は現在開発中です。', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('アカウント設定'),
            subtitle: const Text('名前やIDの確認'),
            leading: const Icon(Icons.person),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showAccountSettings(context, ref),
          ),
          SwitchListTile(
            value: _notificationsEnabled,
            title: const Text('通知'),
            secondary: const Icon(Icons.notifications),
            onChanged: (val) {
              setState(() => _notificationsEnabled = val);
            },
          ),
          SwitchListTile(
            value: _soundEnabled,
            title: const Text('効果音'),
            secondary: const Icon(Icons.volume_up),
            onChanged: (val) {
              setState(() => _soundEnabled = val);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('利用規約'),
            leading: const Icon(Icons.description),
            onTap: () => _launchUrl(context, 'https://example.com/terms'),
          ),
          ListTile(
            title: const Text('プライバシーポリシー'),
            leading: const Icon(Icons.privacy_tip),
            onTap: () => _launchUrl(context, 'https://example.com/privacy'),
          ),
          ListTile(
            title: const Text('ライセンス'),
            leading: const Icon(Icons.article),
            onTap: () => showLicensePage(context: context),
          ),
          const AboutListTile(
            icon: Icon(Icons.info),
            applicationName: 'Habit Penguin',
            applicationVersion: '1.2.0',
            applicationLegalese: 'Copyright 2026 Habit Penguin Team',
          ),
          const Divider(),
          ListTile(
            title: const Text('アカウント削除', style: TextStyle(color: Colors.red)),
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            onTap: () => _showDeleteAccountDialog(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteAccountDialog(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('アカウント削除'),
        content: const Text(
          '本当にアカウントを削除しますか？\n'
          'この操作は取り消せません。\n'
          'データは30日後に完全に消去されます。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('削除する'),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      try {
        final user = ref.read(userStreamProvider).value;
        if (user != null) {
          await ref.read(firestoreRepositoryProvider).updateUser(
            user.uid, 
            {'deletedAt': DateTime.now().toIso8601String(), 'status': 'deleted'}
          );
          await ref.read(firebaseAuthProvider).signOut();
          if (context.mounted) {
             // GoRouter redirect should handle auth state change, logic in main.dart
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      }
    }
  }

}
