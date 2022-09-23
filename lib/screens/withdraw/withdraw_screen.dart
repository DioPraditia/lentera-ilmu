import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/payment.dart';
import 'package:lentera_ilmu/controllers/profile.dart';
// ignore: unused_import
import 'package:lentera_ilmu/models/payment/withdraw_fee.dart';
// ignore: unused_import
import 'package:lentera_ilmu/screens/profile/setting/bank/list_bank.dart';
import 'package:lentera_ilmu/screens/withdraw/select_destination_bank.dart';
import 'package:lentera_ilmu/screens/withdraw/withdraw_request_screen.dart';
import 'package:lentera_ilmu/services/utils.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  _WithdrawScreen createState() => _WithdrawScreen();
}

class _WithdrawScreen extends State<WithdrawScreen> {
  final profileController = Get.put(ProfileController());
  final paymentController = Get.put(PaymentController());
  @override
  void initState() {
    super.initState();
    paymentController.seletUserBank = null;
    paymentController.getWithdrawFee();
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
      // onGenerateInitialRoutes: (_) => lmsController.getCourse(widget.course.id),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const AutoSizeText(
            "Withdraw",
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
              child: GetBuilder<ProfileController>(builder: (profile) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 12,
                        bottom: 12,
                      ),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5.0,
                            offset: const Offset(4, 5),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/img/wallet.png",
                                width: 20,
                              ),
                              const Padding(padding: EdgeInsets.only(right: 8)),
                              const AutoSizeText(
                                "Jumlah Point Withdraw",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxFontSize: 14,
                              ),
                            ],
                          ),
                          AutoSizeText(
                            formatCurrency.format(profile.withdrawBalance),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.teal,
                            ),
                            maxFontSize: 14,
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(8)),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: ElevatedButton(
                        child: const AutoSizeText(
                          "Pilih Rekening Tujuan",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          maxFontSize: 14,
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(14)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              side: BorderSide(color: Colors.teal),
                            ),
                          ),
                        ),
                        onPressed: () =>
                            Get.to(() => const SelectDestinationBank()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          payment.seletUserBank != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          payment.seletUserBank?.bank_name ??
                                              "",
                                          maxFontSize: 14,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.only(top: 8)),
                                        AutoSizeText(
                                          "${payment.seletUserBank?.account_holder.toUpperCase()} (${payment.seletUserBank?.account_number})",
                                          maxFontSize: 14,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Image.network(
                                      payment.seletUserBank?.bank_icon ?? "",
                                      scale: 1,
                                      height: 24,
                                    )
                                  ],
                                )
                              : Container(),
                          Column(
                            children: [
                              const Divider(
                                height: 8,
                                thickness: 1.3,
                              ),
                              const Padding(padding: EdgeInsets.all(4)),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: Colors.orange.shade800,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8),
                                    ),
                                    Flexible(
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey.shade600,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  "Setiap penarikan akan dipotong biaya bank sebesar ${formatCurrency.format(payment.withdrawFee.fee)}.",
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Padding(padding: EdgeInsets.all(4)),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: Colors.orange.shade800,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8),
                                    ),
                                    Flexible(
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey.shade600,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  "Minimal penarikan sebesar ${formatCurrency.format(payment.withdrawFee.minimum + 1)}.",
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Padding(padding: EdgeInsets.all(4)),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: Colors.orange.shade800,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8),
                                    ),
                                    Flexible(
                                      child: AutoSizeText(
                                        "Pastikan penulisan nomor dan nama rekening tujuan telah sesuai. Kesalahan penulisan akan menyebabkan terhambatnya proses withdraw",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey.shade600),
                                        maxFontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 12),
                      child: TextField(
                        onChanged: payment.onChangeWithdraw,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 1,
                                color: payment.withdrawAmount >
                                        profile.withdrawBalance
                                    ? Colors.red
                                    : Colors.teal),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 1,
                                color: payment.withdrawAmount >
                                        profile.withdrawBalance
                                    ? Colors.red
                                    : Colors.teal),
                          ),
                          labelText: 'Nominal Penarikan',
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          contentPadding:
                              const EdgeInsets.only(left: 12, right: 12),
                          fillColor: Colors.teal,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 14),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const AutoSizeText(
                            "Lanjutkan",
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
                          onPressed: () => {
                            if (payment.withdrawAmount <=
                                    profile.withdrawBalance &&
                                payment.withdrawAmount >
                                    payment.withdrawFee.minimum &&
                                payment.seletUserBank != null)
                              {
                                Get.to(() => WithdrawRequestScreen(
                                    userBank: payment.seletUserBank!,
                                    amount: payment.withdrawAmount,
                                    withdrawFee: payment.withdrawFee))
                              }
                            else
                              {null}
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}
