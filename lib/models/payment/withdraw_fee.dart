import 'package:json_annotation/json_annotation.dart';

part 'withdraw_fee.g.dart';

@JsonSerializable()
class WithdrawFeeModel {
  final double fee;
  final double minimum;

  const WithdrawFeeModel({
    required this.fee,
    required this.minimum,
  });

  factory WithdrawFeeModel.fromJson(Map<String, dynamic> json) =>
      _$WithdrawFeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawFeeModelToJson(this);
}
