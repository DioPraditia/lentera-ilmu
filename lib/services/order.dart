// ignore: unused_import
import 'dart:convert';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:lentera_ilmu/models/lms/cart.dart';
import 'package:lentera_ilmu/services/service.dart';

class OrderService extends ServiceAPI {
  Future<String> addToCart(
      {required int courseId, required String courseTitle}) async {
    try {
      await post(
        "$baseUrlLMS/order/cart",
        data: {'course_id': courseId, 'course_title': courseTitle},
      );
      return "Cart berhasil ditambahkan.";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<CartModel>> listCart() async {
    try {
      final result = await get(
        "$baseUrlLMS/order/cart/list",
        queryParameters: {
          "pagination": false,
        },
      );
      return result['items']
          .map<CartModel>((json) => CartModel.fromJson(json))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> deleteCartItem(int orderId) async {
    try {
      await delete(
        "$baseUrlLMS/order/cart",
        queryParameters: {"id": orderId},
      );
      return "Data berhasil dihapus";
    } catch (e) {
      throw e.toString();
    }
  }
}
