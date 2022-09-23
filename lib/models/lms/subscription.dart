import 'package:json_annotation/json_annotation.dart';
// ignore: unused_import
import 'package:lentera_ilmu/models/lms/course_module.dart';
import 'package:lentera_ilmu/models/lms/subscription_item.dart';
import 'package:lentera_ilmu/models/lms/subscription_price.dart';
// ignore: unused_import
import 'package:lentera_ilmu/models/lms/user_course.dart';
import 'package:lentera_ilmu/models/lms/user_subscription.dart';
// ignore: unused_import
import 'package:lentera_ilmu/models/lms/sharing_fee.dart';

part 'subscription.g.dart';

@JsonSerializable()
class SubscriptionModel {
  final int id;
  // ignore: non_constant_identifier_names
  final int mentor_id;
  // ignore: non_constant_identifier_names
  final String mentor_name;
  final String name;
  final String descriptions;
  final String? thumbnail;
  final String? image;
  // ignore: non_constant_identifier_names
  final String? group_link;
  // ignore: non_constant_identifier_names
  final String? created_by;
  // ignore: non_constant_identifier_names
  final List<SubscriptionItemModel>? subscription_items;
  // ignore: non_constant_identifier_names
  final List<SubscriptionPriceModel>? subscription_prices;
  // ignore: non_constant_identifier_names
  final UserSubscriptionModel? user_subscription;

  const SubscriptionModel({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.mentor_id,
    // ignore: non_constant_identifier_names
    required this.mentor_name,
    required this.name,
    required this.descriptions,
    this.image,
    // ignore: non_constant_identifier_names
    this.group_link,
    this.thumbnail,
    // ignore: non_constant_identifier_names
    this.created_by,
    // ignore: non_constant_identifier_names
    this.subscription_items,
    // ignore: non_constant_identifier_names
    required this.subscription_prices,
    // ignore: non_constant_identifier_names
    this.user_subscription,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);
}
