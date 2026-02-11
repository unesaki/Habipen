import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_model.dart'; // Import TimestampConverter

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class RepeatRule with _$RepeatRule {
  @JsonSerializable(explicitToJson: true)
  const factory RepeatRule({
    required String type, // 'daily', 'weekly', 'monthly', 'none'
    @Default([]) List<int> weekdays, // 1=Mon, 7=Sun
  }) = _RepeatRule;

  factory RepeatRule.fromJson(Map<String, dynamic> json) =>
      _$RepeatRuleFromJson(json);
}

@freezed
class TaskModel with _$TaskModel {
  @JsonSerializable(explicitToJson: true)
  const factory TaskModel({
    required String taskId,
    required String title,
    @Default('') String description,
    required String categoryId, // Icon ID
    @Default('その他') String categoryName, // User defined name or default
    String? assigneeId,
    required String createdBy,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime dueDate,
    RepeatRule? repeatRule,
    @Default(false) bool isCompleted,
    String? completedBy,
    @TimestampConverter() DateTime? completedAt,
    @TimestampConverter() DateTime? lastNudgedAt,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
