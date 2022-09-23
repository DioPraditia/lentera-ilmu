import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/payment.dart';
// ignore: unused_import
import 'package:lentera_ilmu/screens/transaction/payment/transaction_screen.dart';
import 'package:lentera_ilmu/screens/withdraw/withdraw_details.dart';
import 'package:lentera_ilmu/services/utils.dart';

class WithdrawHistoryScreen extends StatefulWidget {
  const WithdrawHistoryScreen({Key? key}) : super(key: key);

  @override
  _WithdrawHistoryScreen createState() => _WithdrawHistoryScreen();
}

class _WithdrawHistoryScreen extends State<WithdrawHistoryScreen> {
  late ScrollController scrollController;
  final paymentController = Get.put(PaymentController());
  @override
  void initState() {
    super.initState();
    paymentController.getHistoryWithdraw(
        page: 0, restartData: true, withLoading: true);
    scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      paymentController.getHistoryWithdraw(
        page: paymentController.lastPage + 1,
        restartData: false,
      );
    }
    if (scrollController.offset <= 0) {
      paymentController.getHistoryWithdraw(
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
            "Riwayat Penarikan",
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
              : payment.withdrawHistories.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/img/empty/transaction.png",
                            width: MediaQuery.of(context).size.width * .60,
                          ),
                          const Padding(padding: EdgeInsets.all(14)),
                          const Text("Belum ada riwayat penarikan..."),
                          const Padding(padding: EdgeInsets.all(24)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: payment.withdrawHistories.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, i) {
                        return GestureDetector(
                          onTap: () => Get.to(
                            () => WithdrawTransactionScreen(
                              trxCode: payment.withdrawHistories[i].trx_code,
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
                                      parseDate(payment.withdrawHistories[i]
                                              .created_on) +
                                          " WIB",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                      maxFontSize: 12,
                                    ),
                                    AutoSizeText(
                                      payment.withdrawHistories[i].trx_code,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxFontSize: 12,
                                    ),
                                    AutoSizeText(
                                      parseWithdrawStatus(
                                          payment.withdrawHistories[i].status),
                                      style: TextStyle(
                                        color: parsePaymentStatusColor(payment
                                            .withdrawHistories[i].status),
                                      ),
                                      maxFontSize: 12,
                                    ),
                                    AutoSizeText(
                                      formatCurrency.format(double.parse(payment
                                          .withdrawHistories[i]
                                          .request_amount)),
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      maxFontSize: 12,
                                    ),
                                    AutoSizeText(
                                      "${payment.withdrawHistories[i].destination_bank_code.toUpperCase()} | ${payment.withdrawHistories[i].destination_account_number.toUpperCase()} | ${payment.withdrawHistories[i].destination_account_holder.toUpperCase()}",
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
