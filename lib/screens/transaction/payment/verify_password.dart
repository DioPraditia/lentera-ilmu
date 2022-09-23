import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/lms.dart';
import 'package:lentera_ilmu/controllers/payment.dart';
import 'package:lentera_ilmu/screens/navigation.dart';
// ignore: unused_import
import 'package:lentera_ilmu/screens/transaction/payment/payment_tutorial_screen.dart';
// ignore: unused_import
import 'package:lentera_ilmu/screens/widgets/toast.dart';
// ignore: unused_import
import 'package:lentera_ilmu/services/utils.dart';

class VerifyPasswordScreen extends StatefulWidget {
  final bool back;
  const VerifyPasswordScreen({Key? key, required this.back}) : super(key: key);

  @override
  _VerifyPasswordScreen createState() => _VerifyPasswordScreen();
}

class _VerifyPasswordScreen extends State<VerifyPasswordScreen> {
  final lmsController = Get.put(LMSController());
  final paymentController = Get.put(PaymentController());
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  List<int> items = [1, 2, 3];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const AutoSizeText(
            "Pembayaran",
            maxFontSize: 15,
          ),
          centerTitle: true,
          leading: widget.back == true
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => {
                    Get.back(),
                  },
                )
              : null,
        ),
        body: Container(),
        bottomNavigationBar: widget.back != true
            ? Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.all(Radius.circular(18)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2.0,
                        offset: Offset(0.0, 0.75))
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text(
                      "Beranda",
                      style: TextStyle(fontSize: 14),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(14)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.teal),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          side: BorderSide(color: Colors.teal),
                        ),
                      ),
                    ),
                    onPressed: () => {Get.to(() => const BottomNavBar())},
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
