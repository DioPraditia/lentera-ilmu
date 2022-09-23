import 'package:json_annotation/json_annotation.dart';
import 'package:lentera_ilmu/models/user/notification_data.dart';

part 'notification.g.dart';

@JsonSerializable()
class NotificationModel {
  final int id;
  // ignore: non_constant_identifier_names
  final int? user_id;
  final String title;
  final String message;
  final NotificationDataModel? data;
  final int read;
  // ignore: non_constant_identifier_names
  final String created_on;

  const NotificationModel({
    required this.id,
    // ignore: non_constant_identifier_names
    this.user_id,
    required this.title,
    required this.message,
    this.data,
    required this.read,
    // ignore: non_constant_identifier_names
    required this.created_on,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
