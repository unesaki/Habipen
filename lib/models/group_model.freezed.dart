// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) {
  return _GroupModel.fromJson(json);
}

/// @nodoc
mixin _$GroupModel {
  String get groupId => throw _privateConstructorUsedError;
  List<String> get members => throw _privateConstructorUsedError;
  String get inviteId => throw _privateConstructorUsedError;
  int get taskCount => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this GroupModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupModelCopyWith<GroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupModelCopyWith<$Res> {
  factory $GroupModelCopyWith(
    GroupModel value,
    $Res Function(GroupModel) then,
  ) = _$GroupModelCopyWithImpl<$Res, GroupModel>;
  @useResult
  $Res call({
    String groupId,
    List<String> members,
    String inviteId,
    int taskCount,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$GroupModelCopyWithImpl<$Res, $Val extends GroupModel>
    implements $GroupModelCopyWith<$Res> {
  _$GroupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? members = null,
    Object? inviteId = null,
    Object? taskCount = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            groupId: null == groupId
                ? _value.groupId
                : groupId // ignore: cast_nullable_to_non_nullable
                      as String,
            members: null == members
                ? _value.members
                : members // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            inviteId: null == inviteId
                ? _value.inviteId
                : inviteId // ignore: cast_nullable_to_non_nullable
                      as String,
            taskCount: null == taskCount
                ? _value.taskCount
                : taskCount // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$GroupModelImplCopyWith<$Res>
    implements $GroupModelCopyWith<$Res> {
  factory _$$GroupModelImplCopyWith(
    _$GroupModelImpl value,
    $Res Function(_$GroupModelImpl) then,
  ) = __$$GroupModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String groupId,
    List<String> members,
    String inviteId,
    int taskCount,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$GroupModelImplCopyWithImpl<$Res>
    extends _$GroupModelCopyWithImpl<$Res, _$GroupModelImpl>
    implements _$$GroupModelImplCopyWith<$Res> {
  __$$GroupModelImplCopyWithImpl(
    _$GroupModelImpl _value,
    $Res Function(_$GroupModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? members = null,
    Object? inviteId = null,
    Object? taskCount = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$GroupModelImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
        members: null == members
            ? _value._members
            : members // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        inviteId: null == inviteId
            ? _value.inviteId
            : inviteId // ignore: cast_nullable_to_non_nullable
                  as String,
        taskCount: null == taskCount
            ? _value.taskCount
            : taskCount // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$GroupModelImpl implements _GroupModel {
  const _$GroupModelImpl({
    required this.groupId,
    required final List<String> members,
    required this.inviteId,
    this.taskCount = 0,
    @TimestampConverter() required this.createdAt,
  }) : _members = members;

  factory _$GroupModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupModelImplFromJson(json);

  @override
  final String groupId;
  final List<String> _members;
  @override
  List<String> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  final String inviteId;
  @override
  @JsonKey()
  final int taskCount;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'GroupModel(groupId: $groupId, members: $members, inviteId: $inviteId, taskCount: $taskCount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupModelImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.inviteId, inviteId) ||
                other.inviteId == inviteId) &&
            (identical(other.taskCount, taskCount) ||
                other.taskCount == taskCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    groupId,
    const DeepCollectionEquality().hash(_members),
    inviteId,
    taskCount,
    createdAt,
  );

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupModelImplCopyWith<_$GroupModelImpl> get copyWith =>
      __$$GroupModelImplCopyWithImpl<_$GroupModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupModelImplToJson(this);
  }
}

abstract class _GroupModel implements GroupModel {
  const factory _GroupModel({
    required final String groupId,
    required final List<String> members,
    required final String inviteId,
    final int taskCount,
    @TimestampConverter() required final DateTime createdAt,
  }) = _$GroupModelImpl;

  factory _GroupModel.fromJson(Map<String, dynamic> json) =
      _$GroupModelImpl.fromJson;

  @override
  String get groupId;
  @override
  List<String> get members;
  @override
  String get inviteId;
  @override
  int get taskCount;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupModelImplCopyWith<_$GroupModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
