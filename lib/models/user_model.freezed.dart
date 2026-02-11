// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get groupId => throw _privateConstructorUsedError;
  String get currentSkinId => throw _privateConstructorUsedError;
  List<String> get unlockedSkins => throw _privateConstructorUsedError;
  int get currentPoints => throw _privateConstructorUsedError;
  int get ticketCount => throw _privateConstructorUsedError;
  int get adWatchCount => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastAdWatchedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;
  String? get fcmToken => throw _privateConstructorUsedError;
  bool get isPushEnabled => throw _privateConstructorUsedError;
  bool get isSoundEnabled => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call({
    String uid,
    String name,
    String? groupId,
    String currentSkinId,
    List<String> unlockedSkins,
    int currentPoints,
    int ticketCount,
    int adWatchCount,
    @TimestampConverter() DateTime? lastAdWatchedAt,
    @TimestampConverter() DateTime? lastLoginAt,
    String? fcmToken,
    bool isPushEnabled,
    bool isSoundEnabled,
    String status,
    @TimestampConverter() DateTime? deletedAt,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? groupId = freezed,
    Object? currentSkinId = null,
    Object? unlockedSkins = null,
    Object? currentPoints = null,
    Object? ticketCount = null,
    Object? adWatchCount = null,
    Object? lastAdWatchedAt = freezed,
    Object? lastLoginAt = freezed,
    Object? fcmToken = freezed,
    Object? isPushEnabled = null,
    Object? isSoundEnabled = null,
    Object? status = null,
    Object? deletedAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            uid: null == uid
                ? _value.uid
                : uid // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            groupId: freezed == groupId
                ? _value.groupId
                : groupId // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentSkinId: null == currentSkinId
                ? _value.currentSkinId
                : currentSkinId // ignore: cast_nullable_to_non_nullable
                      as String,
            unlockedSkins: null == unlockedSkins
                ? _value.unlockedSkins
                : unlockedSkins // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            currentPoints: null == currentPoints
                ? _value.currentPoints
                : currentPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            ticketCount: null == ticketCount
                ? _value.ticketCount
                : ticketCount // ignore: cast_nullable_to_non_nullable
                      as int,
            adWatchCount: null == adWatchCount
                ? _value.adWatchCount
                : adWatchCount // ignore: cast_nullable_to_non_nullable
                      as int,
            lastAdWatchedAt: freezed == lastAdWatchedAt
                ? _value.lastAdWatchedAt
                : lastAdWatchedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastLoginAt: freezed == lastLoginAt
                ? _value.lastLoginAt
                : lastLoginAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            fcmToken: freezed == fcmToken
                ? _value.fcmToken
                : fcmToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPushEnabled: null == isPushEnabled
                ? _value.isPushEnabled
                : isPushEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSoundEnabled: null == isSoundEnabled
                ? _value.isSoundEnabled
                : isSoundEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            deletedAt: freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uid,
    String name,
    String? groupId,
    String currentSkinId,
    List<String> unlockedSkins,
    int currentPoints,
    int ticketCount,
    int adWatchCount,
    @TimestampConverter() DateTime? lastAdWatchedAt,
    @TimestampConverter() DateTime? lastLoginAt,
    String? fcmToken,
    bool isPushEnabled,
    bool isSoundEnabled,
    String status,
    @TimestampConverter() DateTime? deletedAt,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? groupId = freezed,
    Object? currentSkinId = null,
    Object? unlockedSkins = null,
    Object? currentPoints = null,
    Object? ticketCount = null,
    Object? adWatchCount = null,
    Object? lastAdWatchedAt = freezed,
    Object? lastLoginAt = freezed,
    Object? fcmToken = freezed,
    Object? isPushEnabled = null,
    Object? isSoundEnabled = null,
    Object? status = null,
    Object? deletedAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$UserModelImpl(
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        groupId: freezed == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentSkinId: null == currentSkinId
            ? _value.currentSkinId
            : currentSkinId // ignore: cast_nullable_to_non_nullable
                  as String,
        unlockedSkins: null == unlockedSkins
            ? _value._unlockedSkins
            : unlockedSkins // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        currentPoints: null == currentPoints
            ? _value.currentPoints
            : currentPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        ticketCount: null == ticketCount
            ? _value.ticketCount
            : ticketCount // ignore: cast_nullable_to_non_nullable
                  as int,
        adWatchCount: null == adWatchCount
            ? _value.adWatchCount
            : adWatchCount // ignore: cast_nullable_to_non_nullable
                  as int,
        lastAdWatchedAt: freezed == lastAdWatchedAt
            ? _value.lastAdWatchedAt
            : lastAdWatchedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastLoginAt: freezed == lastLoginAt
            ? _value.lastLoginAt
            : lastLoginAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        fcmToken: freezed == fcmToken
            ? _value.fcmToken
            : fcmToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPushEnabled: null == isPushEnabled
            ? _value.isPushEnabled
            : isPushEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSoundEnabled: null == isSoundEnabled
            ? _value.isSoundEnabled
            : isSoundEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        deletedAt: freezed == deletedAt
            ? _value.deletedAt
            : deletedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl({
    required this.uid,
    required this.name,
    required this.groupId,
    this.currentSkinId = 'skin_default',
    final List<String> unlockedSkins = const ['skin_default', 'skin_crown'],
    this.currentPoints = 0,
    this.ticketCount = 0,
    this.adWatchCount = 0,
    @TimestampConverter() this.lastAdWatchedAt,
    @TimestampConverter() this.lastLoginAt,
    this.fcmToken,
    this.isPushEnabled = true,
    this.isSoundEnabled = true,
    this.status = 'active',
    @TimestampConverter() this.deletedAt,
    @TimestampConverter() required this.createdAt,
  }) : _unlockedSkins = unlockedSkins;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String uid;
  @override
  final String name;
  @override
  final String? groupId;
  @override
  @JsonKey()
  final String currentSkinId;
  final List<String> _unlockedSkins;
  @override
  @JsonKey()
  List<String> get unlockedSkins {
    if (_unlockedSkins is EqualUnmodifiableListView) return _unlockedSkins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unlockedSkins);
  }

  @override
  @JsonKey()
  final int currentPoints;
  @override
  @JsonKey()
  final int ticketCount;
  @override
  @JsonKey()
  final int adWatchCount;
  @override
  @TimestampConverter()
  final DateTime? lastAdWatchedAt;
  @override
  @TimestampConverter()
  final DateTime? lastLoginAt;
  @override
  final String? fcmToken;
  @override
  @JsonKey()
  final bool isPushEnabled;
  @override
  @JsonKey()
  final bool isSoundEnabled;
  @override
  @JsonKey()
  final String status;
  @override
  @TimestampConverter()
  final DateTime? deletedAt;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, groupId: $groupId, currentSkinId: $currentSkinId, unlockedSkins: $unlockedSkins, currentPoints: $currentPoints, ticketCount: $ticketCount, adWatchCount: $adWatchCount, lastAdWatchedAt: $lastAdWatchedAt, lastLoginAt: $lastLoginAt, fcmToken: $fcmToken, isPushEnabled: $isPushEnabled, isSoundEnabled: $isSoundEnabled, status: $status, deletedAt: $deletedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.currentSkinId, currentSkinId) ||
                other.currentSkinId == currentSkinId) &&
            const DeepCollectionEquality().equals(
              other._unlockedSkins,
              _unlockedSkins,
            ) &&
            (identical(other.currentPoints, currentPoints) ||
                other.currentPoints == currentPoints) &&
            (identical(other.ticketCount, ticketCount) ||
                other.ticketCount == ticketCount) &&
            (identical(other.adWatchCount, adWatchCount) ||
                other.adWatchCount == adWatchCount) &&
            (identical(other.lastAdWatchedAt, lastAdWatchedAt) ||
                other.lastAdWatchedAt == lastAdWatchedAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.isPushEnabled, isPushEnabled) ||
                other.isPushEnabled == isPushEnabled) &&
            (identical(other.isSoundEnabled, isSoundEnabled) ||
                other.isSoundEnabled == isSoundEnabled) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    uid,
    name,
    groupId,
    currentSkinId,
    const DeepCollectionEquality().hash(_unlockedSkins),
    currentPoints,
    ticketCount,
    adWatchCount,
    lastAdWatchedAt,
    lastLoginAt,
    fcmToken,
    isPushEnabled,
    isSoundEnabled,
    status,
    deletedAt,
    createdAt,
  );

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel({
    required final String uid,
    required final String name,
    required final String? groupId,
    final String currentSkinId,
    final List<String> unlockedSkins,
    final int currentPoints,
    final int ticketCount,
    final int adWatchCount,
    @TimestampConverter() final DateTime? lastAdWatchedAt,
    @TimestampConverter() final DateTime? lastLoginAt,
    final String? fcmToken,
    final bool isPushEnabled,
    final bool isSoundEnabled,
    final String status,
    @TimestampConverter() final DateTime? deletedAt,
    @TimestampConverter() required final DateTime createdAt,
  }) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get uid;
  @override
  String get name;
  @override
  String? get groupId;
  @override
  String get currentSkinId;
  @override
  List<String> get unlockedSkins;
  @override
  int get currentPoints;
  @override
  int get ticketCount;
  @override
  int get adWatchCount;
  @override
  @TimestampConverter()
  DateTime? get lastAdWatchedAt;
  @override
  @TimestampConverter()
  DateTime? get lastLoginAt;
  @override
  String? get fcmToken;
  @override
  bool get isPushEnabled;
  @override
  bool get isSoundEnabled;
  @override
  String get status;
  @override
  @TimestampConverter()
  DateTime? get deletedAt;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
