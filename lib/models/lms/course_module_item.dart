import 'package:json_annotation/json_annotation.dart';

part 'course_module_item.g.dart';

@JsonSerializable()
class CourseModuleItem {
  final int id;
  // ignore: non_constant_identifier_names
  final int course_id;
  // ignore: non_constant_identifier_names
  final String course_title;
  // ignore: non_constant_identifier_names
  final int module_id;
  // ignore: non_constant_identifier_names
  final String module_title;
  final String title;
  final String? description;
  // ignore: non_constant_identifier_names
  final String source_type;
  // ignore: non_constant_identifier_names
  final String source_url;
  final String? duration;
  final String? thumbnail;
  final int sequence;
  final int status;
  // ignore: non_constant_identifier_names
  final int is_preview;

  const CourseModuleItem({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.course_id,
    // ignore: non_constant_identifier_names
    required this.course_title,
    // ignore: non_constant_identifier_names
    required this.module_id,
    // ignore: non_constant_identifier_names
    required this.module_title,
    required this.title,
    this.description,
    // ignore: non_constant_identifier_names
    required this.source_type,
    // ignore: non_constant_identifier_names
    required this.source_url,
    this.duration,
    this.thumbnail,
    required this.sequence,
    required this.status,
    // ignore: non_constant_identifier_names
    required this.is_preview,
  });

  factory CourseModuleItem.fromJson(Map<String, dynamic> json) =>
      _$CourseModuleItemFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModuleItemToJson(this);
}
