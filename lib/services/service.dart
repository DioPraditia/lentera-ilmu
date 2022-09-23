import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lentera_ilmu/services/device.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String authorizationHeader = "Basic c2lnbWVudGFzaTpTIWdtM250NHMxMjAyMiE=";
const String authorizationAssetHeader =
    "Basic c2lnbWVudGFzaV9hc3NldHM6c2lnbWVudGFzaV9hc3NldHM=";
const String baseUrlUser = "https://api.lenterailmu.id/user";
const String baseUrlMedia = "https://api.lenterailmu.id/media";
const String baseUrlLMS = "https://api.lenterailmu.id/lms";
const String baseUrlPayment = "https://api.lenterailmu.id/payment";

class ServiceAPI {
  Future<dynamic> getHeader() async {
    final _deviceService = DeviceService();
    final _deviceInfo = await _deviceService.getDeviceInformations();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      'x-app-id': 'id.app.lentera.ilmu',
      'authorization': authorizationHeader,
      'x-user-id': prefs.getInt("user_id").toString(),
      'x-user-phone': prefs.getString("user_phone") ?? '',
      'x-device-id': Platform.isAndroid
          ? _deviceInfo['androidId']
          : _deviceInfo['identifierForVendor'],
      'x-device-model': Platform.isAndroid
          ? _deviceInfo['model']
          : _deviceInfo['systemVersion'],
      'x-device-brand': Platform.isAndroid
          ? _deviceInfo['manufacturer']
          : _deviceInfo['model'],
      'x-session': prefs.getString("user_session") ?? '',
      'x-fcm-id': prefs.getString("fcm_token") ?? ''
    };
    return headers;
  }

  Future<dynamic> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final headers = await getHeader();
      final response = await Dio().get(url,
          queryParameters: queryParameters, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        throw response.data["error_message"] ?? "Tidak dapat mengakses data.";
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
      throw e.response?.data["error_message"] ?? "Tidak dapat mengakses data.";
    }
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? data}) async {
    try {
      final headers = await getHeader();
      final response =
          await Dio().post(url, data: data, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        throw response.data["error_message"] ?? "Tidak dapat mengakses data.";
      }
    } on DioError catch (e) {
      throw e.response?.data["error_message"] ?? "Tidak dapat mengakses data.";
    }
  }

  Future<dynamic> patch(String url, {Map<String, dynamic>? data}) async {
    try {
      final headers = await getHeader();
      final response = await Dio()
          .patch(url, data: data, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        throw response.data["error_message"] ?? "Tidak dapat mengakses data.";
      }
    } on DioError catch (e) {
      throw e.response?.data["error_message"] ?? "Tidak dapat mengakses data.";
    }
  }

  Future<dynamic> delete(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final headers = await getHeader();
      final response = await Dio().delete(url,
          queryParameters: queryParameters, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        throw response.data["error_message"] ?? "Tidak dapat mengakses data.";
      }
    } on DioError catch (e) {
      throw e.response?.data["error_message"] ?? "Tidak dapat mengakses data.";
    }
  }
}
