// ignore: unused_import
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/screens/home/home_screen.dart';
import 'package:lentera_ilmu/screens/produk/deskripsi_produk.dart';

class ProdukScreen extends StatefulWidget {
  const ProdukScreen({Key? key}) : super(key: key);

  @override
  State<ProdukScreen> createState() => _ProdukScreenState();
}

class _ProdukScreenState extends State<ProdukScreen> {
  double edge = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          "Produk",
          maxFontSize: 16,
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => {
            Get.back(),
          },
        ),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          SafeArea(
            child: Stack(
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Color(0XFFF3F3F3),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(48),
                      bottomRight: Radius.circular(48),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 27, left: 110),
                  child: Image.asset(
                    "assets/img/Automic.png",
                    width: 190,
                    height: 225,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 317, left: 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Rp.100.000",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Buku Self Improvement Automic Habbits",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 375, left: 17),
                  child: Row(
                    children: [
                      const Text(
                        "Terjual 10,5 rb",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            color: Color(0x70252424),
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            TextButton.icon(
                              onPressed: () => const HomeScreen(),
                              icon: const Padding(
                                padding: EdgeInsets.only(left: 2),
                                child: Icon(
                                  Icons.star,
                                  size: 20,
                                ),
                              ),
                              label: const Text(
                                "4.9",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(7)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFFEEB109)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(
                                        width: 2.0, color: Colors.black12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 435),
                  child: Divider(thickness: 6),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 465, left: 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 12, right: 12),
                      ),
                      // ignore: avoid_unnecessary_containers
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Deskripsi()),
                          );
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Detail Produk",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins"),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 27, right: 227),
                                    child: Text(
                                      "Kondisi                         Baru",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w600,
                                        color: Color(0x70252424),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Divider(thickness: 1.5),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, right: 227),
                                    child: Text(
                                      "Min. Order                 1 Buah",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w600,
                                        color: Color(0x70252424),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Divider(thickness: 1.5),
                                ],
                              ),
                              Column(
                                children: const [
                                  Text.rich(
                                    TextSpan(
                                      text:
                                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
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
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 727,
                  ),
                  child: Divider(thickness: 6),
                ),
                Row(
                  children: [
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 757, left: 17),
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
                      padding: const EdgeInsets.only(top: 757, left: 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Lentera Ilmu",
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
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
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
                      Icons.add_shopping_cart_rounded,
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
                        side: const BorderSide(width: 2.0, color: Colors.teal),
                      ),
                    ),
                  ),
                  onPressed: () => null,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                    child: const Text(
                      "Beli Sekarang",
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
                    onPressed: () => null),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
