import 'package:json_annotation/json_annotation.dart';

part 'eva.g.dart';

@JsonSerializable()
class EvaModel {
  final int id;
  final String type;
  final String title;
  // ignore: non_constant_identifier_names
  final int user_id;
  // ignore: non_constant_identifier_names
  final String user_name;
  // ignore: non_constant_identifier_names
  final String user_phone;
  final String credit;
  final String debit;
  final String balance;

  const EvaModel({
    required this.id,
    required this.type,
    required this.title,
    // ignore: non_constant_identifier_names
    required this.user_id,
    // ignore: non_constant_identifier_names
    required this.user_phone,
    // ignore: non_constant_identifier_names
    required this.user_name,
    required this.balance,
    required this.credit,
    required this.debit,
  });
  factory EvaModel.fromJson(Map<String, dynamic> json) =>
      _$EvaModelFromJson(json);

  Map<String, dynamic> toJson() => _$EvaModelToJson(this);
}
