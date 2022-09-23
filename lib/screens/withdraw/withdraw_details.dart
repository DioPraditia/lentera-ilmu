import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/payment.dart';
import 'package:lentera_ilmu/screens/profile/profile_screen.dart';
import 'package:lentera_ilmu/services/utils.dart';

class WithdrawTransactionScreen extends StatefulWidget {
  final String trxCode;
  final bool back;
  const WithdrawTransactionScreen(
      {Key? key, required this.trxCode, required this.back})
      : super(key: key);

  @override
  _WithdrawTransactionScreen createState() => _WithdrawTransactionScreen();
}

class _WithdrawTransactionScreen extends State<WithdrawTransactionScreen> {
  final paymentController = Get.put(PaymentController());
  @override
  void initState() {
    super.initState();
    paymentController.withdrawDetails(widget.trxCode);
  }

  @override
  void dispose() {
    super.dispose();
  }

  String getStatus(String status) {
    if (status == "process") {
      return "Dalam Proses";
    }
    if (status == "success") {
      return "Berhasil";
    }
    if (status == "reversal") {
      return "Gagal";
    }
    return "";
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
            "Informasi Penarikan",
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
        body: GetBuilder<PaymentController>(builder: (payment) {
          return payment.loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ),
                )
              : ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: payment.withdrawTransaction?.status == "reversal"
                            ? Image.asset(
                                "assets/img/payment/failed.png",
                                width: MediaQuery.of(context).size.width * .40,
                              )
                            : payment.withdrawTransaction?.status == "success"
                                ? Image.asset(
                                    "assets/img/payment/success.png",
                                    width:
                                        MediaQuery.of(context).size.width * .40,
                                  )
                                : payment.withdrawTransaction?.status ==
                                        "process"
                                    ? Image.asset(
                                        "assets/img/payment/waiting.png",
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .40,
                                      )
                                    : Container(),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 14),
                      child: Container(
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
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const AutoSizeText(
                                  "Bank Tujuan",
                                  maxFontSize: 12,
                                ),
                                AutoSizeText(
                                  payment.withdrawTransaction
                                          ?.destination_bank_name ??
                                      "",
                                  maxFontSize: 12,
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.all(6)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const AutoSizeText(
                                  "Nomor Rekening",
                                  maxFontSize: 12,
                                ),
                                AutoSizeText(
                                  payment.withdrawTransaction
                                          ?.destination_account_number ??
                                      "",
                                  maxFontSize: 12,
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.all(6)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const AutoSizeText(
                                  "Atas Nama",
                                  maxFontSize: 12,
                                ),
                                AutoSizeText(
                                  payment.withdrawTransaction
                                          ?.destination_account_holder
                                          .toUpperCase() ??
                                      "",
                                  maxFontSize: 12,
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.all(6)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const AutoSizeText(
                                  "Nominal Penarikan",
                                  maxFontSize: 12,
                                ),
                                AutoSizeText(
                                  formatCurrency.format(double.parse(payment
                                          .withdrawTransaction
                                          ?.request_amount ??
                                      "0")),
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
                                  formatCurrency.format(double.parse(
                                      payment.withdrawTransaction?.bank_fee ??
                                          "0")),
                                  maxFontSize: 12,
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.all(6)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const AutoSizeText(
                                  "Jumlah Uang Diterima",
                                  maxFontSize: 12,
                                ),
                                AutoSizeText(
                                  formatCurrency.format(double.parse(payment
                                          .withdrawTransaction
                                          ?.withdraw_amount ??
                                      "0")),
                                  maxFontSize: 12,
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.all(6)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const AutoSizeText(
                                  "Status",
                                  maxFontSize: 12,
                                ),
                                AutoSizeText(
                                  getStatus(
                                      payment.withdrawTransaction?.status ??
                                          ""),
                                  maxFontSize: 12,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        }),
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
                      "Kembali",
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
                    onPressed: () => {Get.to(() => const ProfileScreen())},
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
