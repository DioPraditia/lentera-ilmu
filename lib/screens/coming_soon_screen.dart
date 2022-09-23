// ignore: unused_import
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:lentera_ilmu/controllers/auth.dart';
import 'package:lentera_ilmu/controllers/profile.dart';

class ComingSoonScreen extends StatefulWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

  @override
  _ComingSoonScreen createState() => _ComingSoonScreen();
}

class _ComingSoonScreen extends State<ComingSoonScreen> {
  final profileController = Get.put(ProfileController());
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
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      // onGenerateInitialRoutes: (_) => lmsController.getCourse(widget.course.id),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Colors.teal,
        //   title: const AutoSizeText(
        //     "Verifikasi Identitas",
        //     maxFontSize: 16,
        //   ),
        //   centerTitle: false,
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back, color: Colors.white),
        //     onPressed: () => {
        //       Get.back(),
        //     },
        //   ),
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/empty/coming_soon.png",
                width: MediaQuery.of(context).size.width * .60,
              ),
              const Padding(padding: EdgeInsets.all(8)),
              const Text(
                "Segera Hadir.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.all(4)),
              const Text(
                "Fitur ini sedang dalam proses pengembangan.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
