import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/auth.dart';
// ignore: unused_import
import 'package:lentera_ilmu/controllers/profile.dart';
import 'package:lentera_ilmu/screens/login/login_screen.dart';

class SuccessResetPasswordScreen extends StatefulWidget {
  const SuccessResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _SuccessResetPasswordScreen createState() => _SuccessResetPasswordScreen();
}

class _SuccessResetPasswordScreen extends State<SuccessResetPasswordScreen> {
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
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const AutoSizeText(
            "Lupa Password",
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
        body: GetBuilder<LoginController>(builder: (auth) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/img/auth/email_auth_send.jpg",
                      width: MediaQuery.of(context).size.width * .70,
                    ),
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
                                          "Password baru berhasil dikirim. silahkan cek email anda.",
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
                      onPressed: () => Get.off(() => LoginScreen()),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          color: Colors.teal,
                        ),
                        padding: const EdgeInsets.all(0),
                        child: const Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
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
