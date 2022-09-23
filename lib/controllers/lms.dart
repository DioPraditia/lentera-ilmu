import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/media.dart';
import 'package:lentera_ilmu/models/lms/category.dart';
import 'package:lentera_ilmu/models/lms/course.dart';
import 'package:lentera_ilmu/models/lms/course_module_item.dart';
import 'package:lentera_ilmu/models/lms/subscription.dart';
import 'package:lentera_ilmu/models/payment/transaction.dart';
import 'package:lentera_ilmu/services/lms.dart';
import 'package:lentera_ilmu/services/payment.dart';
import 'package:lentera_ilmu/services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class LMSController extends GetxController {
  int lastPage = 0;
  final lmsService = LMSService();
  final paymentService = PaymentService();
  late List<CategoryModel> categories = <CategoryModel>[].obs;
  late List<CourseModel> courses = <CourseModel>[].obs;
  late List<SubscriptionModel> subscriptions = <SubscriptionModel>[].obs;

  late CourseModel course = <CourseModel>{}.single;
  CourseModuleItem? selectedCourse;
  late SubscriptionModel subscription = <SubscriptionModel>{}.single;
  bool loading = false;
  bool shimmerLoading = false;
  bool ytLoading = false;
  late VideoPlayerController videoPlayer;
  late YoutubePlayerController youtubeController;
  final mediaController = Get.put(MediaController());
  TransactionModel? transaction;
  List<CourseModel> transactionCourseItmes = <CourseModel>[].obs;
  String? transactionSubscriptionName;

  final search = TextEditingController();
  // ignore: non_constant_identifier_names
  late List<CourseModel> search_courses = <CourseModel>[].obs;
  bool emptySearch = false;

  bool isLogin = false;
  bool courseLoading = false;
  bool programLoading = false;

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool("is_login") ?? false;
    update();
  }

  Future<bool> getHomeData() async {
    courseLoading = true;
    loading = true;
    programLoading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    getCategories();
    getCourses(page: 0, size: 15, restartData: true);
    getListSubscriptions(0, 15, true);
    mediaController.getListArticle(0, 10, true);
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    return true;
  }

  setSelectedCourse(CourseModuleItem course) {
    if (course.source_type == 'video') {
      videoPlayer = VideoPlayerController.network(
        course.source_url,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      videoPlayer.play();
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
    }
    if (course.source_type == 'youtube') {
      youtubeController = YoutubePlayerController(
        initialVideoId: course.source_url,
        params: const YoutubePlayerParams(
          startAt: Duration(seconds: 0),
          showControls: true,
          showFullscreenButton: true,
          autoPlay: true,
          showVideoAnnotations: false,
          enableCaption: false,
          strictRelatedVideos: true,
          privacyEnhanced: true,
        ),
      );
      youtubeController.load(course.source_url);
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
    }
  }

  Future<void> getCategories() async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      categories = await lmsService.getListCategory();
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  Future<void> getCourses({
    required int page,
    required int size,
    required bool restartData,
    int? catgeoryId,
    bool withLoading = false,
    String search = "",
  }) async {
    if (withLoading) {
      courseLoading = true;
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
    }
    courses = [];
    try {
      courses = await lmsService.getListCourses(
          page: page, size: size, categoryId: catgeoryId, search: search);
      if (search != "") {
        search_courses = courses;
        if (search_courses.isEmpty) {
          emptySearch = true;
        }
      } else {
        search_courses.clear();
      }
      courseLoading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      courseLoading = false;
      update();
    }
  }

  Future getCourse(int courseId) async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      isLogin = prefs.getBool("is_login") ?? false;
      course = await lmsService.getCourse(courseId);
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  Future getTransaction(
      {required String trxCode, bool withLoading = false}) async {
    if (withLoading) {
      loading = true;
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
    }
    try {
      transaction = await paymentService.getTransaction(trxCode);
      if (transaction?.trx_type == "course") {
        var parsedCourse = (transaction?.items as List<dynamic>)
            .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
            .toList();
        transactionCourseItmes = parsedCourse;
      }
      if (transaction?.trx_type == "subscription") {
        transactionSubscriptionName = transaction?.items["subscription_name"];
      }
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  Future<void> getListSubscriptions(
      int page, int size, bool restartData) async {
    try {
      programLoading = true;
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
      subscriptions = await lmsService.getListSubscriptions(page, size);
      programLoading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      programLoading = false;
      update();
    }
  }

  Future getSubscriptionDetails(int subscriptionID) async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      subscription = await lmsService.getSubscription(subscriptionID);
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  void clearSearch() {
    search.text = "";
    courses.clear();
    emptySearch = false;
    update();
  }

  void getShowroom(int courseId) {}
}
