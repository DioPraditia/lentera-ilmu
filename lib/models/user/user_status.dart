import 'package:lentera_ilmu/models/user/eva.dart';
import 'package:lentera_ilmu/models/user/session.dart';
import 'package:lentera_ilmu/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_status.g.dart';

@JsonSerializable()
class UserStatusModel {
  final UserModel user;
  final SessionModel? session;
  final List<EvaModel> eva;

  const UserStatusModel({
    required this.user,
    this.session,
    required this.eva,
  });

  factory UserStatusModel.fromJson(Map<String, dynamic> json) =>
      _$UserStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserStatusModelToJson(this);
}
