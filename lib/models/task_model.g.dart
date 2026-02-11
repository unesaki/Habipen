// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepeatRuleImpl _$$RepeatRuleImplFromJson(Map<String, dynamic> json) =>
    _$RepeatRuleImpl(
      type: json['type'] as String,
      weekdays:
          (json['weekdays'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RepeatRuleImplToJson(_$RepeatRuleImpl instance) =>
    <String, dynamic>{'type': instance.type, 'weekdays': instance.weekdays};

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      taskId: json['taskId'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String? ?? 'その他',
      assigneeId: json['assigneeId'] as String?,
      createdBy: json['createdBy'] as String,
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Object,
      ),
      dueDate: const TimestampConverter().fromJson(json['dueDate'] as Object),
      repeatRule: json['repeatRule'] == null
          ? null
          : RepeatRule.fromJson(json['repeatRule'] as Map<String, dynamic>),
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedBy: json['completedBy'] as String?,
      completedAt: _$JsonConverterFromJson<Object, DateTime>(
        json['completedAt'],
        const TimestampConverter().fromJson,
      ),
      lastNudgedAt: _$JsonConverterFromJson<Object, DateTime>(
        json['lastNudgedAt'],
        const TimestampConverter().fromJson,
      ),
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'title': instance.title,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'assigneeId': instance.assigneeId,
      'createdBy': instance.createdBy,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'dueDate': const TimestampConverter().toJson(instance.dueDate),
      'repeatRule': instance.repeatRule?.toJson(),
      'isCompleted': instance.isCompleted,
      'completedBy': instance.completedBy,
      'completedAt': _$JsonConverterToJson<Object, DateTime>(
        instance.completedAt,
        const TimestampConverter().toJson,
      ),
      'lastNudgedAt': _$JsonConverterToJson<Object, DateTime>(
        instance.lastNudgedAt,
        const TimestampConverter().toJson,
      ),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
