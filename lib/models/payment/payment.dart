import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable()
class PaymentChannelModel {
  final int id;
  // ignore: non_constant_identifier_names
  final String app_id;
  final String category;
  final String provider;
  final String name;
  final String type;
  final String by;
  final String? icon;
  final int sequence;
  // ignore: non_constant_identifier_names
  final int charge_amount;
  // ignore: non_constant_identifier_names
  final int platform_fee;
  // ignore: non_constant_identifier_names
  final String charge_type;
  final int active;

  const PaymentChannelModel({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.app_id,
    required this.category,
    required this.provider,
    required this.name,
    required this.type,
    required this.by,
    this.icon,
    required this.sequence,
    // ignore: non_constant_identifier_names
    required this.charge_amount,
    // ignore: non_constant_identifier_names
    required this.platform_fee,
    // ignore: non_constant_identifier_names
    required this.charge_type,
    required this.active,
  });

  factory PaymentChannelModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentChannelModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentChannelModelToJson(this);
}
