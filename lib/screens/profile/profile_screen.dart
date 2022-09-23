import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lentera_ilmu/controllers/auth.dart';
import 'package:lentera_ilmu/controllers/profile.dart';
import 'package:lentera_ilmu/controllers/welcome.dart';
import 'package:lentera_ilmu/screens/media/web_view_information_screen.dart';
import 'package:lentera_ilmu/screens/navigation.dart';
import 'package:lentera_ilmu/screens/profile/direct_user_screen.dart';
import 'package:lentera_ilmu/screens/profile/edit_profile_screen.dart';
import 'package:lentera_ilmu/screens/profile/kyc/upload_document_kyc_screen.dart';
import 'package:lentera_ilmu/screens/profile/kyc/waiting_kyc_screen.dart';
import 'package:lentera_ilmu/screens/withdraw/history_withdraw_screen.dart';
import 'package:lentera_ilmu/screens/profile/mutation_screen.dart';
import 'package:lentera_ilmu/screens/profile/notification_screen.dart';
import 'package:lentera_ilmu/screens/profile/setting/email_verification_screen.dart';
import 'package:lentera_ilmu/screens/profile/setting/bank/list_bank_account_screen.dart';
import 'package:lentera_ilmu/screens/profile/setting/password/change_password_screen.dart';
import 'package:lentera_ilmu/screens/transaction/history_screen.dart';
import 'package:lentera_ilmu/screens/widgets/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lentera_ilmu/screens/withdraw/withdraw_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _ProfileScreen extends State<ProfileScreen> {
  final profileController = Get.put(ProfileController());
  final authController = Get.put(LoginController());
  final welcomeController = Get.put(WelcomeController());
  String getInitials(String bankAccountName) => bankAccountName
      .trim()
      .split(RegExp(' +'))
      .map((s) => s[0])
      .take(2)
      .join();
  final formatCurrency = NumberFormat.decimalPattern();
  @override
  void initState() {
    super.initState();
    profileController.fetchData();
    profileController.getMedia();
    // state = AppState.free;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    profileController.fetchData(withLoading: false);
  }

  String getIcon(String evaType) {
    if (evaType == "withdraw") {
      return "assets/img/wd.png";
    }
    if (evaType == "ad") {
      return "assets/img/ad.png";
    }
    if (evaType == "other") {
      return "assets/img/other.png";
    }
    if (evaType == "hold") {
      return "assets/img/hold.png";
    }
    return "assets/img/wallet.png";
  }

  final ImagePicker _picker = ImagePicker();
  late File pickedImage;
  File? imageFile;
  _getFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (image != null) {
      _cropImage(image);
    }
  }

  _cropImage(XFile image) async {
    File? croppedFile = await ImageCropper().cropImage(
      cropStyle: CropStyle.circle,
      sourcePath: image.path,
      compressQuality: 70,
      compressFormat: ImageCompressFormat.jpg,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        // CropAspectRatioPreset.ratio3x2,
        // CropAspectRatioPreset.original,
        // CropAspectRatioPreset.ratio4x3,
        // CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Potong Gambar',
        toolbarColor: Colors.teal,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: const IOSUiSettings(
        title: "Potong Gambar",
        minimumAspectRatio: 1.0,
        rectWidth: 1,
        rectHeight: 1,
        aspectRatioLockEnabled: false,
      ),
    );
    if (croppedFile != null) {
      setState(() {
        imageFile = croppedFile;
      });
      // ignore: avoid_print
      print(croppedFile);
      profileController.changePhotoProfile(croppedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      // onGenerateInitialRoutes: (_) => lmsController.getCourse(widget.course.id),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const AutoSizeText(
            "Akun",
            maxFontSize: 16,
          ),
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              Get.to(
                () => const BottomNavBar(),
              ),
            },
          ),
          actions: [
            GestureDetector(
              onTap: () => Get.to(() => const NotificationScreen()),
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 14),
                child: const Icon(
                  Icons.notifications_outlined,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          color: Colors.teal,
          onRefresh: () => refreshData(),
          child: GetBuilder<ProfileController>(builder: (profile) {
            return profile.loading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.teal,
                    ),
                  )
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            top: 24,
                            bottom: 14,
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(32),
                                bottomRight: Radius.circular(32)),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 2.0,
                                  offset: Offset(0.0, 0.5))
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: Stack(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 80,
                                              height: 80,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: profile.status?.user
                                                            .photo !=
                                                        ""
                                                    ? Container(
                                                        width: 80,
                                                        height: 80,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: NetworkImage(
                                                                profile
                                                                        .status
                                                                        ?.user
                                                                        .photo ??
                                                                    "https://asset.lenterailmu.id?dir=resources/icon/1024.png"),
                                                          ),
                                                        ),
                                                      )
                                                    : Text(
                                                        profile.status != null
                                                            ? getInitials(
                                                                profile
                                                                        .status
                                                                        ?.user
                                                                        .name ??
                                                                    "")
                                                            : "",
                                                        style: const TextStyle(
                                                          color: Colors.teal,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: GestureDetector(
                                                onTap: () =>
                                                    {_getFromGallery()},
                                                child: Image.asset(
                                                  "assets/img/change_avatar.png",
                                                  width: 32,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.all(12)),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AutoSizeText(
                                            profile.status?.user.name ?? "",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                            ),
                                            maxFontSize: 16,
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(2)),
                                          AutoSizeText(
                                            profile.status?.user.phone ?? "",
                                            maxFontSize: 12,
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(2)),
                                          Row(
                                            children: [
                                              AutoSizeText(
                                                profile.status?.user.email ??
                                                    "",
                                                maxFontSize: 12,
                                              ),
                                              const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 4)),
                                              profile.status?.user
                                                          .email_verified ==
                                                      1
                                                  ? const Icon(
                                                      Icons.check_circle,
                                                      size: 12,
                                                      color: Colors.teal,
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          profile.status?.user
                                                      .subscription_until_date !=
                                                  null
                                              ? Column(
                                                  children: [
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(4)),
                                                    Row(
                                                      children: [
                                                        AutoSizeText(
                                                          profile.status?.user
                                                                  .referral_code ??
                                                              "",
                                                          maxFontSize: 14,
                                                        ),
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4)),
                                                        GestureDetector(
                                                          onTap: () => {
                                                            Clipboard.setData(ClipboardData(
                                                                    text: profile
                                                                            .status
                                                                            ?.user
                                                                            .referral_code ??
                                                                        ""))
                                                                .then((_) {
                                                              showBottomFlash(
                                                                  context:
                                                                      context,
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .copy),
                                                                  message:
                                                                      "Kode referral berhasil disalin.");
                                                            })
                                                          },
                                                          child: const Icon(
                                                            Icons.copy,
                                                            size: 14,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () => Get.to(
                                      () => EditProfileScreen(
                                        name: profile.status?.user.name ?? "",
                                        phone: profile.status?.user.phone ?? "",
                                        email: profile.status?.user.email ?? "",
                                      ),
                                      transition: Transition.rightToLeft,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Image.asset(
                                        "assets/img/edit.png",
                                        width: 24,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              profile.status?.user.email_verified == 0
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                        bottom: 0,
                                        top: 20,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.orange.shade50,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        boxShadow: const <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 1.0,
                                              offset: Offset(0.0, 0.5))
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            "Email Anda Belum Terverifikasi",
                                            maxFontSize: 12,
                                            style: TextStyle(
                                              color: Colors.grey.shade900,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => Get.to(
                                              () =>
                                                  const EmailVerificationScreen(),
                                              transition:
                                                  Transition.rightToLeft,
                                            ),
                                            child: const Text(
                                              'Verifikasi',
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              profile.status?.user.account_kyc != "approved"
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                        bottom: 0,
                                        top: 10,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color:
                                            profile.status?.user.account_kyc ==
                                                    "waiting"
                                                ? Colors.blue.shade100
                                                : Colors.orange.shade50,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        boxShadow: const <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 1.0,
                                              offset: Offset(0.0, 0.5))
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            profile.status?.user.account_kyc ==
                                                    "waiting"
                                                ? "Identitas Anda sedang dalam proses verifikasi."
                                                : "Identitas Anda Belum Terverifikasi",
                                            maxFontSize: 12,
                                            style: TextStyle(
                                              color: Colors.grey.shade900,
                                            ),
                                          ),
                                          profile.status?.user.account_kyc !=
                                                  "waiting"
                                              ? GestureDetector(
                                                  onTap: () => Get.to(
                                                    () =>
                                                        const UploadDocumentKycScreen(),
                                                    transition:
                                                        Transition.rightToLeft,
                                                  ),
                                                  child: const Text(
                                                    'Verifikasi',
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              profile.status?.eva != null
                                  ? Column(
                                      children: [
                                        const Padding(
                                            padding: EdgeInsets.all(6)),
                                        Container(
                                          margin: const EdgeInsets.all(8),
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 12,
                                            bottom: 12,
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: Colors.grey.shade300,
                                                blurRadius: 5.0,
                                                offset: const Offset(4, 5),
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/img/wallet.png",
                                                    width: 20,
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 8)),
                                                  const AutoSizeText(
                                                    "Jumlah Points",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxFontSize: 14,
                                                  ),
                                                ],
                                              ),
                                              AutoSizeText(
                                                formatCurrency.format(
                                                    profile.accountBalance),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.teal,
                                                ),
                                                maxFontSize: 14,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 6,
                                            bottom: 8,
                                          ),
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 12,
                                            bottom: 12,
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: Colors.grey.shade300,
                                                blurRadius: 5.0,
                                                offset: const Offset(4, 5),
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // for (var eva
                                              //     in profile.status?.eva ??
                                              //         <EvaModel>[])

                                              GestureDetector(
                                                onTap: () => Get.to(
                                                  () => MutationScreen(
                                                    mutationType: profile.status
                                                            ?.eva[0].type ??
                                                        "",
                                                    mutationTitle: profile
                                                            .status
                                                            ?.eva[0]
                                                            .title ??
                                                        "",
                                                  ),
                                                  transition:
                                                      Transition.rightToLeft,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      getIcon(profile.status
                                                              ?.eva[0].type ??
                                                          ""),
                                                      width: 20,
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(4)),
                                                    AutoSizeText(
                                                      profile.status?.eva[0]
                                                              .title ??
                                                          "",
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      maxFontSize: 12,
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(1)),
                                                    AutoSizeText(
                                                      formatCurrency.format(
                                                          double.parse(profile
                                                                  .status
                                                                  ?.eva[0]
                                                                  .balance ??
                                                              "")),
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.redAccent,
                                                      ),
                                                      maxFontSize: 13,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 70,
                                                child: VerticalDivider(
                                                  color: Colors.grey.shade400,
                                                  thickness: 1,
                                                  indent: 1,
                                                  endIndent: 0,
                                                  width: 2,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => Get.to(
                                                  () => MutationScreen(
                                                    mutationType: profile.status
                                                            ?.eva[1].type ??
                                                        "",
                                                    mutationTitle: profile
                                                            .status
                                                            ?.eva[1]
                                                            .title ??
                                                        "",
                                                  ),
                                                  transition:
                                                      Transition.rightToLeft,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      getIcon(profile.status
                                                              ?.eva[1].type ??
                                                          ""),
                                                      width: 20,
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(4)),
                                                    AutoSizeText(
                                                      profile.status?.eva[1]
                                                              .title ??
                                                          "",
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      maxFontSize: 12,
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(1)),
                                                    AutoSizeText(
                                                      formatCurrency.format(
                                                          double.parse(profile
                                                                  .status
                                                                  ?.eva[1]
                                                                  .balance ??
                                                              "")),
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.redAccent,
                                                      ),
                                                      maxFontSize: 13,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 70,
                                                child: VerticalDivider(
                                                  color: Colors.grey.shade400,
                                                  thickness: 1,
                                                  indent: 1,
                                                  endIndent: 0,
                                                  width: 2,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => Get.to(
                                                  () => MutationScreen(
                                                    mutationType: profile.status
                                                            ?.eva[2].type ??
                                                        "",
                                                    mutationTitle: profile
                                                            .status
                                                            ?.eva[2]
                                                            .title ??
                                                        "",
                                                  ),
                                                  transition:
                                                      Transition.rightToLeft,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      getIcon(profile.status
                                                              ?.eva[2].type ??
                                                          ""),
                                                      width: 20,
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(4)),
                                                    AutoSizeText(
                                                      profile.status?.eva[2]
                                                              .title ??
                                                          "",
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      maxFontSize: 12,
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(1)),
                                                    AutoSizeText(
                                                      formatCurrency.format(
                                                          double.parse(profile
                                                                  .status
                                                                  ?.eva[2]
                                                                  .balance ??
                                                              "")),
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.redAccent,
                                                      ),
                                                      maxFontSize: 13,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 70,
                                                child: VerticalDivider(
                                                  color: Colors.grey.shade400,
                                                  thickness: 1,
                                                  indent: 1,
                                                  endIndent: 0,
                                                  width: 2,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => Get.to(
                                                  () => MutationScreen(
                                                    mutationType: profile.status
                                                            ?.eva[3].type ??
                                                        "",
                                                    mutationTitle: profile
                                                            .status
                                                            ?.eva[3]
                                                            .title ??
                                                        "",
                                                  ),
                                                  transition:
                                                      Transition.rightToLeft,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      getIcon(profile.status
                                                              ?.eva[3].type ??
                                                          ""),
                                                      width: 20,
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(4)),
                                                    AutoSizeText(
                                                      profile.status?.eva[3]
                                                              .title ??
                                                          "",
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      maxFontSize: 12,
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(1)),
                                                    AutoSizeText(
                                                      formatCurrency.format(
                                                          double.parse(profile
                                                                  .status
                                                                  ?.eva[3]
                                                                  .balance ??
                                                              "")),
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.redAccent,
                                                      ),
                                                      maxFontSize: 13,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        profile.status?.user
                                                    .subscription_until_date !=
                                                null
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                alignment: Alignment.center,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    // ignore: deprecated_member_use
                                                    primary: Colors.white,
                                                    minimumSize:
                                                        const Size(50, 16),
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              80.0),
                                                    ),
                                                  ),
                                                  onPressed: () => {
                                                    if (profile.status?.user
                                                            .email_verified ==
                                                        0)
                                                      {
                                                        Get.to(
                                                          () =>
                                                              const EmailVerificationScreen(),
                                                          transition: Transition
                                                              .rightToLeft,
                                                        )
                                                      },
                                                    if (profile.status?.user
                                                                .account_kyc ==
                                                            "inexist" ||
                                                        profile.status?.user
                                                                .account_kyc ==
                                                            "rejected")
                                                      {
                                                        Get.to(
                                                          () =>
                                                              const UploadDocumentKycScreen(),
                                                          transition: Transition
                                                              .rightToLeft,
                                                        )
                                                      },
                                                    if (profile.status?.user
                                                            .account_kyc ==
                                                        "waiting")
                                                      {
                                                        Get.to(
                                                          () =>
                                                              const WaitingKycScreen(),
                                                          transition: Transition
                                                              .rightToLeft,
                                                        )
                                                      },
                                                    if (profile.status?.user
                                                            .account_kyc ==
                                                        "approved")
                                                      {
                                                        Get.to(
                                                          () =>
                                                              const WithdrawScreen(),
                                                          transition: Transition
                                                              .rightToLeft,
                                                        )
                                                      }
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 45.0,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      color: Colors.teal,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: const Text(
                                                      "Withdraw",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (() => Get.to(
                                      () => const TransactionHistoryScreen(),
                                      transition: Transition.rightToLeft,
                                    )),
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black45,
                                        width: .5,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/img/trx_history.png",
                                            width: 24,
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(4)),
                                          const AutoSizeText(
                                            "Riwayat Transaksi",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                            maxFontSize: 14,
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_right,
                                        size: 30,
                                        color: Colors.teal,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              profile.status?.user.subscription_until_date !=
                                      null
                                  ? GestureDetector(
                                      onTap: () => Get.to(
                                        () => const WithdrawHistoryScreen(),
                                        transition: Transition.rightToLeft,
                                      ),
                                      child: Container(
                                        height: 50,
                                        padding: const EdgeInsets.all(12),
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black45,
                                              width: .5,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Image.asset(
                                                  "assets/img/withdraw_history.png",
                                                  width: 24,
                                                ),
                                                const Padding(
                                                    padding: EdgeInsets.all(4)),
                                                const AutoSizeText(
                                                  "Riwayat Penarikan",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                  maxFontSize: 14,
                                                ),
                                              ],
                                            ),
                                            const Icon(
                                              Icons.arrow_right,
                                              size: 30,
                                              color: Colors.teal,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                              profile.status?.user.subscription_until_date !=
                                      null
                                  ? GestureDetector(
                                      onTap: () => {
                                        profile.setTreeIncrement(1),
                                        Get.to(
                                          () => const DirectUserScreen(),
                                          transition: Transition.rightToLeft,
                                        )
                                      },
                                      child: Container(
                                        height: 50,
                                        padding: const EdgeInsets.all(12),
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black45,
                                              width: .5,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Image.asset(
                                                  "assets/img/my_team.png",
                                                  width: 24,
                                                ),
                                                const Padding(
                                                    padding: EdgeInsets.all(4)),
                                                const AutoSizeText(
                                                  "My Team",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                  maxFontSize: 14,
                                                ),
                                              ],
                                            ),
                                            const Icon(
                                              Icons.arrow_right,
                                              size: 30,
                                              color: Colors.teal,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                              profile.status?.user.subscription_until_date !=
                                      null
                                  ? GestureDetector(
                                      onTap: () => Get.to(
                                        () => const ListBankAccountScreen(),
                                        transition: Transition.rightToLeft,
                                      ),
                                      child: Container(
                                        height: 50,
                                        padding: const EdgeInsets.all(12),
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black45,
                                              width: .5,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Image.asset(
                                                  "assets/img/bank_account.png",
                                                  width: 24,
                                                ),
                                                const Padding(
                                                    padding: EdgeInsets.all(4)),
                                                const AutoSizeText(
                                                  "Rekenink Bank",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                  maxFontSize: 14,
                                                ),
                                              ],
                                            ),
                                            const Icon(
                                              Icons.arrow_right,
                                              size: 30,
                                              color: Colors.teal,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                              GestureDetector(
                                onTap: () => Get.to(
                                  () => const ChangePasswordScreen(),
                                  transition: Transition.rightToLeft,
                                ),
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black45,
                                        width: .5,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/img/change_password.png",
                                            width: 24,
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(4)),
                                          const AutoSizeText(
                                            "Ubah Password",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                            maxFontSize: 14,
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_right,
                                        size: 30,
                                        color: Colors.teal,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Get.to(
                                  () => WebViewInformationScreen(
                                      title: "FAQ",
                                      url: profile.media?.faq ?? "about:blank"),
                                  transition: Transition.rightToLeft,
                                ),
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black45,
                                        width: .5,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/img/faq.png",
                                            width: 24,
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(4)),
                                          const AutoSizeText(
                                            "FAQ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                            maxFontSize: 14,
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_right,
                                        size: 30,
                                        color: Colors.teal,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Get.to(
                                  () => WebViewInformationScreen(
                                      title: "Tentang Kami",
                                      url: profile.media?.about_me ??
                                          "about:blank"),
                                  transition: Transition.rightToLeft,
                                ),
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black45,
                                        width: .5,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/img/about_us.png",
                                            width: 24,
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(4)),
                                          const AutoSizeText(
                                            "Tentang Kami",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                            maxFontSize: 14,
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_right,
                                        size: 30,
                                        color: Colors.teal,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => authController.logout(),
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black45,
                                        width: .5,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/img/logout.png",
                                            width: 24,
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(4)),
                                          const AutoSizeText(
                                            "Logout",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red,
                                            ),
                                            maxFontSize: 14,
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_right,
                                        size: 30,
                                        color: Colors.teal,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.all(12)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  AutoSizeText(
                                    "v${welcomeController.version}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    maxFontSize: 12,
                                  ),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.all(12)),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
