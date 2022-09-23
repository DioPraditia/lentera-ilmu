import 'package:json_annotation/json_annotation.dart';

part 'mutation.g.dart';

@JsonSerializable()
class MutationModel {
  // ignore: non_constant_identifier_names
  final String trx_code;
  // ignore: non_constant_identifier_names
  final String trx_serialization;
  // ignore: non_constant_identifier_names
  final int user_id;
  // ignore: non_constant_identifier_names
  final String user_name;
  final String type;
  final String source;
  final String? remarks;
  // ignore: non_constant_identifier_names
  final String starting_balance;
  final String credit;
  final String debit;
  // ignore: non_constant_identifier_names
  final String ending_balance;
  // ignore: non_constant_identifier_names
  final String created_on;

  const MutationModel({
    // ignore: non_constant_identifier_names
    required this.trx_code,
    // ignore: non_constant_identifier_names
    required this.trx_serialization,
    // ignore: non_constant_identifier_names
    required this.user_id,
    // ignore: non_constant_identifier_names
    required this.user_name,
    required this.type,
    required this.source,
    this.remarks,
    // ignore: non_constant_identifier_names
    required this.starting_balance,
    required this.credit,
    required this.debit,
    // ignore: non_constant_identifier_names
    required this.ending_balance,
    // ignore: non_constant_identifier_names
    required this.created_on,
  });

  factory MutationModel.fromJson(Map<String, dynamic> json) =>
      _$MutationModelFromJson(json);

  Map<String, dynamic> toJson() => _$MutationModelToJson(this);
}
