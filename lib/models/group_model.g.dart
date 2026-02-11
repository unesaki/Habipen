// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupModelImpl _$$GroupModelImplFromJson(
  Map<String, dynamic> json,
) => _$GroupModelImpl(
  groupId: json['groupId'] as String,
  members: (json['members'] as List<dynamic>).map((e) => e as String).toList(),
  inviteId: json['inviteId'] as String,
  taskCount: (json['taskCount'] as num?)?.toInt() ?? 0,
  createdAt: const TimestampConverter().fromJson(json['createdAt'] as Object),
);

Map<String, dynamic> _$$GroupModelImplToJson(_$GroupModelImpl instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'members': instance.members,
      'inviteId': instance.inviteId,
      'taskCount': instance.taskCount,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
