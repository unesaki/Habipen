import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

// Custom converter for Firestore Timestamp to DateTime
class TimestampConverter implements JsonConverter<DateTime, Object> {
  const TimestampConverter();

  @override
  DateTime fromJson(Object json) {
    if (json is Timestamp) {
      return json.toDate();
    } else if (json is String) {
      return DateTime.parse(json);
    }
    return DateTime.now();
  }

  @override
  Object toJson(DateTime date) => Timestamp.fromDate(date);
}

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    required String name,
    required String? groupId,
    @Default('skin_default') String currentSkinId,
    @Default(['skin_default', 'skin_crown']) List<String> unlockedSkins,
    @Default(0) int currentPoints,
    @Default(0) int ticketCount,
    @Default(0) int adWatchCount,
    @TimestampConverter() DateTime? lastAdWatchedAt,
    @TimestampConverter() DateTime? lastLoginAt,
    String? fcmToken,
    @Default(true) bool isPushEnabled,
    @Default(true) bool isSoundEnabled,
    @Default('active') String status,
    @TimestampConverter() DateTime? deletedAt,
    @TimestampConverter() required DateTime createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
