import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String? photo;
  // ignore: non_constant_identifier_names
  final String account_kyc;
  // ignore: non_constant_identifier_names
  final String account_status;
  // ignore: non_constant_identifier_names
  final String? referral_code;
  // ignore: non_constant_identifier_names
  final String subscription_status;
  // ignore: non_constant_identifier_names
  final String? subscription_until_date;
  // ignore: non_constant_identifier_names
  final int? total_direct_users;
  // ignore: non_constant_identifier_names
  final int phone_verified;
  // ignore: non_constant_identifier_names
  final int email_verified;

  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.photo,
    // ignore: non_constant_identifier_names
    required this.account_kyc,
    // ignore: non_constant_identifier_names
    required this.account_status,
    // ignore: non_constant_identifier_names
    this.referral_code,
    // ignore: non_constant_identifier_names
    required this.subscription_status,
    // ignore: non_constant_identifier_names
    this.subscription_until_date,
    // ignore: non_constant_identifier_names
    this.total_direct_users,
    // ignore: non_constant_identifier_names
    required this.phone_verified,
    // ignore: non_constant_identifier_names
    required this.email_verified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
