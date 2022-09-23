import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/profile.dart';

class WaitingKycScreen extends StatefulWidget {
  const WaitingKycScreen({Key? key}) : super(key: key);

  @override
  _WaitingKycScreen createState() => _WaitingKycScreen();
}

class _WaitingKycScreen extends State<WaitingKycScreen> {
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
            "Verifikasi Identitas",
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/empty/waiting_kyc.png",
                width: MediaQuery.of(context).size.width * .60,
              ),
              const Padding(padding: EdgeInsets.all(8)),
              const Text(
                "Mohon menunggu.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.all(4)),
              const Text(
                "Permohonan verifikasi sedang dalam proses.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
