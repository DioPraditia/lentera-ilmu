import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lentera_ilmu/controllers/payment.dart';
import 'package:lentera_ilmu/screens/navigation.dart';
import 'package:lentera_ilmu/screens/transaction/payment/transaction_screen.dart';
import 'package:lentera_ilmu/services/utils.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  _TransactionHistoryScreen createState() => _TransactionHistoryScreen();
}

class _TransactionHistoryScreen extends State<TransactionHistoryScreen> {
  late ScrollController scrollController;
  final paymentController = Get.put(PaymentController());
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
  @override
  void initState() {
    super.initState();
    paymentController.getListTransaction(page: 0, restartData: true);
    scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      paymentController.getListTransaction(
        page: paymentController.lastPage + 1,
        restartData: false,
      );
    }
    if (scrollController.offset <= 0) {
      paymentController.getListTransaction(
        page: 0,
        restartData: true,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            "Riwayat Transaksi",
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
        body: GetBuilder<PaymentController>(
          builder: (payment) => payment.loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ),
                )
              // ignore: prefer_is_empty
              : payment.transactions.length < 1
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/img/empty/transaction.png",
                            width: MediaQuery.of(context).size.width * .60,
                          ),
                          const Padding(padding: EdgeInsets.all(14)),
                          const Text("Yaah, Kamu belum ada transaksi nih..."),
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
                              onPressed: () =>
                                  Get.to(() => const BottomNavBar()),
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80.0),
                                  color: Colors.teal,
                                ),
                                padding: const EdgeInsets.all(0),
                                child: const AutoSizeText(
                                  "Mulai Transaksi",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxFontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: payment.transactions.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, i) {
                        return GestureDetector(
                          onTap: () => Get.to(
                            () => TransactionScreen(
                              trxCode: payment.transactions[i].trx_code,
                              back: true,
                            ),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(
                                top: 4, bottom: 4, left: 8, right: 8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 2.0,
                                    offset: Offset(0.0, 0.75))
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      parseDate(payment
                                              .transactions[i].created_on) +
                                          " WIB",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                      maxFontSize: 12,
                                    ),
                                    AutoSizeText(
                                      // ignore: unnecessary_string_interpolations
                                      "${payment.transactions[i].trx_code}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxFontSize: 12,
                                    ),
                                    AutoSizeText(
                                      payment.transactions[i].trx_type ==
                                              "course"
                                          ? "Pembelian Course."
                                          : "Pembelian konten berlangganan.",
                                      maxFontSize: 12,
                                    ),
                                    AutoSizeText(
                                      parsePaymentStatus(payment
                                          .transactions[i].payment_status),
                                      style: TextStyle(
                                        color: parsePaymentStatusColor(payment
                                            .transactions[i].payment_status),
                                      ),
                                      maxFontSize: 12,
                                    ),
                                    AutoSizeText(
                                      formatCurrency.format(double.parse(payment
                                          .transactions[i].selling_price)),
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      maxFontSize: 12,
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.arrow_right,
                                  size: 30,
                                  color: Colors.teal,
                                )
                              ],
                            ),
                          ),
                        );
                      }),
        ),
      ),
    );
  }
}
