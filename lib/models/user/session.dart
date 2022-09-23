import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class SessionModel {
  final String session;
  // ignore: non_constant_identifier_names
  final int expired_on;

  // ignore: non_constant_identifier_names
  const SessionModel({required this.session, required this.expired_on});

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionModelToJson(this);
}
