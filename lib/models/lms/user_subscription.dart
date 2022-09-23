import 'package:json_annotation/json_annotation.dart';
import 'package:lentera_ilmu/models/lms/subscription.dart';

part 'user_subscription.g.dart';

@JsonSerializable()
class UserSubscriptionModel {
  final int id;
  // ignore: non_constant_identifier_names
  final int user_id;
  // ignore: non_constant_identifier_names
  final int subscription_id;
  // ignore: non_constant_identifier_names
  final String subscription_name;
  // ignore: non_constant_identifier_names
  final String enroll_date;
  // ignore: non_constant_identifier_names
  final String valid_until;
  final String status;
  // ignore: non_constant_identifier_names
  final SubscriptionModel? subscription_product;

  const UserSubscriptionModel({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.user_id,
    // ignore: non_constant_identifier_names
    required this.subscription_id,
    // ignore: non_constant_identifier_names
    required this.subscription_name,
    // ignore: non_constant_identifier_names
    required this.enroll_date,
    // ignore: non_constant_identifier_names
    required this.valid_until,
    required this.status,
    // ignore: non_constant_identifier_names
    this.subscription_product,
  });

  factory UserSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserSubscriptionModelToJson(this);
}
