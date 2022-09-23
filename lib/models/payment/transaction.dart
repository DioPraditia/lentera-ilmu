import 'package:json_annotation/json_annotation.dart';
// ignore: unused_import
import 'package:lentera_ilmu/models/lms/course.dart';

part 'transaction.g.dart';

@JsonSerializable()
class TransactionModel {
  final int id;
  // ignore: non_constant_identifier_names
  final String trx_code;
  // ignore: non_constant_identifier_names
  final String trx_type;
  // ignore: non_constant_identifier_names
  final int user_id;
  // ignore: non_constant_identifier_names
  final String user_name;
  // ignore: non_constant_identifier_names
  final String user_phone;
  // ignore: non_constant_identifier_names
  final String? referral_code;
  // ignore: non_constant_identifier_names
  final String payment_partner;
  // ignore: non_constant_identifier_names
  final String payment_type;
  // ignore: non_constant_identifier_names
  final String payment_provider;
  // ignore: non_constant_identifier_names
  final String payment_account_number;
  // ignore: non_constant_identifier_names
  final String payment_account_holder;
  // ignore: non_constant_identifier_names
  final String payment_expired;
  // ignore: non_constant_identifier_names
  final String payment_status;
  // ignore: non_constant_identifier_names
  final String base_price;
  // ignore: non_constant_identifier_names
  final String platform_fee;
  // ignore: non_constant_identifier_names
  final String bank_fee;
  // ignore: non_constant_identifier_names
  final int unique_number;
  final String discount;
  // ignore: non_constant_identifier_names
  final String selling_price;
  // ignore: non_constant_identifier_names
  final String created_on;
  final dynamic items;

  const TransactionModel({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.trx_code,
    // ignore: non_constant_identifier_names
    required this.trx_type,
    // ignore: non_constant_identifier_names
    required this.user_id,
    // ignore: non_constant_identifier_names
    required this.user_name,
    // ignore: non_constant_identifier_names
    required this.user_phone,
    // ignore: non_constant_identifier_names
    this.referral_code,
    // ignore: non_constant_identifier_names
    required this.payment_partner,
    // ignore: non_constant_identifier_names
    required this.payment_type,
    // ignore: non_constant_identifier_names
    required this.payment_provider,
    // ignore: non_constant_identifier_names
    required this.payment_account_number,
    // ignore: non_constant_identifier_names
    required this.payment_account_holder,
    // ignore: non_constant_identifier_names
    required this.payment_expired,
    // ignore: non_constant_identifier_names
    required this.payment_status,
    // ignore: non_constant_identifier_names
    required this.base_price,
    // ignore: non_constant_identifier_names
    required this.platform_fee,
    // ignore: non_constant_identifier_names
    required this.bank_fee,
    // ignore: non_constant_identifier_names
    required this.unique_number,
    required this.discount,
    // ignore: non_constant_identifier_names
    required this.selling_price,
    // ignore: non_constant_identifier_names
    required this.created_on,
    required this.items,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
