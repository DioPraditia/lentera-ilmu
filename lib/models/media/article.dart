import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class ArticleModel {
  final String title;
  final String? summary;
  final String content;
  final String thumbnail;
  final String? image;
  final String type;
  final String status;
  // ignore: non_constant_identifier_names
  final String? created_by;
  // ignore: non_constant_identifier_names
  final String created_on;

  const ArticleModel({
    required this.title,
    this.summary,
    required this.content,
    required this.thumbnail,
    this.image,
    required this.type,
    required this.status,
    // ignore: non_constant_identifier_names
    this.created_by,
    // ignore: non_constant_identifier_names
    required this.created_on,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
