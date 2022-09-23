import 'package:get/get.dart';
import 'package:lentera_ilmu/models/lms/user_course.dart';
import 'package:lentera_ilmu/models/lms/user_subscription.dart';
import 'package:lentera_ilmu/services/library.dart';
import 'package:lentera_ilmu/services/utils.dart';

class LibraryController extends GetxController {
  int lastPage = 0;
  final libraryService = LibraryService();
  // ignore: non_constant_identifier_names
  late List<UserCourseModel> my_courses = <UserCourseModel>[].obs;
  // ignore: non_constant_identifier_names
  late List<UserSubscriptionModel> my_subscriptions =
      <UserSubscriptionModel>[].obs;
  bool loading = false;

  @override
  void onInit() async {
    super.onInit();
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    getMyCourses();
    getMySubscriptions();
    loading = false;
    update();
  }

  Future getMyCourses() async {
    try {
      my_courses = await libraryService.getMyCourses();
      loading = false;
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  Future getMySubscriptions() async {
    try {
      my_subscriptions = await libraryService.getMySubscriptions();
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }
}
