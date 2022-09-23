// ignore: unused_import
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: unused_import
import 'package:lentera_ilmu/controllers/lms.dart';
import 'package:lentera_ilmu/screens/transaction/cart/cart_screen.dart';

class ShowroomListScreen extends StatefulWidget {
  const ShowroomListScreen({Key? key}) : super(key: key);

  @override
  State<ShowroomListScreen> createState() => _ShowroomListScreenState();
}

class _ShowroomListScreenState extends State<ShowroomListScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: "Roboto",
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const AutoSizeText(
              "Showroom Frenchise",
              maxFontSize: 16,
            ),
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => {
                Get.back(),
              },
            ),
            actions: [
              GestureDetector(
                onTap: () => Get.to(() => const CartScreen()),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.shopping_cart,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 117),
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
                    ]),
              ),
            ),
          ),
        ));
  }
}
