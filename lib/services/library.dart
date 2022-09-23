import 'package:lentera_ilmu/models/lms/user_course.dart';
import 'package:lentera_ilmu/models/lms/user_subscription.dart';
import 'package:lentera_ilmu/services/service.dart';

class LibraryService extends ServiceAPI {
  Future<List<UserSubscriptionModel>> getMySubscriptions() async {
    try {
      final result = await get("$baseUrlLMS/mylibrary/subscriptions");
      return result
          .map<UserSubscriptionModel>(
              (json) => UserSubscriptionModel.fromJson(json))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<UserCourseModel>> getMyCourses() async {
    try {
      final result = await get("$baseUrlLMS/mylibrary/courses");
      return result
          .map<UserCourseModel>((json) => UserCourseModel.fromJson(json))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
