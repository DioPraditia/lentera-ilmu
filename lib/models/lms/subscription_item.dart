// ignore_for_file: unused_import

import 'package:json_annotation/json_annotation.dart';
import 'package:lentera_ilmu/models/lms/course_module.dart';
import 'package:lentera_ilmu/models/lms/user_course.dart';
import 'package:lentera_ilmu/models/lms/sharing_fee.dart';

part 'subscription_item.g.dart';

@JsonSerializable()
class SubscriptionItemModel {
  final int id;
  // ignore: non_constant_identifier_names
  final int subscription_id;
  // ignore: non_constant_identifier_names
  final String subscription_name;
  // ignore: non_constant_identifier_names
  final String item_type;
  final String name;
  final String descriptions;
  // ignore: non_constant_identifier_names
  final int? course_id;
  // ignore: non_constant_identifier_names
  final String? course_name;
  // ignore: non_constant_identifier_names
  final String? activity_date;
  // ignore: non_constant_identifier_names
  final String? activity_location;
  // ignore: non_constant_identifier_names
  final int mentor_id;
  // ignore: non_constant_identifier_names
  final String mentor_name;
  final String? thumbnail;
  final int sequence;
  // ignore: non_constant_identifier_names
  final String? created_by;

  const SubscriptionItemModel({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.subscription_id,
    // ignore: non_constant_identifier_names
    required this.subscription_name,
    // ignore: non_constant_identifier_names
    required this.item_type,
    required this.name,
    required this.descriptions,
    // ignore: non_constant_identifier_names
    required this.course_id,
    // ignore: non_constant_identifier_names
    required this.course_name,
    // ignore: non_constant_identifier_names
    this.activity_date,
    // ignore: non_constant_identifier_names
    this.activity_location,
    // ignore: non_constant_identifier_names
    required this.mentor_id,
    // ignore: non_constant_identifier_names
    required this.mentor_name,
    required this.thumbnail,
    required this.sequence,
    // ignore: non_constant_identifier_names
    this.created_by,
  });

  factory SubscriptionItemModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionItemModelToJson(this);
}
