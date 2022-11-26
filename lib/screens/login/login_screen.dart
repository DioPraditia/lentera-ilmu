import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/auth.dart';
import 'package:lentera_ilmu/controllers/welcome.dart';
import 'package:lentera_ilmu/screens/navigation.dart';
import 'package:lentera_ilmu/screens/profile/setting/password/forgot_password_screen.dart';
import 'package:lentera_ilmu/screens/register/register_screen.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final welcomeConntroller = Get.put(WelcomeController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        // ignore: prefer_const_constructors
        Get.to(() => BottomNavBar());
        return false;
      },
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Roboto',
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: GetBuilder<LoginController>(builder: (login) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 64, bottom: 24, left: 12, right: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      margin: const EdgeInsets.only(bottom: 20, top: 20),
                      child: Image.asset(
                        "assets/img/lentera_ilmu.png",
                        width: MediaQuery.of(context).size.width * .4,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontSize: 24),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextField(
                            controller: loginController.account,
                            decoration: const InputDecoration(
                              labelText: "Nomor Telepon / Email",
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextField(
                            controller: loginController.password,
                            decoration: InputDecoration(
                                labelText: "Password",
                                suffixIcon: IconButton(
                                    onPressed: () =>
                                        login.setPasswordVisibility(),
                                    icon: Icon(login.passwordVisibility
                                        ? Icons.visibility
                                        : Icons.visibility_off))),
                            obscureText: login.passwordVisibility,
                          ),
                        ),
                        // SizedBox(height: size.height * 0.05),
                        const Padding(padding: EdgeInsets.all(6)),
                        GestureDetector(
                          onTap: () =>
                              Get.to(() => const ForgotPasswordScreen()),
                          child: Container(
                            alignment: Alignment.topRight,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: const Text(
                              "Lupa password",
                              style: TextStyle(
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: GetBuilder<LoginController>(
                            builder: (ctrl) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  // ignore: deprecated_member_use
                                  primary: Colors.white,
                                  minimumSize: const Size(50, 16),
                                  padding: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0),
                                  ),
                                ),
                                onPressed: ctrl.loading
                                    ? null
                                    : () {
                                        loginController.login();
                                      },
                                //shape: RoundedRectangleBorder(
                                //  borderRadius: BorderRadius.circular(80.0),
                                //),
                                //disabledTextColor: Colors.white,
                                //textColor: Colors.white,
                                //padding: const EdgeInsets.all(0),
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
                                    ctrl.loading == true
                                        ? "Memproses"
                                        : "Masuk",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()))
                            },
                            child: const Text(
                              "Belum Punya Akun ? Daftar",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 40),
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()))
                            },
                            child: Text(
                              "v${welcomeConntroller.version}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
