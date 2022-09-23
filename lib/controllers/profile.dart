import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/models/media/media.dart';
import 'package:lentera_ilmu/models/user/eva.dart';
import 'package:lentera_ilmu/models/user/mutation.dart';
import 'package:lentera_ilmu/models/user/notification.dart';
import 'package:lentera_ilmu/models/user/user.dart';
import 'package:lentera_ilmu/models/user/user_status.dart';
import 'package:lentera_ilmu/screens/login/login_screen.dart';
import 'package:lentera_ilmu/screens/profile/kyc/waiting_kyc_screen.dart';
import 'package:lentera_ilmu/screens/transaction/payment/transaction_screen.dart';
import 'package:lentera_ilmu/services/asset.dart';
import 'package:lentera_ilmu/services/media.dart';
import 'package:lentera_ilmu/services/profile.dart';
import 'package:lentera_ilmu/services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final profileService = ProfileService();
  final assetService = AssetService();
  final mediaService = MediaService();
  bool loading = false;
  UserStatusModel? status;
  MediaModel? media;
  late List<UserModel> directUsers = <UserModel>[].obs;
  late List<MutationModel> mutations = <MutationModel>[].obs;
  late List<NotificationModel> notifications = <NotificationModel>[].obs;
  final verificationCode = TextEditingController();
  final inputName = TextEditingController();
  final inputPhone = TextEditingController();
  final inputEmail = TextEditingController();
  int lastPage = 0;
  int treeCounter = 0;
  double accountBalance = 0;
  double withdrawBalance = 0;
  @override
  void onInit() async {
    super.onInit();
    fetchData();
  }

  getMedia() async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      media = await mediaService.getMedia();
      // ignore: avoid_print
      print(media);
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  setTreeIncrement(int increment) {
    treeCounter = increment;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
  }

  Future<void> fetchData({bool withLoading = true}) async {
    if (withLoading) {
      loading = true;
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool("is_login") ?? false;
    if (!isLogin) {
      Get.to(() => LoginScreen());
    }
    await getProfile(withLoading: withLoading);
    loading = false;
    update();
  }

  Future<void> requestEmailVerification() async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      await profileService.requestEmailVerification();
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  Future<void> verifikasiEmail() async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      await profileService.emailVerification(verificationCode.text);
      loading = false;
      update();
      getProfile();
      Get.back();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  Future<void> getProfile({bool withLoading = true}) async {
    if (withLoading) {
      loading = true;
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
    }
    try {
      status = await profileService.getProfile();
      double balance = 0;
      double wdBalance = 0;
      for (var item in status?.eva ?? <EvaModel>[]) {
        balance += double.parse(item.balance);
        if (item.type == "withdraw") {
          wdBalance = double.parse(item.balance);
        }
      }
      accountBalance = balance;
      withdrawBalance = wdBalance;
      loading = false;
      update();
    } catch (e) {
      if (e.toString() != "Akun tidak ditemukan.") {
        showErrorMessage(e.toString());
      }
      loading = false;
      update();
    }
  }

  Future<void> getListDirectUsers({
    required int page,
    required bool restartData,
    String? status,
    required int userId,
  }) async {
    // if (restartData) {
    //   loading = true;
    //   Future.delayed(const Duration(milliseconds: 10), () {
    //     update();
    //   });
    // }
    try {
      final result = await profileService.getListDirect(
        size: 25,
        page: page,
        status: status,
        userId: userId,
      );
      if (restartData) {
        directUsers = result;
        update();
      } else {
        directUsers.addAll(result);
        update();
      }
      lastPage = page;
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  getListMutations({
    required int page,
    required bool restartData,
    required String type,
    bool useLoading = false,
  }) async {
    if (useLoading) {
      loading = true;
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
    }
    try {
      final result = await profileService.getListMutation(
        size: 20,
        page: page,
        type: type,
      );
      if (restartData) {
        mutations = result;
        update();
      } else {
        mutations.addAll(result);
        update();
      }
      lastPage = page;
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  changePhotoProfile(File image) async {
    try {
      var avatar = await assetService.upload(image, "avatar");
      // ignore: avoid_print
      print("avatar");
      // ignore: avoid_print
      print(avatar);
      await profileService.updateProfie(photo: avatar);
      getProfile(withLoading: false);
    } catch (e) {
      showErrorMessage(e.toString());
    }
  }

  updateProfile() async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      await profileService.updateProfie(
        phone: inputPhone.text,
        name: inputName.text,
        email: inputEmail.text,
      );
      await getProfile(withLoading: false);
      Get.back();
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  Future getListNotifications({
    required int page,
    required int size,
    required bool resetData,
    bool withLoading = false,
  }) async {
    if (withLoading) {
      loading = true;
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
    }
    try {
      final result =
          await profileService.getListNotifications(page: page, size: size);
      if (resetData) {
        notifications = result;
      } else {
        notifications.addAll(result);
      }
      lastPage = page;
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  List<int> read = [];
  Future readNotification({
    required NotificationModel notification,
    bool withLoading = false,
    required BuildContext context,
  }) async {
    if (withLoading) {
      loading = true;
      Future.delayed(const Duration(milliseconds: 5), () {
        update();
      });
    }
    read.add(notification.id);
    update();
    profileService.readNotification(notification.id);
    if (notification.data?.reference == null) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: Colors.white,
          actionsPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.title,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.all(6)),
              Text(
                notification.message,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 14,
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 12),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                'Tutup',
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      );
      loading = false;
      update();
    } else {
      if (notification.data?.type == "trx_course" ||
          notification.data?.type == "trx_subscription") {
        Get.to(() => TransactionScreen(
            trxCode: notification.data?.reference ?? "", back: true));
      }
    }
    loading = false;
    update();
  }

  // ignore: non_constant_identifier_names
  String url_ktp = "";
  // ignore: non_constant_identifier_names
  String url_ktp_selfie = "";
  // ignore: non_constant_identifier_names
  bool loader_ktp = false;
  // ignore: non_constant_identifier_names
  bool loader_selfie = false;
  uploadKTP({required File image, String type = "ktp"}) async {
    try {
      if (type == "ktp") {
        loader_ktp = true;
      } else {
        loader_selfie = true;
      }
      Future.delayed(const Duration(milliseconds: 5), () {
        update();
      });
      var url = await assetService.upload(image, "kyc");
      if (type == "ktp") {
        url_ktp = url;
      } else {
        url_ktp_selfie = url;
      }
      loader_ktp = false;
      loader_selfie = false;
      update();
    } catch (e) {
      // ignore: avoid_print
      print(e);
      loader_ktp = false;
      loader_selfie = false;
      update();
    }
  }

  final inputNIK = TextEditingController();
  Future<void> requestKYC() async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      await profileService.requestKYC(
        identity_image: url_ktp,
        identity_number: inputNIK.text,
        identity_selfie_image: url_ktp_selfie,
      );
      loading = false;
      update();
      getProfile();
      Get.off(() => const WaitingKycScreen());
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }
}
