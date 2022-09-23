import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/payment.dart';
import 'package:lentera_ilmu/controllers/profile.dart';
import 'package:lentera_ilmu/screens/profile/setting/bank/list_bank.dart';

class CreateAccountBankScreen extends StatefulWidget {
  const CreateAccountBankScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountBankScreen createState() => _CreateAccountBankScreen();
}

class _CreateAccountBankScreen extends State<CreateAccountBankScreen> {
  final profileController = Get.put(ProfileController());
  final paymentController = Get.put(PaymentController());
  @override
  void initState() {
    super.initState();
    paymentController.selectedDestinationBank = null;
    paymentController.accountHolder.text = "";
    paymentController.accountNumber.text = "";
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
            "Tambah Akun Bank",
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const AutoSizeText(
                        "Pilih Bank",
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
                      onPressed: () => Get.to(() => const ListBankScreen()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        payment.selectedDestinationBank == null
                            ? Container()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeText(
                                    payment.selectedDestinationBank?.name ?? "",
                                    maxFontSize: 14,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Image.network(
                                    payment.selectedDestinationBank?.icon ?? "",
                                    scale: 1,
                                    height: 20,
                                  )
                                ],
                              ),
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
                                        children: const <TextSpan>[
                                          TextSpan(
                                            text:
                                                "Pastikan tidak ada kesalahan penulisan nomor rekening.",
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
                                      "Pastikan nama pemilik rekening dan nama di Aplikasi Lentera Ilmu sama.",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey.shade600),
                                      maxFontSize: 12,
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
                                      "Kesalahan penulisan nomor rekening dan nama pemilik rekening akan menyebabkan kegagalan saat melakukan withdraw.",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey.shade600),
                                      maxFontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
                    child: TextField(
                      controller: payment.accountNumber,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.teal),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.teal),
                        ),
                        labelText: 'Masukkan Nomor Rekening',
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
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
                    child: TextField(
                      controller: payment.accountHolder,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.teal),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.teal),
                        ),
                        labelText: 'Masukkan Nama Pemilik Rekening',
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 12, right: 12),
                        fillColor: Colors.teal,
                      ),
                    ),
                  ),
                  payment.errorMessage != ""
                      ? Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            payment.errorMessage,
                            textAlign: TextAlign.left,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      : Container(),
                  const Padding(padding: EdgeInsets.all(6)),
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
                          payment.addBank(payment.selectedDestinationBank),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          color: Colors.teal,
                        ),
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          payment.loading == true
                              ? "Sedang Menyimpan..."
                              : "Simpan",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
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

  // ignore: non_constant_identifier_names
}
