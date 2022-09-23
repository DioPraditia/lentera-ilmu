import 'package:json_annotation/json_annotation.dart';
import 'package:lentera_ilmu/models/lms/course_module.dart';
import 'package:lentera_ilmu/models/lms/user_course.dart';
import 'package:lentera_ilmu/models/lms/sharing_fee.dart';

part 'course.g.dart';

@JsonSerializable()
class CourseModel {
  final int id;
  // ignore: non_constant_identifier_names
  final int? creator_id;
  // ignore: non_constant_identifier_names
  final String creator_name;
  final String title;
  final String? description;
  final String? thumbnail;
  final String? image;
  // ignore: non_constant_identifier_names
  final String price_type;
  final String price;
  final int status;
  // ignore: non_constant_identifier_names
  final UserCourseModel? user_course;
  final List<CourseModule>? modules;
  // ignore: non_constant_identifier_names
  final SharingFeeModel? sharing_fee;
  // ignore: non_constant_identifier_names
  final int category_id;
  // ignore: non_constant_identifier_names
  final String category_name;
  final int member;

  const CourseModel({
    required this.id,
    // ignore: non_constant_identifier_names
    this.creator_id,
    // ignore: non_constant_identifier_names
    required this.creator_name,
    required this.title,
    this.description,
    this.thumbnail,
    this.image,
    required this.price,
    // ignore: non_constant_identifier_names
    required this.price_type,
    required this.status,
    // ignore: non_constant_identifier_names
    this.user_course,
    this.modules,
    // ignore: non_constant_identifier_names
    required this.sharing_fee,
    // ignore: non_constant_identifier_names
    required this.category_id,
    // ignore: non_constant_identifier_names
    required this.category_name,
    required this.member,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}
