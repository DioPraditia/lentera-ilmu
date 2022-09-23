import 'package:json_annotation/json_annotation.dart';

part 'destination_bank.g.dart';

@JsonSerializable()
class DestinationBankModel {
  final String value;
  final String name;
  final String icon;
  final String channel;
  final int displayed;
  final int fee;

  const DestinationBankModel({
    required this.value,
    required this.name,
    required this.icon,
    required this.channel,
    required this.displayed,
    required this.fee,
  });

  factory DestinationBankModel.fromJson(Map<String, dynamic> json) =>
      _$DestinationBankModelFromJson(json);

  Map<String, dynamic> toJson() => _$DestinationBankModelToJson(this);
}
