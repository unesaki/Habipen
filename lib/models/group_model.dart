import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_model.dart'; // Import TimestampConverter

part 'group_model.freezed.dart';
part 'group_model.g.dart';

@freezed
class GroupModel with _$GroupModel {
  const factory GroupModel({
    required String groupId,
    required List<String> members,
    required String inviteId,
    @Default(0) int taskCount,
    @TimestampConverter() required DateTime createdAt,
  }) = _GroupModel;

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);
}
