import 'package:lentera_ilmu/models/lms/category.dart';
import 'package:lentera_ilmu/models/lms/course.dart';
import 'package:lentera_ilmu/models/lms/subscription.dart';
import 'package:lentera_ilmu/services/service.dart';

class LMSService extends ServiceAPI {
  Future<List<CategoryModel>> getListCategory() async {
    try {
      final result = await get(
        "$baseUrlLMS/category/list",
        queryParameters: {"pagination": false},
      );
      return result['items']
          .map<CategoryModel>((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<CourseModel>> getListCourses(
      {required int page,
      required int size,
      int? categoryId,
      String? search = ""}) async {
    try {
      final result = await get(
        "$baseUrlLMS/course/list",
        queryParameters: {
          "pagination": false,
          "page": page,
          "size": size,
          "category_id": categoryId ?? "",
          "search": search,
        },
      );
      return result['items']
          .map<CourseModel>((json) => CourseModel.fromJson(json))
          .toList();
    } catch (e) {
      // ignore: avoid_print
      print(e);
      throw e.toString();
    }
  }

  Future<CourseModel> getCourse(int courseId) async {
    try {
      final result = await get(
        "$baseUrlLMS/course",
        queryParameters: {"id": courseId},
      );
      return CourseModel.fromJson(result);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<SubscriptionModel>> getListSubscriptions(
      int page, int size) async {
    try {
      final result = await get(
        "$baseUrlLMS/subscription/list",
        queryParameters: {
          "pagination": false,
          "page": page,
          "size": size,
        },
      );
      return result['items']
          .map<SubscriptionModel>((json) => SubscriptionModel.fromJson(json))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<SubscriptionModel> getSubscription(int subscriptionID) async {
    try {
      final result = await get(
        "$baseUrlLMS/subscription",
        queryParameters: {"id": subscriptionID},
      );
      return SubscriptionModel.fromJson(result);
    } catch (e) {
      throw e.toString();
    }
  }
}
