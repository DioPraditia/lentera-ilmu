import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/lms.dart';
import 'package:lentera_ilmu/screens/course/course_screen.dart';
import 'package:lentera_ilmu/screens/navigation.dart';
import 'package:lentera_ilmu/screens/widgets/list_course_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  late ScrollController scrollController;
  final lmsController = Get.put(LMSController());
  @override
  void initState() {
    super.initState();
    lmsController.courses.clear();
    scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  Future refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    lmsController.getCourses(
      page: lmsController.lastPage + 1,
      size: 20,
      restartData: false,
      search: lmsController.search.text,
    );
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      lmsController.getCourses(
        page: lmsController.lastPage + 1,
        size: 20,
        restartData: false,
        search: lmsController.search.text,
      );
    }
    if (scrollController.offset <= 0) {
      lmsController.getCourses(
        page: 0,
        size: 20,
        restartData: false,
        search: lmsController.search.text,
      );
    }
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
        home: GetBuilder<LMSController>(
          builder: (lms) {
            return Scaffold(
              appBar: AppBar(
                // The search area here
                backgroundColor: Colors.teal,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => {
                    lmsController.getHomeData(),
                    Get.to(() => const BottomNavBar()),
                  },
                ),
                title: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: TextField(
                      controller: lms.search,
                      autofocus: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.teal,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.teal,
                          ),
                          onPressed: () {
                            lms.clearSearch();
                          },
                        ),
                        hintText: 'Cari Kursus...',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        if (lms.search.text != "") {
                          lms.getCourses(
                            page: 0,
                            size: 20,
                            restartData: true,
                            withLoading: true,
                            search: lms.search.text,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              body: lms.loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.teal,
                      ),
                    )
                  : lms.search_courses.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/img/empty/search.png",
                                width: MediaQuery.of(context).size.width * .60,
                              ),
                              const Padding(padding: EdgeInsets.all(14)),
                              Text(lms.search_courses.isEmpty && lms.emptySearch
                                  ? "Kurus yang kamu cari tidak ditemukan."
                                  : "Silahkan cari kursus yang Kamu mau."),
                              const Padding(padding: EdgeInsets.all(24)),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          color: Colors.teal,
                          onRefresh: () => refreshData(),
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: lms.search_courses.length,
                            scrollDirection: Axis.vertical,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                onTap: () => Get.to(
                                  () => CourseScreen(
                                    courseId: lms.search_courses[index].id,
                                    lock: true,
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  child: ListCourseItem(
                                    image:
                                        lms.search_courses[index].thumbnail ??
                                            '',
                                    title: lms.search_courses[index].title,
                                    mentor:
                                        lms.search_courses[index].creator_name,
                                    descriptions: lms.search_courses[index]
                                                .description!.length >
                                            65
                                        ? "${lms.search_courses[index].description!.substring(0, 65)}..."
                                        : lms
                                            .search_courses[index].description!,
                                    price: lmsController
                                        .search_courses[index].price,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            );
          },
        ),
      ),
    );
  }
}
