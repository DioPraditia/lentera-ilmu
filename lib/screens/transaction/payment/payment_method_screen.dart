import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/order.dart';
import 'package:lentera_ilmu/controllers/payment.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  _PaymentMethodScreen createState() => _PaymentMethodScreen();
}

class _PaymentMethodScreen extends State<PaymentMethodScreen> {
  final paymentController = Get.put(PaymentController());
  final orderController = Get.put(OrderController());
  @override
  void initState() {
    super.initState();
    paymentController.getListPaymentChannel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<int> items = [1, 2, 3];
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
            "Pilih Metode Bayar",
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
        body: GetBuilder<PaymentController>(builder: (payment) {
          return ListView.separated(
            itemCount: payment.paymentChannels.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (_, i) {
              return GestureDetector(
                onTap: () => {
                  orderController.setPaymentChannel(payment.paymentChannels[i]),
                  Get.back()
                },
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 6, right: 6, top: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            payment.paymentChannels[i].icon ?? "",
                            width: 40,
                            height: 40,
                          ),
                          const Padding(padding: EdgeInsets.all(12)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                payment.paymentChannels[i].name,
                                maxFontSize: 14,
                              ),
                              AutoSizeText(
                                payment.paymentChannels[i].type == 'va'
                                    ? "Verifikasi Otomatis"
                                    : "Pembayaran Dicek Manual",
                                style: TextStyle(color: Colors.grey.shade500),
                                maxFontSize: 12,
                              ),
                            ],
                          )
                        ],
                      ),
                      const Icon(
                        Icons.arrow_right,
                        size: 42,
                        color: Colors.teal,
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        }),
      ),
    );
  }
}
