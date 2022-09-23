import 'package:json_annotation/json_annotation.dart';

part 'sharing_fee.g.dart';

@JsonSerializable()
class SharingFeeModel {
  final int? level_1;
  final int? level_2;
  final int? level_3;
  final int? level_4;
  final int? level_5;

  const SharingFeeModel({
    this.level_1,
    this.level_2,
    this.level_3,
    this.level_4,
    this.level_5,
  });

  factory SharingFeeModel.fromJson(Map<String, dynamic> json) =>
      _$SharingFeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$SharingFeeModelToJson(this);
}
