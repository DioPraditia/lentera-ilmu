import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/payment.dart';
import 'package:lentera_ilmu/models/payment/withdraw_fee.dart';
import 'package:lentera_ilmu/models/user/user_bank.dart';
import 'package:lentera_ilmu/services/utils.dart';

class WithdrawRequestScreen extends StatefulWidget {
  final UserBankModel userBank;
  final double amount;
  final WithdrawFeeModel withdrawFee;
  const WithdrawRequestScreen(
      {Key? key,
      required this.userBank,
      required this.amount,
      required this.withdrawFee})
      : super(key: key);

  @override
  _WithdrawRequestScreen createState() => _WithdrawRequestScreen();
}

class _WithdrawRequestScreen extends State<WithdrawRequestScreen> {
  final paymentController = Get.put(PaymentController());
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      // onGenerateInitialRoutes: (_) => lmsController.getCourse(widget.course.id),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const AutoSizeText(
            "Konfirmasi Withdraw",
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
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 14),
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
                                widget.userBank.bank_name,
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
                                widget.userBank.account_number,
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
                                widget.userBank.account_holder.toUpperCase(),
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
                                formatCurrency.format(widget.amount),
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
                                formatCurrency.format(widget.withdrawFee.fee),
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
                                formatCurrency.format(
                                    widget.amount - widget.withdrawFee.fee),
                                maxFontSize: 12,
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.all(8)),
                          TextField(
                            controller: payment.password,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.teal),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.teal),
                              ),
                              labelText: 'Masukkan Password',
                              labelStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              contentPadding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              fillColor: Colors.teal,
                            ),
                            obscureText: true,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 14),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          child: const AutoSizeText(
                            "Withdraw",
                            style: TextStyle(fontSize: 14),
                            maxFontSize: 14,
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(14)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
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
                          onPressed: () => payment.loading
                              ? null
                              : payment.withdraw(
                                  widget.userBank, widget.amount)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
