import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

@JsonSerializable()
class MediaModel {
  // ignore: non_constant_identifier_names
  final String about_me;
  final String faq;
  // ignore: non_constant_identifier_names
  final String privacy_policy;

  const MediaModel({
    // ignore: non_constant_identifier_names
    required this.about_me,
    required this.faq,
    // ignore: non_constant_identifier_names
    required this.privacy_policy,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) =>
      _$MediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MediaModelToJson(this);
}
