import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/payment.dart';

class ListBankScreen extends StatefulWidget {
  const ListBankScreen({Key? key}) : super(key: key);

  @override
  _ListBankScreen createState() => _ListBankScreen();
}

class _ListBankScreen extends State<ListBankScreen> {
  final paymentController = Get.put(PaymentController());
  @override
  void initState() {
    super.initState();
    paymentController.getListDestinationBank();
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
            "Pilih Bank",
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
          builder: (payment) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: TextField(
                    onChanged: (value) => payment.searchDestinationBank(value),
                    decoration: InputDecoration(
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
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
                      labelText: 'Cari Bank',
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.teal,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.teal,
                      ),
                      contentPadding:
                          const EdgeInsets.only(left: 12, right: 12),
                      fillColor: Colors.teal,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Expanded(
                  child: ListView.separated(
                    itemCount: payment.destionationBanks.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (_, i) {
                      return GestureDetector(
                        onTap: () => {
                          payment.selectDestinatonBank(
                              payment.destionationBanks[i]),
                          Get.back()
                        },
                        child: Container(
                          color: Colors.white,
                          padding:
                              const EdgeInsets.only(left: 6, right: 6, top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    payment.destionationBanks[i].icon,
                                    width: 40,
                                    height: 40,
                                  ),
                                  const Padding(padding: EdgeInsets.all(12)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        payment.destionationBanks[i].name,
                                        maxFontSize: 14,
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
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
