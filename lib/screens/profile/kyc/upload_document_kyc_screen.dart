import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lentera_ilmu/controllers/profile.dart';

class UploadDocumentKycScreen extends StatefulWidget {
  const UploadDocumentKycScreen({Key? key}) : super(key: key);

  @override
  _UploadDocumentKycScreen createState() => _UploadDocumentKycScreen();
}

class _UploadDocumentKycScreen extends State<UploadDocumentKycScreen> {
  final profileController = Get.put(ProfileController());

  final ImagePicker _picker = ImagePicker();
  late File pickedImage;
  File? imageFile;
  _getFromCamera({String type = "ktp"}) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
    );
    if (image != null) {
      _cropImage(image, type);
    }
  }

  _cropImage(XFile image, String type) async {
    File? croppedFile = await ImageCropper().cropImage(
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
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.teal,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );
    if (croppedFile != null) {
      setState(() {
        imageFile = croppedFile;
      });
      profileController.uploadKTP(image: croppedFile, type: type);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      // onGenerateInitialRoutes: (_) => lmsController.getCourse(widget.course.id),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const AutoSizeText(
            "Verifikasi Identitas Pribadi",
            maxFontSize: 16,
          ),
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              Get.back(),
            },
          ),
        ),
        body: GetBuilder<ProfileController>(builder: (profile) {
          return SingleChildScrollView(
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upload Dokumen",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(6)),
                        Text(
                          "Silahkan upload foto KTP dan selfi dengan KTP untuk keperluan verifikasi.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(6)),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 1.0,
                                  offset: Offset(0.0, 0.5))
                            ],
                          ),
                          child: Text(
                            "Semua informasi kamu dijamin rahasia dan tidak akan disalahgunakan. Pastikan anda mengikuti petunjuk upload identitas seperti gambar di bawah.",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(6)),
                        Center(
                          child: Image.asset(
                            "assets/img/kyc_selfie.png",
                            width: MediaQuery.of(context).size.width / 1.7,
                            alignment: Alignment.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nomor KTP (NIK)",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(6)),
                        TextField(
                          controller: profile.inputNIK,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.teal),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.teal),
                            ),
                            labelText: 'Masukkan Nomor NIK',
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            contentPadding:
                                const EdgeInsets.only(left: 12, right: 12),
                            fillColor: Colors.teal,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const Padding(padding: EdgeInsets.all(6)),
                        Text(
                          "Foto KTP",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(6)),
                        GestureDetector(
                          onTap: () => {_getFromCamera(type: "ktp")},
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 1.0,
                                    offset: Offset(0.0, 0.5))
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: MediaQuery.of(context).size.width / 4,
                                  child: Container(
                                    color: Colors.grey.shade400,
                                    child: profile.url_ktp != ""
                                        ? Image.network(profile.url_ktp)
                                        : Icon(
                                            Icons.camera_alt,
                                            color: Colors.grey.shade700,
                                          ),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.all(8)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.50,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const AutoSizeText(
                                        "Upload Foto KTP",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                        ),
                                        maxFontSize: 14,
                                      ),
                                      const AutoSizeText(
                                        "Silahkan upload foto KTP bagian depan. Pastikan KTP telihat jelas.",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12,
                                        ),
                                        maxFontSize: 12,
                                        maxLines: 2,
                                        wrapWords: true,
                                      ),
                                      profile.loader_ktp
                                          ? const AutoSizeText(
                                              "Sedang upload file",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 12,
                                              ),
                                              maxFontSize: 12,
                                            )
                                          : const Text("")
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(6)),
                        Text(
                          "Foto Selfi Dengan KTP",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(6)),
                        GestureDetector(
                          onTap: () => {_getFromCamera(type: "selfie")},
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 1.0,
                                    offset: Offset(0.0, 0.5))
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: MediaQuery.of(context).size.width / 4,
                                  child: Container(
                                    color: Colors.grey.shade400,
                                    child: profile.url_ktp_selfie != ""
                                        ? Image.network(profile.url_ktp_selfie)
                                        : Icon(
                                            Icons.camera_alt,
                                            color: Colors.grey.shade700,
                                          ),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.all(8)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.50,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const AutoSizeText(
                                        "Upload Foto Selfi Dengan KTP",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                        ),
                                        maxFontSize: 14,
                                      ),
                                      const AutoSizeText(
                                        "Silahkan upload foto selfi dengan KTP. Pastikan wajah dan KTP telihat jelas.",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12,
                                        ),
                                        maxFontSize: 12,
                                        maxLines: 2,
                                        wrapWords: true,
                                      ),
                                      profile.loader_selfie
                                          ? const AutoSizeText(
                                              "Sedang upload file",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 12,
                                              ),
                                              maxFontSize: 12,
                                            )
                                          : const Text("")
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // ignore: deprecated_member_use
                        primary: Colors.white,
                        minimumSize: const Size(50, 16),
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0),
                        ),
                      ),
                      onPressed: () => profile.requestKYC(),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          color: Colors.teal,
                        ),
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          profile.loading ? "Menyimpan..." : "Simpan",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
