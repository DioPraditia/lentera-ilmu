// ignore: unused_import
import 'dart:convert';
// ignore: unused_import
import 'dart:io';
// ignore: unused_import
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'package:lentera_ilmu/models/user/eva.dart';
import 'package:lentera_ilmu/models/user/mutation.dart';
import 'package:lentera_ilmu/models/user/notification.dart';
import 'package:lentera_ilmu/models/user/user.dart';
import 'package:lentera_ilmu/models/user/user_status.dart';
import 'package:lentera_ilmu/services/service.dart';

class ProfileService extends ServiceAPI {
  Future<UserStatusModel> getProfile() async {
    try {
      final result = await get("$baseUrlUser/user/status");
      return UserStatusModel.fromJson(result);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<UserModel>> getListDirect({
    required int size,
    required int page,
    required int userId,
    String? status,
  }) async {
    try {
      final result = await get(
        "$baseUrlUser/user/direct/list",
        queryParameters: {
          "pagination": true,
          "page": page,
          "size": size,
          "user_id": userId,
        },
      );
      return result['items']
          .map<UserModel>((json) => UserModel.fromJson(json))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future getListMutation({
    required int size,
    required int page,
    required String type,
  }) async {
    try {
      final result = await get(
        "$baseUrlUser/user/mutations",
        queryParameters: {
          "pagination": true,
          "page": page,
          "size": size,
          "type": type,
        },
      );
      return result['items']
          .map<MutationModel>((json) => MutationModel.fromJson(json))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> requestEmailVerification() async {
    try {
      await post("$baseUrlUser/user/email/confirmation/request");
      return "Kode verifikasi berhasil dikirim melalui email";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> emailVerification(String verificationCode) async {
    try {
      await post(
        "$baseUrlUser/user/email/confirmation",
        data: {'verification_code': verificationCode},
      );
      return "Verifikasi email berhasil";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> updateProfie({
    String? name,
    String? phone,
    String? photo,
    String? email,
  }) async {
    try {
      await patch(
        "$baseUrlUser/user/profile",
        data: {
          'name': name,
          'phone': phone,
          'email': email,
          'photo': photo,
        },
      );
      return "Profile berhasil diubah.";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<NotificationModel>> getListNotifications({
    required int size,
    required int page,
  }) async {
    try {
      final result = await get(
        "$baseUrlUser/notification/list",
        queryParameters: {
          "pagination": true,
          "page": page,
          "size": size,
        },
      );
      return result['items']
          .map<NotificationModel>((json) => NotificationModel.fromJson(json))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> readNotification(int id) async {
    try {
      await get(
        "$baseUrlUser/notification/read",
        queryParameters: {"notification_id": id},
      );
      return "Behasil.";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> getSetting(String key) async {
    try {
      return await get(
        "$baseUrlUser/setting",
        queryParameters: {"key": key},
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> requestKYC({
    // ignore: non_constant_identifier_names
    required String identity_number,
    // ignore: non_constant_identifier_names
    required String identity_image,
    // ignore: non_constant_identifier_names
    required String identity_selfie_image,
  }) async {
    try {
      var result = await post(
        "$baseUrlUser/user/kyc/request",
        data: {
          'identity_number': identity_number,
          'identity_image': identity_image,
          'identity_selfie_image': identity_selfie_image,
        },
      );
      return result;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      throw e.toString();
    }
  }
}
