import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:auto_size_text/auto_size_text.dart';
// ignore: unused_import
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lentera_ilmu/controllers/lms.dart';
import 'package:lentera_ilmu/controllers/media.dart';
import 'package:lentera_ilmu/screens/Showroom/showroom_screen.dart';
import 'package:lentera_ilmu/screens/media/article_screen.dart';

class ScreenShowroom extends StatefulWidget {
  const ScreenShowroom({Key? key}) : super(key: key);

  @override
  State<ScreenShowroom> createState() => _ScreenShowroomState();
}

class _ScreenShowroomState extends State<ScreenShowroom> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final mediaController = Get.put(MediaController());
  final lmsController = Get.put(LMSController());

  Future refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    lmsController.getHomeData();
    mediaController.onInit();
  }

  // final List<Widget> myData = [
  //   Container(
  //     margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
  //     child: ClipRRect(
  //         borderRadius: const BorderRadius.all(Radius.circular(8)),
  //         child: Stack(
  //           children: <Widget>[
  //             Image.asset(
  //               "assets/img/Iklan.png",
  //               fit: BoxFit.cover,
  //               width: 1000.0,
  //             ),
  //             Positioned(
  //               bottom: 0.0,
  //               left: 0.0,
  //               right: 0.0,
  //               child: Container(
  //                 decoration: const BoxDecoration(
  //                   gradient: LinearGradient(
  //                     colors: [
  //                       Color(0xffF0B666),
  //                       Color(0xFFF05656),
  //                     ],
  //                     begin: Alignment.bottomCenter,
  //                     end: Alignment.topCenter,
  //                   ),
  //                 ),
  //                 padding: const EdgeInsets.symmetric(
  //                   vertical: 10.0,
  //                   horizontal: 20.0,
  //                 ),
  //                 child: const AutoSizeText(
  //                   "100% Keuntungan Milik Mitra",
  //                   style: TextStyle(
  //                     color: Color(0xFFFFFFFF),
  //                     fontSize: 16.0,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                   maxFontSize: 16,
  //                   minFontSize: 14,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         )),
  //   ),
  //   Container(
  //     margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
  //     child: ClipRRect(
  //         borderRadius: const BorderRadius.all(Radius.circular(8)),
  //         child: Stack(
  //           children: <Widget>[
  //             Image.asset(
  //               "assets/img/Iklan2.png",
  //               fit: BoxFit.cover,
  //               width: 1000.0,
  //             ),
  //             Positioned(
  //               bottom: 0.0,
  //               left: 0.0,
  //               right: 0.0,
  //               child: Container(
  //                 decoration: const BoxDecoration(
  //                   gradient: LinearGradient(
  //                     colors: [
  //                       Color(0xFFF05656),
  //                       Color(0xff997693),
  //                     ],
  //                     begin: Alignment.bottomCenter,
  //                     end: Alignment.topCenter,
  //                   ),
  //                 ),
  //                 padding: const EdgeInsets.symmetric(
  //                   vertical: 10.0,
  //                   horizontal: 20.0,
  //                 ),
  //                 child: const AutoSizeText(
  //                   "Nikmati Keuntungannya Bersama - sama",
  //                   style: TextStyle(
  //                     color: Color(0xFFFFFFFF),
  //                     fontSize: 16.0,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                   maxFontSize: 16,
  //                   minFontSize: 14,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         )),
  //   ),
  //   Container(
  //     margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
  //     child: ClipRRect(
  //         borderRadius: const BorderRadius.all(Radius.circular(8)),
  //         child: Stack(
  //           children: <Widget>[
  //             Image.asset(
  //               "assets/img/promo menarik.png",
  //               fit: BoxFit.cover,
  //               width: 1000.0,
  //             ),
  //             Positioned(
  //               bottom: 0.0,
  //               left: 0.0,
  //               right: 0.0,
  //               child: Container(
  //                 decoration: const BoxDecoration(
  //                   gradient: LinearGradient(
  //                     colors: [
  //                       Colors.teal,
  //                       Color.fromARGB(200, 0, 0, 0),
  //                     ],
  //                     begin: Alignment.bottomCenter,
  //                     end: Alignment.topCenter,
  //                   ),
  //                 ),
  //                 padding: const EdgeInsets.symmetric(
  //                   vertical: 10.0,
  //                   horizontal: 20.0,
  //                 ),
  //                 child: const AutoSizeText(
  //                   "Promo Menarik Dari Berbagai Jenis Waralaba Hanya Ada Di Lentera Ilmu",
  //                   style: TextStyle(
  //                     color: Color(0xFFFFFFFF),
  //                     fontSize: 16.0,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                   maxFontSize: 16,
  //                   minFontSize: 14,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         )),
  //   ),
  // ];

  @override
  void initState() {
    super.initState();
    // Upgrader.clearSavedSettings();
    mediaController.onInit();
    lmsController.onInit();
    lmsController.getHomeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          "Showroom Frenchise",
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
                    CarouselSlider(
                      items: mediaController.articles
                          .map(
                            (item) => GestureDetector(
                              onTap: () => {
                                Get.to(
                                  () => ArticleScreen(
                                    article: item,
                                  ),
                                ),
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 8),
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    child: Stack(
                                      children: <Widget>[
                                        Image.network(item.thumbnail,
                                            fit: BoxFit.cover, width: 1000.0),
                                        Positioned(
                                          bottom: 0.0,
                                          left: 0.0,
                                          right: 0.0,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color.fromARGB(200, 0, 0, 0),
                                                  Color.fromARGB(0, 0, 0, 0)
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                              ),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10.0,
                                              horizontal: 20.0,
                                            ),
                                            child: AutoSizeText(
                                              item.title,
                                              style: const TextStyle(
                                                color: Color(0xFFFFFFFF),
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxFontSize: 16,
                                              minFontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          )
                          .toList(),
                      carouselController: _controller,
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 3,
                        viewportFraction: 1,
                        autoPlayInterval: const Duration(seconds: 5),
                        onPageChanged: (index, reason) {
                          setState(
                            () {
                              _current = index;
                            },
                          );

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children:
                          //       showroomController.asMap().entries.map((entry) {
                          //     return GestureDetector(
                          //       onTap: () =>
                          //           _controller.animateToPage(entry.key),
                          //       child: Container(
                          //         width: 12.0,
                          //         height: 12.0,
                          //         margin: const EdgeInsets.symmetric(
                          //             vertical: 8.0, horizontal: 4.0),
                          //         decoration: BoxDecoration(
                          //             shape: BoxShape.circle,
                          //             color: (Theme.of(context).brightness ==
                          //                         Brightness.dark
                          //                     ? Colors.white
                          //                     : const Color(0XFFE984A2))
                          //                 .withOpacity(_current == entry.key
                          //                     ? 0.9
                          //                     : 0.4)),
                          //       ),
                          //     );
                          //   }).toList(),
                          // );
                        },
                      ),
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
                          () => const ShowroomScreen(),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 235,
                              width: 197,
                              decoration: const BoxDecoration(
                                color: Color(0XFFF3F3F3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Image.asset(
                                      "assets/img/Risoles.png",
                                      width: 180,
                                      height: 108,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: Container(
                                      width: 140,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: Color(0XFFD594A8),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 7),
                                        child: Text(
                                          "Risol Mayo Bang Deny",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 33),
                                    child: Text(
                                      "PT Indonesian Kuliner",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          color:
                                              Color.fromARGB(113, 37, 36, 36),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Image.asset(
                                      "assets/img/Dessert.png",
                                      width: 180,
                                      height: 108,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: Container(
                                      width: 140,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: Color(0XFFD594A8),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 7),
                                        child: Text(
                                          "Dessert By Najla",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 37),
                                    child: Text(
                                      "PT Kuliner Nusantara",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          color:
                                              Color.fromARGB(113, 37, 36, 36),
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
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Image.asset(
                                "assets/img/Kas_solo.png",
                                width: 180,
                                height: 108,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Container(
                                width: 140,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Color(0XFFD594A8),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 7),
                                  child: Text(
                                    "Dapur Solo Mbo",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 16,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 63),
                              child: Text(
                                "PT Boga Bersama",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    color: Color.fromARGB(113, 37, 36, 36),
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
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Image.asset(
                                      "assets/img/Kebab.jpg",
                                      width: 180,
                                      height: 108,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: Container(
                                      width: 140,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: Color(0XFFD594A8),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 7),
                                        child: Text(
                                          "Kebab Baba Ali",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 65),
                                    child: Text(
                                      "PT Kuliner Group",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          color:
                                              Color.fromARGB(113, 37, 36, 36),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
