import 'package:json_annotation/json_annotation.dart';
import 'package:lentera_ilmu/models/lms/course.dart';

part 'user_course.g.dart';

@JsonSerializable()
class UserCourseModel {
  final int id;
  // ignore: non_constant_identifier_names
  final int user_id;
  // ignore: non_constant_identifier_names
  final int course_id;
  // ignore: non_constant_identifier_names
  final String enroll_date;
  final int progress;
  final CourseModel? course;

  const UserCourseModel({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.user_id,
    // ignore: non_constant_identifier_names
    required this.course_id,
    // ignore: non_constant_identifier_names
    required this.enroll_date,
    required this.progress,
    this.course,
  });

  factory UserCourseModel.fromJson(Map<String, dynamic> json) =>
      _$UserCourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserCourseModelToJson(this);
}
