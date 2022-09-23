import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/lms.dart';
import 'package:lentera_ilmu/controllers/payment.dart';
import 'package:lentera_ilmu/screens/navigation.dart';
import 'package:lentera_ilmu/screens/transaction/payment/payment_tutorial_screen.dart';
import 'package:lentera_ilmu/screens/widgets/toast.dart';
import 'package:lentera_ilmu/services/utils.dart';

class TransactionScreen extends StatefulWidget {
  final String trxCode;
  final bool back;
  const TransactionScreen({Key? key, required this.trxCode, required this.back})
      : super(key: key);

  @override
  _TransactionScreen createState() => _TransactionScreen();
}

class _TransactionScreen extends State<TransactionScreen> {
  final lmsController = Get.put(LMSController());
  final paymentController = Get.put(PaymentController());
  @override
  void initState() {
    super.initState();
    lmsController.getTransaction(trxCode: widget.trxCode, withLoading: true);
    paymentController.readPaymentTutorial();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    lmsController.getTransaction(trxCode: widget.trxCode, withLoading: false);
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
            "Pembayaran",
            maxFontSize: 15,
          ),
          centerTitle: true,
          leading: widget.back == true
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => {
                    Get.back(),
                  },
                )
              : null,
        ),
        body: RefreshIndicator(
          color: Colors.teal,
          onRefresh: () => refreshData(),
          child: GetBuilder<LMSController>(
            builder: (lms) {
              return lms.loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.teal,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: lms.transaction?.payment_status ==
                                      "canceled"
                                  ? Image.asset(
                                      "assets/img/payment/failed.png",
                                      width: MediaQuery.of(context).size.width *
                                          .40,
                                    )
                                  : lms.transaction?.payment_status == "payment"
                                      ? Image.asset(
                                          "assets/img/payment/success.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .40,
                                        )
                                      : lms.transaction?.payment_status ==
                                              "waiting"
                                          ? Image.asset(
                                              "assets/img/payment/waiting.png",
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .40,
                                            )
                                          : Container(),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 2.0,
                                    offset: Offset(0.0, 0.5))
                              ],
                            ),
                            margin: const EdgeInsets.only(
                                top: 12, left: 12, right: 12),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                // ignore: unused_local_variable
                                if (lms.transaction?.trx_type == "course")
                                  for (var item in lms.transactionCourseItmes)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText(
                                          item.title,
                                          maxFontSize: 12,
                                        ),
                                        AutoSizeText(
                                          formatCurrency
                                              .format(double.parse(item.price)),
                                          maxFontSize: 12,
                                        ),
                                      ],
                                    ),
                                if (lms.transaction?.trx_type == "subscription")
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AutoSizeText(
                                        lms.transactionSubscriptionName ?? "",
                                        maxFontSize: 12,
                                      ),
                                      AutoSizeText(
                                        formatCurrency.format(double.parse(
                                            lms.transaction?.base_price ??
                                                "0")),
                                        maxFontSize: 12,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          Container(
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
                            margin: const EdgeInsets.only(
                                top: 12, left: 12, right: 12),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const AutoSizeText(
                                      "Kode Transaksi",
                                      maxFontSize: 12,
                                    ),
                                    AutoSizeText(
                                      lms.transaction?.trx_code ?? "",
                                      maxFontSize: 12,
                                    ),
                                  ],
                                ),
                                const Padding(padding: EdgeInsets.all(6)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const AutoSizeText(
                                      "Total Harga Item",
                                      maxFontSize: 12,
                                    ),
                                    AutoSizeText(
                                      formatCurrency.format(double.parse(
                                          lms.transaction?.base_price ?? "0")),
                                      maxFontSize: 12,
                                    ),
                                  ],
                                ),
                                const Padding(padding: EdgeInsets.all(6)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const AutoSizeText(
                                      "Biaya Bank",
                                      maxFontSize: 12,
                                    ),
                                    AutoSizeText(
                                      formatCurrency.format(double.parse(
                                          lms.transaction?.bank_fee ?? "0")),
                                      maxFontSize: 12,
                                    ),
                                  ],
                                ),
                                const Padding(padding: EdgeInsets.all(6)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const AutoSizeText(
                                      "Biaya Layanan",
                                      maxFontSize: 12,
                                    ),
                                    AutoSizeText(
                                      formatCurrency.format(double.parse(
                                          lms.transaction?.platform_fee ??
                                              "0")),
                                      maxFontSize: 12,
                                    ),
                                  ],
                                ),
                                lms.transaction?.payment_type == "manual"
                                    ? Column(
                                        children: [
                                          const Padding(
                                              padding: EdgeInsets.all(6)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const AutoSizeText(
                                                "Kode Unik",
                                                maxFontSize: 12,
                                              ),
                                              AutoSizeText(
                                                formatCurrency.format(lms
                                                    .transaction
                                                    ?.unique_number),
                                                maxFontSize: 12,
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(6)),
                                        ],
                                      )
                                    : Container(),
                                const Padding(padding: EdgeInsets.all(6)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const AutoSizeText(
                                      "Total",
                                      maxFontSize: 14,
                                    ),
                                    AutoSizeText(
                                      formatCurrency.format(double.parse(
                                          lms.transaction?.selling_price ??
                                              "0")),
                                      maxFontSize: 14,
                                    ),
                                  ],
                                ),
                                const Padding(padding: EdgeInsets.all(6)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const AutoSizeText(
                                      "Status",
                                      maxFontSize: 12,
                                    ),
                                    AutoSizeText(
                                      parsePaymentStatus(
                                          lms.transaction?.payment_status ??
                                              ""),
                                      style: TextStyle(
                                        color: parsePaymentStatusColor(
                                            lms.transaction?.payment_status ??
                                                ""),
                                      ),
                                      maxFontSize: 12,
                                    ),
                                  ],
                                ),
                                const Padding(padding: EdgeInsets.all(12)),
                                lms.transaction?.payment_status == "waiting"
                                    ? lms.transaction?.payment_type == "va"
                                        ? Column(
                                            children: [
                                              AutoSizeText(
                                                "VIRTUAL ACCOUNT ${lms.transaction?.payment_provider.toUpperCase() ?? ""}",
                                                maxFontSize: 12,
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.all(6)),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  AutoSizeText(
                                                    lms.transaction
                                                            ?.payment_account_number ??
                                                        "",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22,
                                                    ),
                                                    maxFontSize: 16,
                                                  ),
                                                  const Padding(
                                                      padding:
                                                          EdgeInsets.all(4)),
                                                  GestureDetector(
                                                    onTap: () => {
                                                      Clipboard.setData(ClipboardData(
                                                              text: lms
                                                                      .transaction
                                                                      ?.payment_account_number ??
                                                                  ""))
                                                          .then((_) {
                                                        showBottomFlash(
                                                            context: context,
                                                            icon: const Icon(
                                                                Icons.copy),
                                                            message:
                                                                "Nomor VA berhasil disalin.");
                                                      })
                                                    },
                                                    child: const Icon(
                                                      Icons.copy,
                                                      size: 20,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.all(6)),
                                              const AutoSizeText(
                                                "Silahkan lakukan pembayaran sebelum",
                                                textAlign: TextAlign.center,
                                                maxFontSize: 12,
                                              ),
                                              AutoSizeText(
                                                lms.transaction
                                                            ?.payment_expired !=
                                                        null
                                                    ? parseDate(lms.transaction
                                                            ?.payment_expired ??
                                                        "0000-00-00T00:00:00")
                                                    : "",
                                                textAlign: TextAlign.center,
                                                maxFontSize: 12,
                                              )
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              AutoSizeText(
                                                "Silahkan lakukan pembayaran melalui Rek. ${lms.transaction?.payment_provider.toUpperCase() ?? ""}",
                                                maxFontSize: 12,
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.all(6)),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  AutoSizeText(
                                                    lms.transaction
                                                            ?.payment_account_number ??
                                                        "",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22,
                                                    ),
                                                    maxFontSize: 16,
                                                  ),
                                                  const Padding(
                                                      padding:
                                                          EdgeInsets.all(6)),
                                                  GestureDetector(
                                                    onTap: () => {
                                                      Clipboard.setData(ClipboardData(
                                                              text: lms
                                                                      .transaction
                                                                      ?.payment_account_number ??
                                                                  ""))
                                                          .then((_) {
                                                        showBottomFlash(
                                                            context: context,
                                                            icon: const Icon(
                                                                Icons.copy),
                                                            message:
                                                                "Nomor VA berhasil disalin.");
                                                      })
                                                    },
                                                    child: const Icon(
                                                      Icons.copy,
                                                      size: 20,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.all(4)),
                                              AutoSizeText(
                                                "An. ${lms.transaction?.payment_account_holder ?? ""}",
                                                maxFontSize: 12,
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.all(6)),
                                              const AutoSizeText(
                                                "Lakukan pembayaran sebelum",
                                                textAlign: TextAlign.center,
                                                maxFontSize: 12,
                                              ),
                                              AutoSizeText(
                                                lms.transaction
                                                            ?.payment_expired !=
                                                        null
                                                    ? parseDate(lms.transaction
                                                            ?.payment_expired ??
                                                        "0000-00-00T00:00:00")
                                                    : "",
                                                textAlign: TextAlign.center,
                                                maxFontSize: 12,
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.all(6)),
                                              Container(
                                                // margin: const EdgeInsets.all(8),
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.orange.shade200,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(8)),
                                                  boxShadow: const <BoxShadow>[
                                                    BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 2.0,
                                                        offset:
                                                            Offset(0.0, 0.5))
                                                  ],
                                                ),
                                                child: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                    style: const TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black87,
                                                    ),
                                                    children: <TextSpan>[
                                                      const TextSpan(
                                                        text:
                                                            "Untuk kelancaran verifikasi pembayaran pastikan nominal transfer ",
                                                      ),
                                                      TextSpan(
                                                          text: formatCurrency
                                                              .format(
                                                            double.parse(lms
                                                                    .transaction
                                                                    ?.selling_price ??
                                                                "0"),
                                                          ),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                    : Container(),
                              ],
                            ),
                          ),
                          lms.transaction?.payment_status == "waiting" &&
                                  lms.transaction?.payment_type == "va"
                              ? Container(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(padding: EdgeInsets.all(8)),
                                      const Text(
                                        "Lihat Cara Pembayaran",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.all(12)),
                                      for (var item
                                          in paymentController.paymentTutorial)
                                        GestureDetector(
                                          onTap: () => Get.to(
                                            () => PaymentTutorialScreen(
                                              channel: item,
                                            ),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(item.channel),
                                                    const Icon(
                                                      Icons.play_arrow,
                                                      size: 24,
                                                      color: Colors.teal,
                                                    )
                                                  ],
                                                ),
                                                const Padding(
                                                    padding: EdgeInsets.all(4)),
                                                const Divider(),
                                              ],
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
            },
          ),
        ),
        bottomNavigationBar: widget.back != true
            ? Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.all(Radius.circular(18)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2.0,
                        offset: Offset(0.0, 0.75))
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text(
                      "Beranda",
                      style: TextStyle(fontSize: 14),
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
                            Radius.circular(8),
                          ),
                          side: BorderSide(color: Colors.teal),
                        ),
                      ),
                    ),
                    onPressed: () => {Get.to(() => const BottomNavBar())},
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
