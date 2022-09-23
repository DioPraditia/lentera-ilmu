import 'package:json_annotation/json_annotation.dart';

part 'withdraw_transaction.g.dart';

@JsonSerializable()
class WithdrawTransactionModel {
  final int id;
  // ignore: non_constant_identifier_names
  final String trx_code;
  // ignore: non_constant_identifier_names
  final String? external_id;
  // ignore: non_constant_identifier_names
  final int user_id;
  // ignore: non_constant_identifier_names
  final String user_name;
  // ignore: non_constant_identifier_names
  final String user_phone;
  // ignore: non_constant_identifier_names
  final String eva_type;
  // ignore: non_constant_identifier_names
  final String destination_bank_name;
  // ignore: non_constant_identifier_names
  final String destination_bank_code;
  // ignore: non_constant_identifier_names
  final String? destination_bank_icon;
  // ignore: non_constant_identifier_names
  final int destination_bank_id;
  // ignore: non_constant_identifier_names
  final String destination_account_number;
  // ignore: non_constant_identifier_names
  final String destination_account_holder;
  // ignore: non_constant_identifier_names
  final String request_amount;
  // ignore: non_constant_identifier_names
  final String bank_fee;
  // ignore: non_constant_identifier_names
  final String platform_fee;
  // ignore: non_constant_identifier_names
  final String withdraw_amount;
  final String status;
  // ignore: non_constant_identifier_names
  final String created_on;

  const WithdrawTransactionModel({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.trx_code,
    // ignore: non_constant_identifier_names
    this.external_id,
    // ignore: non_constant_identifier_names
    required this.user_id,
    // ignore: non_constant_identifier_names
    required this.user_name,
    // ignore: non_constant_identifier_names
    required this.user_phone,
    // ignore: non_constant_identifier_names
    required this.eva_type,
    // ignore: non_constant_identifier_names
    required this.destination_bank_name,
    // ignore: non_constant_identifier_names
    required this.destination_bank_code,
    // ignore: non_constant_identifier_names
    this.destination_bank_icon,
    // ignore: non_constant_identifier_names
    required this.destination_bank_id,
    // ignore: non_constant_identifier_names
    required this.destination_account_number,
    // ignore: non_constant_identifier_names
    required this.destination_account_holder,
    // ignore: non_constant_identifier_names
    required this.request_amount,
    // ignore: non_constant_identifier_names
    required this.bank_fee,
    // ignore: non_constant_identifier_names
    required this.platform_fee,
    // ignore: non_constant_identifier_names
    required this.withdraw_amount,
    required this.status,
    // ignore: non_constant_identifier_names
    required this.created_on,
  });

  factory WithdrawTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$WithdrawTransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawTransactionModelToJson(this);
}
