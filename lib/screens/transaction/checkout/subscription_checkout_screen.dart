import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lentera_ilmu/controllers/order.dart';
import 'package:lentera_ilmu/models/lms/subscription_price.dart';
import 'package:lentera_ilmu/screens/transaction/payment/payment_method_screen.dart';

// ignore: must_be_immutable
class SubscriptionCheckoutScreen extends StatefulWidget {
  int subscriptionId;
  // ignore: non_constant_identifier_names
  String SubscriptionName;
  SubscriptionPriceModel? price;
  SubscriptionCheckoutScreen({
    Key? key,
    required this.subscriptionId,
    // ignore: non_constant_identifier_names
    required this.SubscriptionName,
    required this.price,
  }) : super(key: key);
  @override
  _SubscriptionCheckoutScreen createState() => _SubscriptionCheckoutScreen();
}

class _SubscriptionCheckoutScreen extends State<SubscriptionCheckoutScreen> {
  final orderController = Get.put(OrderController());
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
  @override
  void initState() {
    super.initState();
    orderController.onInit();
  }

  @override
  void dispose() {
    // scrollController.dispose();
    // tutorialController.dispose();
    super.dispose();
  }

  List<int> items = [1, 2, 3];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      // onGenerateInitialRoutes: (_) => tutorialController.fetchTutorial(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const AutoSizeText(
            "Pembayaran",
            maxFontSize: 16,
          ),
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              Get.back(),
            },
          ),
        ),
        body: GetBuilder<OrderController>(builder: (order) {
          return ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                child: const AutoSizeText(
                  "Item Pembelian",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                  maxFontSize: 15,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2.0,
                        offset: Offset(0.0, 0.5))
                  ],
                ),
                margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            widget.SubscriptionName,
                            maxFontSize: 12,
                          ),
                          AutoSizeText(
                            formatCurrency.format(double.parse(
                                widget.price?.selling_price ?? "0")),
                            maxFontSize: 13,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: AutoSizeText(
                              "${order.paymentChannel != null ? "Ganti" : "Pilih"} Metode Bayar",
                              style: const TextStyle(fontSize: 14),
                              maxFontSize: 14,
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(14)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orange),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  side: BorderSide(color: Colors.orange),
                                ),
                              ),
                            ),
                            onPressed: () =>
                                Get.to(() => const PaymentMethodScreen()),
                          ),
                        ),
                        order.paymentChannel != null
                            ? const Padding(padding: EdgeInsets.all(4))
                            : const Padding(padding: EdgeInsets.all(0)),
                        order.paymentChannel != null
                            ? Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 2.0,
                                      offset: Offset(0.0, 0.5),
                                    )
                                  ],
                                ),
                                padding: const EdgeInsets.only(
                                  left: 14,
                                  right: 14,
                                  top: 8,
                                  bottom: 0,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText(
                                          order.paymentChannel?.name ?? "",
                                          maxFontSize: 14,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Image.network(
                                          order.paymentChannel?.icon ?? "",
                                          scale: 2,
                                          height: 34,
                                        )
                                      ],
                                    ),
                                    order.paymentChannel?.type == "va"
                                        // ignore: avoid_unnecessary_containers
                                        ? Container(
                                            child: Column(
                                              children: [
                                                const Divider(
                                                  height: 8,
                                                  thickness: 1.3,
                                                ),
                                                const Padding(
                                                    padding: EdgeInsets.all(4)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.circle,
                                                        size: 8,
                                                        color: Colors
                                                            .orange.shade800,
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8),
                                                      ),
                                                      Flexible(
                                                        child: RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Colors
                                                                    .grey
                                                                    .shade600,
                                                              ),
                                                              children: <
                                                                  TextSpan>[
                                                                const TextSpan(
                                                                  text:
                                                                      "Pembayaran menggunakan",
                                                                ),
                                                                TextSpan(
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                    text:
                                                                        " ${order.paymentChannel?.name ?? ""}"),
                                                                const TextSpan(
                                                                    text:
                                                                        " akan dicek otomatis oleh sistem.")
                                                              ]),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const Padding(
                                                    padding: EdgeInsets.all(4)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.circle,
                                                        size: 8,
                                                        color: Colors
                                                            .orange.shade800,
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8),
                                                      ),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                          "Silahkan lakukan pembayaran sesuai nominal yang tertera.",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors.grey
                                                                  .shade600),
                                                          maxFontSize: 12,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        // ignore: avoid_unnecessary_containers
                                        : Container(
                                            child: Column(
                                              children: [
                                                const Divider(
                                                  height: 8,
                                                  thickness: 1.3,
                                                ),
                                                const Padding(
                                                    padding: EdgeInsets.all(4)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.circle,
                                                        size: 8,
                                                        color: Colors
                                                            .orange.shade800,
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8),
                                                      ),
                                                      Flexible(
                                                        child: RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Colors
                                                                    .grey
                                                                    .shade600,
                                                              ),
                                                              children: <
                                                                  TextSpan>[
                                                                const TextSpan(
                                                                  text:
                                                                      "Pembayaran menggunakan",
                                                                ),
                                                                TextSpan(
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                    text:
                                                                        " ${order.paymentChannel?.name ?? ""}"),
                                                                const TextSpan(
                                                                    text:
                                                                        " akan dicek secara manual oleh admin.")
                                                              ]),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const Padding(
                                                    padding: EdgeInsets.all(4)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.circle,
                                                        size: 8,
                                                        color: Colors
                                                            .orange.shade800,
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8),
                                                      ),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                          "Silahkan lakukan pembayaran sesuai nominal yang tertera pada halaman selanjutnya.",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors.grey
                                                                  .shade600),
                                                          maxFontSize: 12,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                    const Padding(padding: EdgeInsets.all(6))
                                  ],
                                ),
                              )
                            : Container(),
                        // AutoSizeText(
                        //   "${order.paymentChannel != null ? "Metode Bayar ${order.paymentChannel?.name}" : ''}",
                        //   maxFontSize: 12,
                        // ),
                        Padding(
                            padding: EdgeInsets.all(
                                order.paymentChannel != null ? 8 : 0))
                      ],
                    )
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 2.0,
                      offset: Offset(0.0, 0.5),
                    )
                  ],
                ),
                margin: const EdgeInsets.only(left: 12, right: 12),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AutoSizeText(
                          "Total Harga Item",
                          maxFontSize: 12,
                        ),
                        AutoSizeText(
                          formatCurrency.format(
                              double.parse(widget.price?.selling_price ?? "0")),
                          maxFontSize: 12,
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(6)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AutoSizeText(
                          "Biaya Bank",
                          maxFontSize: 12,
                        ),
                        AutoSizeText(
                          formatCurrency.format(order.bankFee),
                          maxFontSize: 12,
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(6)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AutoSizeText(
                          "Biaya Layanan",
                          maxFontSize: 12,
                        ),
                        AutoSizeText(
                          formatCurrency.format(order.platformFee),
                          maxFontSize: 12,
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(6)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AutoSizeText(
                          "Total",
                          maxFontSize: 14,
                        ),
                        AutoSizeText(
                          formatCurrency.format(double.parse(
                              "${int.parse(widget.price?.selling_price ?? "0") + order.bankFee + order.platformFee}")),
                          maxFontSize: 14,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        }),
        bottomNavigationBar: GetBuilder<OrderController>(builder: (order) {
          return Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.all(Radius.circular(18)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                    offset: Offset(0.0, 0.75))
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: AutoSizeText(
                  order.loading == true ? "Memproses..." : "Bayar Sekarang",
                  style: const TextStyle(fontSize: 14),
                  maxFontSize: 14,
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(14)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(14),
                      ),
                      side: BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
                onPressed: () => order.loading
                    ? null
                    : order.requestPaymentSubscription(
                        widget.subscriptionId, widget.price!),
              ),
            ),
          );
        }),
      ),
    );
  }
}
