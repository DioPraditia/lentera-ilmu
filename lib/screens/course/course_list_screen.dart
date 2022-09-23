import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/lms.dart';
import 'package:lentera_ilmu/models/lms/category.dart';
import 'package:lentera_ilmu/models/lms/course.dart';
import 'package:lentera_ilmu/screens/course/course_screen.dart';
import 'package:lentera_ilmu/screens/navigation.dart';
import 'package:lentera_ilmu/screens/transaction/cart/cart_screen.dart';
import 'package:lentera_ilmu/screens/widgets/list_course_item.dart';

class CourseListScreen extends StatefulWidget {
  final CategoryModel? category;
  const CourseListScreen({Key? key, this.category}) : super(key: key);

  @override
  _CourseListScreen createState() => _CourseListScreen();
}

class _CourseListScreen extends State<CourseListScreen> {
  late ScrollController scrollController;
  final lmsController = Get.put(LMSController());
  bool checkLock(CourseModel course, bool login) {
    bool lock = true;
    if (course.price_type == "free") {
      if (course.member == 1) {
        if (login == true) {
          lock = false;
        } else {
          lock = true;
        }
      } else {
        lock = false;
      }
    } else {
      lock = true;
    }
    return lock;
  }

  @override
  void initState() {
    super.initState();
    lmsController.getCourses(
      page: 0,
      size: 20,
      restartData: true,
      catgeoryId: widget.category?.id,
      withLoading: true,
    );
    scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      lmsController.getCourses(
        page: lmsController.lastPage + 1,
        size: 20,
        restartData: false,
        catgeoryId: widget.category?.id,
      );
    }
    if (scrollController.offset <= 0) {
      lmsController.getCourses(
        page: 0,
        size: 20,
        restartData: false,
        catgeoryId: widget.category?.id,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    Get.off(() => const BottomNavBar());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Roboto',
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: AutoSizeText(
              widget.category?.name ?? "Kursus",
              maxFontSize: 16,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => {
                lmsController.getHomeData(),
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
          body: GetBuilder<LMSController>(
            builder: (course) => course.courseLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.teal,
                    ),
                  )
                : course.courses.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/img/empty/coming_soon.png",
                              width: MediaQuery.of(context).size.width * .60,
                            ),
                            const Padding(padding: EdgeInsets.all(14)),
                            const Padding(
                              padding: EdgeInsets.all(14),
                              child: Text(
                                "Produk belum tersedia. Silahkan kunjungi halaman ini dilain waktu...",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.all(24)),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  // ignore: deprecated_member_use
                                  primary: Colors.white,
                                  minimumSize: const Size(50, 16),
                                  padding: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0),
                                  ),
                                ),
                                onPressed: () => {
                                  Get.back(),
                                  lmsController.getHomeData(),
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80.0),
                                    color: Colors.teal,
                                  ),
                                  padding: const EdgeInsets.all(0),
                                  child: const AutoSizeText(
                                    "Kembali",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    maxFontSize: 14,
                                  ),
                                ),
                              ),
                              // RaisedButton(
                              //onPressed: () => {
                              //  Get.back(),
                              //  lmsController.getHomeData(),
                              //},
                              //shape: RoundedRectangleBorder(
                              //  borderRadius: BorderRadius.circular(80.0),
                              //),
                              //disabledTextColor: Colors.white,
                              //textColor: Colors.white,
                              //padding: const EdgeInsets.all(0),
                              //child: Container(
                              //  alignment: Alignment.center,
                              //  height: 50.0,
                              //  width:
                              //      MediaQuery.of(context).size.width * 0.5,
                              //  decoration: BoxDecoration(
                              //    borderRadius: BorderRadius.circular(80.0),
                              //    color: Colors.teal,
                              //  ),
                              //  padding: const EdgeInsets.all(0),
                              //  child: const AutoSizeText(
                              //    "Kembali",
                              //    textAlign: TextAlign.center,
                              //    style:
                              //        TextStyle(fontWeight: FontWeight.bold),
                              //    maxFontSize: 14,
                              // ),
                              // ),
                              //),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: course.courses.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () => Get.to(
                              () => CourseScreen(
                                  courseId: course.courses[index].id,
                                  lock: checkLock(
                                    course.courses[index],
                                    lmsController.isLogin,
                                  )),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              child: ListCourseItem(
                                image: course.courses[index].thumbnail ?? '',
                                title: course.courses[index].title,
                                mentor: course.courses[index].creator_name,
                                descriptions: course.courses[index].description!
                                            .length >
                                        65
                                    ? "${course.courses[index].description!.substring(0, 65)}..."
                                    : course.courses[index].description!,
                                price: lmsController.courses[index].price,
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ),
      ),
    );
  }
}
