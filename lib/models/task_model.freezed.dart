// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RepeatRule _$RepeatRuleFromJson(Map<String, dynamic> json) {
  return _RepeatRule.fromJson(json);
}

/// @nodoc
mixin _$RepeatRule {
  String get type =>
      throw _privateConstructorUsedError; // 'daily', 'weekly', 'monthly', 'none'
  List<int> get weekdays => throw _privateConstructorUsedError;

  /// Serializes this RepeatRule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RepeatRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RepeatRuleCopyWith<RepeatRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepeatRuleCopyWith<$Res> {
  factory $RepeatRuleCopyWith(
    RepeatRule value,
    $Res Function(RepeatRule) then,
  ) = _$RepeatRuleCopyWithImpl<$Res, RepeatRule>;
  @useResult
  $Res call({String type, List<int> weekdays});
}

/// @nodoc
class _$RepeatRuleCopyWithImpl<$Res, $Val extends RepeatRule>
    implements $RepeatRuleCopyWith<$Res> {
  _$RepeatRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RepeatRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? weekdays = null}) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            weekdays: null == weekdays
                ? _value.weekdays
                : weekdays // ignore: cast_nullable_to_non_nullable
                      as List<int>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RepeatRuleImplCopyWith<$Res>
    implements $RepeatRuleCopyWith<$Res> {
  factory _$$RepeatRuleImplCopyWith(
    _$RepeatRuleImpl value,
    $Res Function(_$RepeatRuleImpl) then,
  ) = __$$RepeatRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, List<int> weekdays});
}

/// @nodoc
class __$$RepeatRuleImplCopyWithImpl<$Res>
    extends _$RepeatRuleCopyWithImpl<$Res, _$RepeatRuleImpl>
    implements _$$RepeatRuleImplCopyWith<$Res> {
  __$$RepeatRuleImplCopyWithImpl(
    _$RepeatRuleImpl _value,
    $Res Function(_$RepeatRuleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RepeatRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? weekdays = null}) {
    return _then(
      _$RepeatRuleImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        weekdays: null == weekdays
            ? _value._weekdays
            : weekdays // ignore: cast_nullable_to_non_nullable
                  as List<int>,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$RepeatRuleImpl implements _RepeatRule {
  const _$RepeatRuleImpl({
    required this.type,
    final List<int> weekdays = const [],
  }) : _weekdays = weekdays;

  factory _$RepeatRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepeatRuleImplFromJson(json);

  @override
  final String type;
  // 'daily', 'weekly', 'monthly', 'none'
  final List<int> _weekdays;
  // 'daily', 'weekly', 'monthly', 'none'
  @override
  @JsonKey()
  List<int> get weekdays {
    if (_weekdays is EqualUnmodifiableListView) return _weekdays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weekdays);
  }

  @override
  String toString() {
    return 'RepeatRule(type: $type, weekdays: $weekdays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepeatRuleImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._weekdays, _weekdays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    const DeepCollectionEquality().hash(_weekdays),
  );

  /// Create a copy of RepeatRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepeatRuleImplCopyWith<_$RepeatRuleImpl> get copyWith =>
      __$$RepeatRuleImplCopyWithImpl<_$RepeatRuleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RepeatRuleImplToJson(this);
  }
}

abstract class _RepeatRule implements RepeatRule {
  const factory _RepeatRule({
    required final String type,
    final List<int> weekdays,
  }) = _$RepeatRuleImpl;

  factory _RepeatRule.fromJson(Map<String, dynamic> json) =
      _$RepeatRuleImpl.fromJson;

  @override
  String get type; // 'daily', 'weekly', 'monthly', 'none'
  @override
  List<int> get weekdays;

  /// Create a copy of RepeatRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepeatRuleImplCopyWith<_$RepeatRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) {
  return _TaskModel.fromJson(json);
}

/// @nodoc
mixin _$TaskModel {
  String get taskId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError; // Icon ID
  String get categoryName =>
      throw _privateConstructorUsedError; // User defined name or default
  String? get assigneeId => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get dueDate => throw _privateConstructorUsedError;
  RepeatRule? get repeatRule => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  String? get completedBy => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get completedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastNudgedAt => throw _privateConstructorUsedError;

  /// Serializes this TaskModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskModelCopyWith<TaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskModelCopyWith<$Res> {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) then) =
      _$TaskModelCopyWithImpl<$Res, TaskModel>;
  @useResult
  $Res call({
    String taskId,
    String title,
    String description,
    String categoryId,
    String categoryName,
    String? assigneeId,
    String createdBy,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime dueDate,
    RepeatRule? repeatRule,
    bool isCompleted,
    String? completedBy,
    @TimestampConverter() DateTime? completedAt,
    @TimestampConverter() DateTime? lastNudgedAt,
  });

  $RepeatRuleCopyWith<$Res>? get repeatRule;
}

/// @nodoc
class _$TaskModelCopyWithImpl<$Res, $Val extends TaskModel>
    implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? title = null,
    Object? description = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? assigneeId = freezed,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? dueDate = null,
    Object? repeatRule = freezed,
    Object? isCompleted = null,
    Object? completedBy = freezed,
    Object? completedAt = freezed,
    Object? lastNudgedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            taskId: null == taskId
                ? _value.taskId
                : taskId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            assigneeId: freezed == assigneeId
                ? _value.assigneeId
                : assigneeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            dueDate: null == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            repeatRule: freezed == repeatRule
                ? _value.repeatRule
                : repeatRule // ignore: cast_nullable_to_non_nullable
                      as RepeatRule?,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            completedBy: freezed == completedBy
                ? _value.completedBy
                : completedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastNudgedAt: freezed == lastNudgedAt
                ? _value.lastNudgedAt
                : lastNudgedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RepeatRuleCopyWith<$Res>? get repeatRule {
    if (_value.repeatRule == null) {
      return null;
    }

    return $RepeatRuleCopyWith<$Res>(_value.repeatRule!, (value) {
      return _then(_value.copyWith(repeatRule: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaskModelImplCopyWith<$Res>
    implements $TaskModelCopyWith<$Res> {
  factory _$$TaskModelImplCopyWith(
    _$TaskModelImpl value,
    $Res Function(_$TaskModelImpl) then,
  ) = __$$TaskModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String taskId,
    String title,
    String description,
    String categoryId,
    String categoryName,
    String? assigneeId,
    String createdBy,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime dueDate,
    RepeatRule? repeatRule,
    bool isCompleted,
    String? completedBy,
    @TimestampConverter() DateTime? completedAt,
    @TimestampConverter() DateTime? lastNudgedAt,
  });

  @override
  $RepeatRuleCopyWith<$Res>? get repeatRule;
}

/// @nodoc
class __$$TaskModelImplCopyWithImpl<$Res>
    extends _$TaskModelCopyWithImpl<$Res, _$TaskModelImpl>
    implements _$$TaskModelImplCopyWith<$Res> {
  __$$TaskModelImplCopyWithImpl(
    _$TaskModelImpl _value,
    $Res Function(_$TaskModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? title = null,
    Object? description = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? assigneeId = freezed,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? dueDate = null,
    Object? repeatRule = freezed,
    Object? isCompleted = null,
    Object? completedBy = freezed,
    Object? completedAt = freezed,
    Object? lastNudgedAt = freezed,
  }) {
    return _then(
      _$TaskModelImpl(
        taskId: null == taskId
            ? _value.taskId
            : taskId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        assigneeId: freezed == assigneeId
            ? _value.assigneeId
            : assigneeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        dueDate: null == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        repeatRule: freezed == repeatRule
            ? _value.repeatRule
            : repeatRule // ignore: cast_nullable_to_non_nullable
                  as RepeatRule?,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        completedBy: freezed == completedBy
            ? _value.completedBy
            : completedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastNudgedAt: freezed == lastNudgedAt
            ? _value.lastNudgedAt
            : lastNudgedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TaskModelImpl implements _TaskModel {
  const _$TaskModelImpl({
    required this.taskId,
    required this.title,
    this.description = '',
    required this.categoryId,
    this.categoryName = 'その他',
    this.assigneeId,
    required this.createdBy,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() required this.dueDate,
    this.repeatRule,
    this.isCompleted = false,
    this.completedBy,
    @TimestampConverter() this.completedAt,
    @TimestampConverter() this.lastNudgedAt,
  });

  factory _$TaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskModelImplFromJson(json);

  @override
  final String taskId;
  @override
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  final String categoryId;
  // Icon ID
  @override
  @JsonKey()
  final String categoryName;
  // User defined name or default
  @override
  final String? assigneeId;
  @override
  final String createdBy;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime dueDate;
  @override
  final RepeatRule? repeatRule;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final String? completedBy;
  @override
  @TimestampConverter()
  final DateTime? completedAt;
  @override
  @TimestampConverter()
  final DateTime? lastNudgedAt;

  @override
  String toString() {
    return 'TaskModel(taskId: $taskId, title: $title, description: $description, categoryId: $categoryId, categoryName: $categoryName, assigneeId: $assigneeId, createdBy: $createdBy, createdAt: $createdAt, dueDate: $dueDate, repeatRule: $repeatRule, isCompleted: $isCompleted, completedBy: $completedBy, completedAt: $completedAt, lastNudgedAt: $lastNudgedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskModelImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.assigneeId, assigneeId) ||
                other.assigneeId == assigneeId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.repeatRule, repeatRule) ||
                other.repeatRule == repeatRule) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedBy, completedBy) ||
                other.completedBy == completedBy) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.lastNudgedAt, lastNudgedAt) ||
                other.lastNudgedAt == lastNudgedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    taskId,
    title,
    description,
    categoryId,
    categoryName,
    assigneeId,
    createdBy,
    createdAt,
    dueDate,
    repeatRule,
    isCompleted,
    completedBy,
    completedAt,
    lastNudgedAt,
  );

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      __$$TaskModelImplCopyWithImpl<_$TaskModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskModelImplToJson(this);
  }
}

abstract class _TaskModel implements TaskModel {
  const factory _TaskModel({
    required final String taskId,
    required final String title,
    final String description,
    required final String categoryId,
    final String categoryName,
    final String? assigneeId,
    required final String createdBy,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() required final DateTime dueDate,
    final RepeatRule? repeatRule,
    final bool isCompleted,
    final String? completedBy,
    @TimestampConverter() final DateTime? completedAt,
    @TimestampConverter() final DateTime? lastNudgedAt,
  }) = _$TaskModelImpl;

  factory _TaskModel.fromJson(Map<String, dynamic> json) =
      _$TaskModelImpl.fromJson;

  @override
  String get taskId;
  @override
  String get title;
  @override
  String get description;
  @override
  String get categoryId; // Icon ID
  @override
  String get categoryName; // User defined name or default
  @override
  String? get assigneeId;
  @override
  String get createdBy;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get dueDate;
  @override
  RepeatRule? get repeatRule;
  @override
  bool get isCompleted;
  @override
  String? get completedBy;
  @override
  @TimestampConverter()
  DateTime? get completedAt;
  @override
  @TimestampConverter()
  DateTime? get lastNudgedAt;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
