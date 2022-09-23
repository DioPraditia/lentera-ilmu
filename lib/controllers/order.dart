import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/models/lms/cart.dart';
import 'package:lentera_ilmu/models/lms/course.dart';
import 'package:lentera_ilmu/models/lms/subscription_price.dart';
import 'package:lentera_ilmu/models/payment/payment.dart';
import 'package:lentera_ilmu/screens/login/login_screen.dart';
import 'package:lentera_ilmu/screens/transaction/cart/cart_screen.dart';
import 'package:lentera_ilmu/screens/transaction/checkout/subscription_checkout_screen.dart';
import 'package:lentera_ilmu/screens/transaction/payment/transaction_screen.dart';
import 'package:lentera_ilmu/services/lms.dart';
import 'package:lentera_ilmu/services/order.dart';
import 'package:lentera_ilmu/services/payment.dart';
import 'package:lentera_ilmu/services/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController {
  final orderService = OrderService();
  final lmsService = LMSService();
  final paymentService = PaymentService();
  bool loading = false;
  late List<CartModel> carts = <CartModel>[].obs;
  double totalPrice = 0;
  int platformFee = 0;
  int bankFee = 0;
  late PaymentChannelModel? paymentChannel;

  @override
  void onInit() async {
    super.onInit();
    paymentChannel = null;
  }

  setPaymentChannel(PaymentChannelModel channel) {
    paymentChannel = channel;
    bankFee = channel.charge_amount;
    platformFee = channel.platform_fee;
    update();
  }

  addToCart(CourseModel course, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool("is_login") ?? false;
    if (!isLogin) {
      Get.to(() => LoginScreen());
    } else {
      try {
        showModalBottomSheet(
          isDismissible: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          context: context,
          builder: (builder) {
            return Container(
              height: MediaQuery.of(context).size.width * .7,
              color:
                  Colors.transparent, //could change this to Color(0xFF737373),
              //so you don't have to change MaterialApp canvasColor
              child: const Center(
                  child: CircularProgressIndicator(
                color: Colors.teal,
              )),
            );
          },
        );
        await orderService.addToCart(
          courseId: course.id,
          courseTitle: course.title,
        );
        loading = false;
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
        Navigator.pop(context);
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          context: context,
          builder: (builder) {
            return Container(
              height: MediaQuery.of(context).size.width * .7,
              color: Colors.transparent,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Lottie.asset(
                        'assets/lottie/add_shopping.json',
                        width: MediaQuery.of(context).size.width * .3,
                      ),
                      const Text('Keranjang Berhasil Ditambahkan'),
                      const Padding(padding: EdgeInsets.all(18)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                // textStyle: const TextStyle(fontSize: 20),
                                ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cari Kursus',
                              style: TextStyle(
                                color: Colors.teal,
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(12)),
                          ElevatedButton(
                            child: const Text(
                              "Lihat Keranjang",
                              style: TextStyle(fontSize: 14),
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  // ignore: prefer_const_constructors
                                  EdgeInsets.all(14)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.teal),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  side: BorderSide(color: Colors.teal),
                                ),
                              ),
                            ),
                            onPressed: () => {
                              Navigator.of(context).pop(),
                              Get.to(() => const CartScreen())
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      } catch (e) {
        showErrorMessage(e.toString());
        loading = false;
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
      }
    }
    return false;
  }

  addToCartBuy(CourseModel course, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool("is_login") ?? false;
    if (!isLogin) {
      Get.to(() => LoginScreen());
    } else {
      try {
        showModalBottomSheet(
          isDismissible: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          context: context,
          builder: (builder) {
            return Container(
              height: MediaQuery.of(context).size.width * .7,
              color:
                  Colors.transparent, //could change this to Color(0xFF737373),
              //so you don't have to change MaterialApp canvasColor
              child: const Center(
                  child: CircularProgressIndicator(
                color: Colors.teal,
              )),
            );
          },
        );
        await orderService.addToCart(
          courseId: course.id,
          courseTitle: course.title,
        );
        loading = false;
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
        Navigator.pop(context);
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          context: context,
          builder: (builder) {
            return Container(
              height: MediaQuery.of(context).size.width * .7,
              color: Colors.transparent,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Lottie.asset(
                        'assets/lottie/add_money.json',
                        width: MediaQuery.of(context).size.width * .3,
                      ),
                      const Text('Klik Lanjutkan Untuk Membeli Kursus'),
                      const Padding(padding: EdgeInsets.all(18)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                // textStyle: const TextStyle(fontSize: 20),
                                ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Batal',
                              style: TextStyle(
                                color: Colors.teal,
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(12)),
                          ElevatedButton(
                            child: const Text(
                              "Lanjutkan",
                              style: TextStyle(fontSize: 14),
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  // ignore: prefer_const_constructors
                                  EdgeInsets.all(14)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.teal),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  side: BorderSide(color: Colors.teal),
                                ),
                              ),
                            ),
                            onPressed: () => {
                              Navigator.of(context).pop(),
                              Get.to(() => const CartScreen())
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      } catch (e) {
        showErrorMessage(e.toString());
        loading = false;
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
      }
    }
    return false;
  }

  getListCart() async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      carts = await orderService.listCart();
      double tmpTotalAmount = 0.0;
      for (var item in carts) {
        tmpTotalAmount += double.parse(item.course.price);
      }
      totalPrice = tmpTotalAmount;
      loading = false;
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
    }
  }

  deleteCart(CartModel cart, BuildContext context) async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      await orderService.deleteCartItem(cart.id);
      getListCart();
      Navigator.of(context).pop();
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  Future<void> requestPaymentCourse() async {
    List<CourseModel> courses = carts.map((e) => e.course).toList();
    if (paymentChannel == null) {
      return showErrorMessage("Silahkan pilih metode pembayaran.");
    }
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      final result = await paymentService.requestPaymentCourse(
        items: courses,
        payment: paymentChannel!,
      );
      Get.to(
        () => TransactionScreen(
          trxCode: result.trx_code,
          back: false,
        ),
      );
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  getDetailTransaction(String trxCode) {}

  Future<void> requestPaymentSubscription(
      int subscriptionId, SubscriptionPriceModel price) async {
    if (paymentChannel == null) {
      return showErrorMessage("Silahkan pilih metode pembayaran.");
    }
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      final result = await paymentService.requestPaymentSubsctiption(
        subscriptionID: subscriptionId,
        price: price,
        payment: paymentChannel!,
      );
      Get.to(
        () => TransactionScreen(
          trxCode: result.trx_code,
          back: false,
        ),
      );
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  goToPaymentSubscription(int subScriptionId, String subscriptionName,
      SubscriptionPriceModel? price) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool("is_login") ?? false;
    if (!isLogin) {
      Get.to(() => LoginScreen());
      return false;
    }
    Get.to(() => SubscriptionCheckoutScreen(
          subscriptionId: subScriptionId,
          SubscriptionName: subscriptionName,
          price: price,
        ));
    return true;
  }
}
