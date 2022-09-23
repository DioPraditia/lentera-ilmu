import 'package:json_annotation/json_annotation.dart';
import 'package:lentera_ilmu/models/payment/channel_tutorial.dart';

part 'payment_tutorial.g.dart';

@JsonSerializable()
class PaymentTutorialModel {
  final String channel;
  // ignore: non_constant_identifier_names
  final List<ChannelTutorialModel> channel_bank;

  const PaymentTutorialModel({
    required this.channel,
    // ignore: non_constant_identifier_names
    required this.channel_bank,
  });

  factory PaymentTutorialModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentTutorialModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTutorialModelToJson(this);
}
