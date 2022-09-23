import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/library.dart';
import 'package:lentera_ilmu/screens/course/course_screen.dart';
import 'package:lentera_ilmu/screens/subscription/subscription_screen.dart';
import 'package:lentera_ilmu/screens/widgets/list_item_library.dart';

class MyLibraryScreen extends StatefulWidget {
  const MyLibraryScreen({Key? key}) : super(key: key);

  @override
  _MyLibraryScreen createState() => _MyLibraryScreen();
}

class _MyLibraryScreen extends State<MyLibraryScreen> {
  final libraryController = Get.put(LibraryController());
  @override
  void initState() {
    super.initState();
    libraryController.onInit();
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const AutoSizeText(
            "Program dan Kursus Saya",
            maxFontSize: 16,
          ),
          centerTitle: true,
        ),
        body: GetBuilder<LibraryController>(
          builder: (library) {
            return SingleChildScrollView(
              // ignore: prefer_is_empty
              child: library.my_subscriptions.length > 0 ||
                      // ignore: prefer_is_empty
                      library.my_courses.length > 0
                  ? Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          // ignore: prefer_is_empty
                          library.my_subscriptions.length > 0
                              ? Container(
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      AutoSizeText(
                                        "Program Saya",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxFontSize: 16,
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          for (var item in library.my_subscriptions)
                            GestureDetector(
                              onTap: () => Get.to(
                                () => SubscriptionScreen(
                                  subscriptionId: item.subscription_id,
                                ),
                              ),
                              child: ListItemLibrary(
                                title: item.subscription_product?.name ?? "",
                                description:
                                    item.subscription_product?.descriptions ??
                                        "",
                                thumbnail:
                                    item.subscription_product?.thumbnail ?? "",
                                valid_until: item.valid_until,
                                type: "subscription",
                              ),
                            ),
                          library.my_courses.isNotEmpty
                              ? Container(
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      AutoSizeText(
                                        "Kursus Saya",
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxFontSize: 16,
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          for (var item in library.my_courses)
                            GestureDetector(
                              onTap: () => Get.to(
                                () => CourseScreen(
                                  courseId: item.course?.id ?? 0,
                                  lock: false,
                                ),
                              ),
                              child: ListItemLibrary(
                                title: item.course?.title ?? "",
                                description: item.course?.description ?? "",
                                thumbnail: item.course?.thumbnail ?? "",
                                type: "course",
                              ),
                            ),
                        ],
                      ),
                    )
                  : Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 80),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/img/empty/course.png",
                              width: MediaQuery.of(context).size.width * .60,
                            ),
                            const Padding(padding: EdgeInsets.all(6)),
                            const AutoSizeText(
                              "Ups..",
                              maxFontSize: 14,
                              textAlign: TextAlign.center,
                            ),
                            const AutoSizeText(
                              "Anda belum melakukan pembelian program atau kursus",
                              maxFontSize: 14,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
