import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/auth.dart';
import 'package:lentera_ilmu/controllers/profile.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  _EmailVerificationScreen createState() => _EmailVerificationScreen();
}

class _EmailVerificationScreen extends State<EmailVerificationScreen> {
  final profileController = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    profileController.requestEmailVerification();
    profileController.verificationCode.text = "";
  }

  @override
  void dispose() {
    super.dispose();
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
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const AutoSizeText(
            "Verifikasi Email",
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
        body: GetBuilder<LoginController>(
          builder: (auth) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/img/auth/reset_password.png",
                        width: MediaQuery.of(context).size.width * .40,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 50)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        AutoSizeText(
                          "Informasi",
                          maxFontSize: 14,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(4)),
                    Column(
                      children: [
                        const Divider(
                          height: 8,
                          thickness: 1.3,
                        ),
                        const Padding(padding: EdgeInsets.all(4)),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: Colors.orange.shade800,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                              ),
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey.shade600,
                                    ),
                                    children: const <TextSpan>[
                                      TextSpan(
                                        text:
                                            "Silahkan masukkan Kode verifikasi telah dikirim ke email Anda.",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(6)),
                    Container(
                      alignment: Alignment.center,
                      // margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextField(
                        controller: profileController.verificationCode,
                        decoration: const InputDecoration(
                            labelText: "Masukkan Kode Verifikasi"),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(6)),
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
                        onPressed: () => profileController.verifikasiEmail(),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            color: Colors.teal,
                          ),
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            auth.loading ? "Memproses..." : "Verifikasi",
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
          },
        ),
      ),
    );
  }
}
