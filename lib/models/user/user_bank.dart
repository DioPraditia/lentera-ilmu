// ignore: unused_import
import 'package:lentera_ilmu/models/user/session.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_bank.g.dart';

@JsonSerializable()
class UserBankModel {
  final int id;
  // ignore: non_constant_identifier_names
  final int user_id;
  // ignore: non_constant_identifier_names
  final String bank_code;
  // ignore: non_constant_identifier_names
  final String bank_name;
  // ignore: non_constant_identifier_names
  final String bank_icon;
  // ignore: non_constant_identifier_names
  final String account_holder;
  // ignore: non_constant_identifier_names
  final String account_number;

  const UserBankModel({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.user_id,
    // ignore: non_constant_identifier_names
    required this.bank_code,
    // ignore: non_constant_identifier_names
    required this.bank_name,
    // ignore: non_constant_identifier_names
    required this.bank_icon,
    // ignore: non_constant_identifier_names
    required this.account_holder,
    // ignore: non_constant_identifier_names
    required this.account_number,
  });
  factory UserBankModel.fromJson(Map<String, dynamic> json) =>
      _$UserBankModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserBankModelToJson(this);
}
