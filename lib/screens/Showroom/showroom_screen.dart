import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/screens/transaction/cart/cart_screen.dart';
import 'package:lentera_ilmu/controllers/order.dart';

class ShowroomScreen extends StatefulWidget {
  const ShowroomScreen({Key? key}) : super(key: key);

  @override
  State<ShowroomScreen> createState() => _ShowroomScreenState();
}

class _ShowroomScreenState extends State<ShowroomScreen> {
  double edge = 24;
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: avoid_unnecessary_containers
              Container(
                child: Image.asset(
                  "assets/img/Risoles.png",
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  width: 130,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0XFFD594A8),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "Food and Beverage",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      "Risol Mayo Bang Deny",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 205),
                    child: Image.asset(
                      'assets/img/Illustration_transaction.png',
                      width: 30,
                      height: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  "PT Indonesian Kuliner adalah bisnis kuliner UMKM Indonesia\nyang menjual berbagai produk olahan makanan ringan lainnya, seperti cake, risoles, kebab dll nya. ",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: Color(0x70252424),
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 12,
                ),
                child: Text.rich(
                  TextSpan(
                    text: "Mulai Dari\n",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600,
                      color: Colors.black45,
                    ),
                    children: [
                      TextSpan(
                        text: "Rp.300.000",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                        ),
                        children: [
                          TextSpan(
                            text: "",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black45,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 46,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: edge,
                ),
                height: 48,
                width: MediaQuery.of(context).size.width - (2 * edge),
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      )),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()));
                  },
                  child: const Text(
                    'Beli Showroom',
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
