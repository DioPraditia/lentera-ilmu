import 'package:json_annotation/json_annotation.dart';
import 'package:lentera_ilmu/models/lms/course_module_item.dart';

part 'course_module.g.dart';

@JsonSerializable()
class CourseModule {
  final int id;
  // ignore: non_constant_identifier_names
  final int course_id;
  // ignore: non_constant_identifier_names
  final String course_title;
  final String title;
  final String? description;
  final String? thumbnail;
  final int sequence;
  final int status;
  // ignore: non_constant_identifier_names
  final List<CourseModuleItem> module_items;

  const CourseModule({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.course_id,
    // ignore: non_constant_identifier_names
    required this.course_title,
    required this.title,
    this.description,
    this.thumbnail,
    required this.sequence,
    required this.status,
    // ignore: non_constant_identifier_names
    required this.module_items,
  });

  factory CourseModule.fromJson(Map<String, dynamic> json) =>
      _$CourseModuleFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModuleToJson(this);
}
