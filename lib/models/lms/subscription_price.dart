// ignore: duplicate_ignore
// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import 'package:lentera_ilmu/models/lms/course_module.dart';
import 'package:lentera_ilmu/models/lms/user_course.dart';
import 'package:lentera_ilmu/models/lms/sharing_fee.dart';

part 'subscription_price.g.dart';

@JsonSerializable()
class SubscriptionPriceModel {
  final int id;
  final int subscription_id;
  final String subscription_name;
  final int subscription_month;
  final String base_price;
  final String selling_price;

  const SubscriptionPriceModel({
    required this.id,
    required this.subscription_id,
    required this.subscription_name,
    required this.subscription_month,
    required this.base_price,
    required this.selling_price,
  });

  factory SubscriptionPriceModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionPriceModelToJson(this);
}
