import 'package:json_annotation/json_annotation.dart';

part 'channel_tutorial.g.dart';

@JsonSerializable()
class ChannelTutorialModel {
  final String name;
  final List<String> tutorial;

  const ChannelTutorialModel({
    required this.name,
    required this.tutorial,
  });

  factory ChannelTutorialModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelTutorialModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelTutorialModelToJson(this);
}
