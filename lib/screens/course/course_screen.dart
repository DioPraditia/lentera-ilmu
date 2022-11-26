import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/lms.dart';
import 'package:lentera_ilmu/controllers/order.dart';
import 'package:lentera_ilmu/screens/course/deskripsi_course.dart';
// ignore: unused_import
import 'package:lentera_ilmu/screens/course/youtube_video_player.dart';
import 'package:lentera_ilmu/screens/login/login_screen.dart';
// ignore: unused_import
import 'package:lentera_ilmu/screens/register/register_screen.dart';
import 'package:lentera_ilmu/screens/transaction/cart/cart_screen.dart';
import 'package:lentera_ilmu/services/utils.dart';

// ignore: must_be_immutable
class CourseScreen extends StatefulWidget {
  int courseId;
  bool lock = true;
  CourseScreen({Key? key, required this.courseId, required this.lock})
      : super(key: key);

  @override
  _CourseScreen createState() => _CourseScreen();
}

class _CourseScreen extends State<CourseScreen> {
  final lmsController = Get.put(LMSController());
  final orderController = Get.put(OrderController());
  @override
  void initState() {
    super.initState();
    lmsController.getCourse(widget.courseId);
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
      home: GetBuilder<LMSController>(builder: (lms) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const AutoSizeText(
              "Kursus",
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
          body: lms.loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .45,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                image: NetworkImage(
                                    lms.course.image ?? lms.course.thumbnail!),
                                fit: BoxFit.fill,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                            // child: Text("dsmslk"),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(48),
                            topRight: Radius.circular(48),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              lms.course.creator_name,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.purple,
                              ),
                              maxFontSize: 12,
                              maxLines: 1,
                            ),
                            const Padding(padding: EdgeInsets.all(1)),
                            AutoSizeText(
                              lms.course.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                              maxFontSize: 16,
                            ),
                            const Padding(padding: EdgeInsets.all(1)),
                            lms.course.user_course == null &&
                                    widget.lock == true
                                ? Text(
                                    double.parse(lms.course.price) == 0
                                        ? "Gratis"
                                        : formatCurrency.format(
                                            double.parse(lms.course.price)),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.teal,
                                    ),
                                  )
                                : Container(),
                            const Padding(padding: EdgeInsets.all(8)),
                            const SizedBox(
                              height: 10,
                            ),
                            lms.course.price_type != "on_time_payment" &&
                                    lms.course.member == 1 &&
                                    lms.isLogin == false
                                ? SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        child: const Text(
                                          "Login akun untuk membuka konten terkunci",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                                  EdgeInsets>(
                                              const EdgeInsets.all(14)),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.teal),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              side: BorderSide(
                                                  color: Colors.teal),
                                            ),
                                          ),
                                        ),
                                        onPressed: () =>
                                            Get.to(() => LoginScreen())),
                                  )
                                : const Padding(padding: EdgeInsets.all(2)),
                            // ignore: avoid_unnecessary_containers
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DeskripsiCourse(
                                            lock: widget.lock,
                                          )),
                                );
                              },
                              // ignore: avoid_unnecessary_containers
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Detail Kursus",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        AutoSizeText.rich(
                                          TextSpan(
                                            text: lms.course.description!,
                                            children: const [
                                              TextSpan(
                                                text: " \n\nBaca Selengkapnya",
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 12,
                                                  color: Colors.teal,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          maxFontSize: 12,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 17),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 115,
                            ),
                            lms.course.user_course == null &&
                                    widget.lock == true &&
                                    lms.course.price_type == "on_time_payment"
                                ? SizedBox(
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
                                          padding: MaterialStateProperty.all<
                                                  EdgeInsets>(
                                              const EdgeInsets.all(11)),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.teal),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: const BorderSide(
                                                  width: 2.0,
                                                  color: Colors.teal),
                                            ),
                                          ),
                                        ),
                                        onPressed: () => orderController
                                            .addToCart(lms.course, context)),
                                  )
                                : Container(),
                            const SizedBox(
                              width: 10,
                            ),
                            lms.course.user_course == null &&
                                    widget.lock == true &&
                                    lms.course.price_type == "on_time_payment"
                                ? SizedBox(
                                    width: 300,
                                    child: ElevatedButton(
                                      child: const Text(
                                        "Beli Sekarang",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                            const EdgeInsets.all(14)),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.teal),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            side:
                                                BorderSide(color: Colors.teal),
                                          ),
                                        ),
                                      ),
                                      onPressed: () => {
                                        orderController.addToCartBuy(
                                            lms.course, context)
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        );
      }),
    );
  }
}
