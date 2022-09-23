import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/models/user/user_status.dart';
import 'package:lentera_ilmu/screens/login/login_screen.dart';
import 'package:lentera_ilmu/screens/navigation.dart';
import 'package:lentera_ilmu/screens/profile/setting/password/success_reset_password_screen.dart';
import 'package:lentera_ilmu/services/auth.dart';
import 'package:lentera_ilmu/services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final account = TextEditingController();
  var passwordVisibility = false;
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final referralCode = TextEditingController();

  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmNewPassword = TextEditingController();

  final authService = AuthServices();
  bool loading = false;
  bool resetPasswordSuccess = false;

  @override
  // ignore: unnecessary_overrides
  void onInit() async {
    super.onInit();
  }

  void setLoading(bool loading) {
    loading = loading;
    update();
  }

  void setPasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    update();
  }

  Future<void> login() async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      UserStatusModel status = await authService.login(
          account: account.text, password: password.text);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("is_login", true);
      await prefs.setInt("user_id", status.user.id);
      await prefs.setString("user_name", status.user.name);
      await prefs.setString("user_email", status.user.email);
      await prefs.setString("user_phone", status.user.phone);
      await prefs.setString("user_account_status", status.user.account_status);
      await prefs.setString("user_account_kyc", status.user.account_kyc);
      await prefs.setString("user_session", status.session?.session ?? "");
      await prefs.setInt(
          "user_session_expired", status.session?.expired_on ?? 0);
      Get.off(() => const BottomNavBar());
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("is_login", false);
    await prefs.setInt("user_id", 0);
    await prefs.setString("user_name", "");
    await prefs.setString("user_email", "");
    await prefs.setString("user_phone", "");
    await prefs.setString("user_account_status", "");
    await prefs.setString("user_account_kyc", "");
    await prefs.setString("user_session", "");
    await prefs.setInt("user_session_expired", 0);
    Get.to(() => LoginScreen());
  }

  Future<void> register() async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      UserStatusModel status = await authService.register(
        name: name.text,
        phone: phone.text,
        email: email.text,
        password: password.text,
        referralCode: referralCode.text,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("is_login", true);
      await prefs.setInt("user_id", status.user.id);
      await prefs.setString("user_name", status.user.name);
      await prefs.setString("user_email", status.user.email);
      await prefs.setString("user_phone", status.user.phone);
      await prefs.setString("user_account_status", status.user.account_status);
      await prefs.setString("user_account_kyc", status.user.account_kyc);
      await prefs.setString("user_session", status.session?.session ?? "");
      await prefs.setInt(
          "user_session_expired", status.session?.expired_on ?? 0);
      Get.off(() => const BottomNavBar());
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  bool confirmError = false;

  onChangeConfirmation(String confirmText) {
    if (confirmText != newPassword.text) {
      confirmError = true;
      update();
    } else {
      confirmError = false;
      update();
    }
  }

  Future<void> changePassword(BuildContext context) async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      await authService.changePassword(oldPassword.text, newPassword.text);
      bottomSheet(
        context: context,
        title: "Berhasil",
        message: "Password Anda berhasil diubah.",
        confirmAction: () => {Navigator.of(context).pop(), Get.back()},
      );
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  resetPassword() async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      await authService.resetPassword();
      resetPasswordSuccess = true;
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  forgotPassword() async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      await authService.resetPassword(email: email.text);
      Get.off(() => const SuccessResetPasswordScreen());
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  setResetPasswordMessage() {
    resetPasswordSuccess = false;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
  }
}
