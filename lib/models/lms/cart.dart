import 'package:lentera_ilmu/models/lms/course.dart';

import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class CartModel {
  final int id;
  // ignore: non_constant_identifier_names
  final int user_id;
  // ignore: non_constant_identifier_names
  final String course_title;
  // ignore: non_constant_identifier_names
  final int course_id;
  final CourseModel course;

  const CartModel({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.course_id,
    // ignore: non_constant_identifier_names
    required this.course_title,
    // ignore: non_constant_identifier_names
    required this.user_id,
    required this.course,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}
