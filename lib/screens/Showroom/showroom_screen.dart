import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/screens/Showroom/deskripsi.dart';
import 'package:lentera_ilmu/screens/Showroom/produk_showroom.dart';
import 'package:lentera_ilmu/screens/transaction/cart/cart_screen.dart';
// ignore: unused_import
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
                  "PT Indonesian Kuliner",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: Color(0x70252424),
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(thickness: 6),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DeskripsiShowroom()),
                    );
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Deskripsi",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: const [
                            Text.rich(
                              TextSpan(
                                text:
                                    "Adalah bisnis kuliner UMKM Indonesia yang menjual berbagai produk olahan makanan ringan lainnya, seperti cake, risoles, kebab dll nya.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w600,
                                  color: Color(0x70252424),
                                ),
                                children: [
                                  TextSpan(
                                    text: " \n\nBaca Selengkapnya",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: Colors.teal,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
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
                    text: "Harga Frenchise\n",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600,
                      color: Colors.black45,
                    ),
                    children: [
                      TextSpan(
                        text: "Rp.10.000.000",
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
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 17,
                ),
                child: Divider(thickness: 6),
              ),
              Row(
                children: [
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 17, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/img/user_pic.png",
                            width: 58,
                            height: 58,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 17, left: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "PT Indonesian Kuliner",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Kota Bandung",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            color: Color(0x70252424),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          height: 65,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(0XFFF6F7F8),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 17,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 115,
                ),
                SizedBox(
                  width: 70,
                  height: 45,
                  child: TextButton.icon(
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.local_mall,
                        size: 27,
                      ),
                    ),
                    label: const Text(
                      "",
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(11)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.teal),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side:
                              const BorderSide(width: 2.0, color: Colors.teal),
                        ),
                      ),
                    ),
                    onPressed: () => Get.to(
                      () => const ProdukShowroom(),
                      transition: Transition.rightToLeft,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                      child: const Text(
                        "Beli Showroom",
                        style: TextStyle(fontSize: 14),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(14)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.teal),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            side: BorderSide(color: Colors.teal),
                          ),
                        ),
                      ),
                      onPressed: () => ProdukShowroom()),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
