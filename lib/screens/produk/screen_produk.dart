// ignore: unused_import
import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/screens/produk/produk.dart';

class ScreenProduk extends StatefulWidget {
  const ScreenProduk({Key? key}) : super(key: key);

  @override
  State<ScreenProduk> createState() => _ScreenProdukState();
}

class _ScreenProdukState extends State<ScreenProduk> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<Widget> myData = [
    Container(
      margin: const EdgeInsets.all(8),
      width: 382,
      height: 167,
      decoration: const BoxDecoration(
        color: Color(0xFFF05656),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 15,
            ),
            child: Text(
              "Solusi tepat\nbelajar\nmengatur\nkeuangan",
              style: TextStyle(
                fontFamily: "JosefinSans",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0XFFE9EEF4),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Container(
              width: 146,
              height: 173,
              decoration: BoxDecoration(
                color: const Color(0XFFF8E6CB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/img/Morgan.png",
                    width: 143,
                    height: 130,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      margin: const EdgeInsets.all(8),
      width: 382,
      height: 167,
      decoration: const BoxDecoration(
        color: Color(0xFFF05656),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 15,
            ),
            child: Text(
              "Selalu ada\npromo,\nmenarik!",
              style: TextStyle(
                fontFamily: "JosefinSans",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0XFFE9EEF4),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 42),
            child: Container(
              width: 148,
              height: 173,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 92, 92, 90),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/img/Toolkin.png",
                    width: 143,
                    height: 130,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      margin: const EdgeInsets.all(8),
      width: 382,
      height: 167,
      decoration: const BoxDecoration(
        color: Color(0xFFF05656),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 15,
            ),
            child: Text(
              "Bawa Pulang\nbukunya dan\ndapatkan diskon\nspesial!",
              style: TextStyle(
                fontFamily: "JosefinSans",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0XFFE9EEF4),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Container(
              width: 116,
              height: 173,
              decoration: BoxDecoration(
                color: const Color(0XFFF8D49B),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/img/book.png",
                    width: 115,
                    height: 130,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      margin: const EdgeInsets.all(8),
      width: 382,
      height: 167,
      decoration: const BoxDecoration(
        color: Color(0xFFF05656),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 15,
            ),
            child: Text(
              "Membangun\nkebiasaan\nbaik dari hal,\nterkecil",
              style: TextStyle(
                fontFamily: "JosefinSans",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0XFFE9EEF4),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17),
            child: Container(
              width: 144,
              height: 173,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 214, 183, 136),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/img/Automic.png",
                    width: 143,
                    height: 130,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          "Produk",
          maxFontSize: 16,
        ),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 187,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: CarouselSlider(
                        items: myData,
                        carouselController: _controller,
                        options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: myData.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : const Color(0XFFE984A2))
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(
                          () => const ProdukScreen(),
                        ),
                        child: Container(
                          height: 235,
                          width: 197,
                          decoration: const BoxDecoration(
                            color: Color(0XFFF3F3F3),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            // boxShadow: <BoxShadow>[
                            //   BoxShadow(
                            //     color: Colors.black26,
                            //     blurRadius: 5.0,
                            //     offset: Offset(1, 2),
                            //   ),
                            // ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Image.asset(
                                  "assets/img/Automic.png",
                                  width: 80,
                                  height: 108,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Column(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Text(
                                      "Buku Self Improvement\nAutomic Habbits",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 17,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 92),
                                child: Text(
                                  "Rp. 100.000",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: Colors.teal,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 235,
                              width: 197,
                              decoration: const BoxDecoration(
                                color: Color(0XFFF3F3F3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                // boxShadow: <BoxShadow>[
                                //   BoxShadow(
                                //     color: Colors.black26,
                                //     blurRadius: 5.0,
                                //     offset: Offset(1, 2),
                                //   ),
                                // ],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Image.asset(
                                      "assets/img/Morgan.png",
                                      width: 80,
                                      height: 108,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Column(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Text(
                                          "Buku Self Improvement Psychology Money",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 17,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 92),
                                    child: Text(
                                      "Rp. 87.000",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          color: Colors.teal,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 235,
                        width: 197,
                        decoration: const BoxDecoration(
                          color: Color(0XFFF3F3F3),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          // boxShadow: <BoxShadow>[
                          //   BoxShadow(
                          //     color: Colors.black26,
                          //     blurRadius: 5.0,
                          //     offset: Offset(1, 2),
                          //   ),
                          // ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Image.asset(
                                "assets/img/Filosofi-Teras.png",
                                width: 80,
                                height: 108,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Column(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Text(
                                    "Buku Self Improvement\nFilsafat Yunani Kuno",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 17,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 92),
                              child: Text(
                                "Rp. 110.000",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    color: Colors.teal,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 235,
                              width: 197,
                              decoration: const BoxDecoration(
                                color: Color(0XFFF3F3F3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                // boxShadow: <BoxShadow>[
                                //   BoxShadow(
                                //     color: Colors.black26,
                                //     blurRadius: 5.0,
                                //     offset: Offset(1, 2),
                                //   ),
                                // ],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Image.asset(
                                      "assets/img/Buku-Investor.png",
                                      width: 80,
                                      height: 108,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Column(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Text(
                                          "Warrent & Lo Kheng\nUntuk Investor Pemula",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 17,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 92),
                                        child: Text(
                                          "Rp. 65.000",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              color: Colors.teal,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
    );
  }
}
