// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      groupId: json['groupId'] as String?,
      currentSkinId: json['currentSkinId'] as String? ?? 'skin_default',
      unlockedSkins:
          (json['unlockedSkins'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ['skin_default', 'skin_crown'],
      currentPoints: (json['currentPoints'] as num?)?.toInt() ?? 0,
      ticketCount: (json['ticketCount'] as num?)?.toInt() ?? 0,
      adWatchCount: (json['adWatchCount'] as num?)?.toInt() ?? 0,
      lastAdWatchedAt: _$JsonConverterFromJson<Object, DateTime>(
        json['lastAdWatchedAt'],
        const TimestampConverter().fromJson,
      ),
      lastLoginAt: _$JsonConverterFromJson<Object, DateTime>(
        json['lastLoginAt'],
        const TimestampConverter().fromJson,
      ),
      fcmToken: json['fcmToken'] as String?,
      isPushEnabled: json['isPushEnabled'] as bool? ?? true,
      isSoundEnabled: json['isSoundEnabled'] as bool? ?? true,
      status: json['status'] as String? ?? 'active',
      deletedAt: _$JsonConverterFromJson<Object, DateTime>(
        json['deletedAt'],
        const TimestampConverter().fromJson,
      ),
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Object,
      ),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'groupId': instance.groupId,
      'currentSkinId': instance.currentSkinId,
      'unlockedSkins': instance.unlockedSkins,
      'currentPoints': instance.currentPoints,
      'ticketCount': instance.ticketCount,
      'adWatchCount': instance.adWatchCount,
      'lastAdWatchedAt': _$JsonConverterToJson<Object, DateTime>(
        instance.lastAdWatchedAt,
        const TimestampConverter().toJson,
      ),
      'lastLoginAt': _$JsonConverterToJson<Object, DateTime>(
        instance.lastLoginAt,
        const TimestampConverter().toJson,
      ),
      'fcmToken': instance.fcmToken,
      'isPushEnabled': instance.isPushEnabled,
      'isSoundEnabled': instance.isSoundEnabled,
      'status': instance.status,
      'deletedAt': _$JsonConverterToJson<Object, DateTime>(
        instance.deletedAt,
        const TimestampConverter().toJson,
      ),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
