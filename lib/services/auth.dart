import 'package:lentera_ilmu/models/user/user_status.dart';
import 'package:lentera_ilmu/services/service.dart';

class AuthServices extends ServiceAPI {
  Future<UserStatusModel> login({
    required String account,
    required String password,
  }) async {
    try {
      final result = await post("$baseUrlUser/user/login", data: {
        'account': account,
        'password': password,
      });
      return UserStatusModel.fromJson(result);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserStatusModel> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String referralCode,
  }) async {
    try {
      final result = await post(
        "$baseUrlUser/user/register",
        data: {
          'name': name,
          'phone': phone,
          'email': email,
          'referral_code': referralCode,
          'password': password,
        },
      );
      return UserStatusModel.fromJson(result);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> resetPassword({String email = ''}) async {
    try {
      await post(
        "$baseUrlUser/user/password/reset",
        data: {
          'email': email,
        },
      );
      return "Password telah dikirim melalui email.";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> changePassword(String oldPassword, String newPassword) async {
    try {
      await patch(
        "$baseUrlUser/user/password",
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );
      return "Password berhasil diubah.";
    } catch (e) {
      throw e.toString();
    }
  }
}
