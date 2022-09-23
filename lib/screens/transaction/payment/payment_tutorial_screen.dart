import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:lentera_ilmu/controllers/lms.dart';
// ignore: unused_import
import 'package:lentera_ilmu/controllers/payment.dart';
// ignore: unused_import
import 'package:lentera_ilmu/models/payment/channel_tutorial.dart';
import 'package:lentera_ilmu/models/payment/payment_tutorial.dart';
// ignore: unused_import
import 'package:lentera_ilmu/screens/navigation.dart';
// ignore: unused_import
import 'package:lentera_ilmu/screens/widgets/toast.dart';
// ignore: unused_import
import 'package:lentera_ilmu/services/utils.dart';

class PaymentTutorialScreen extends StatefulWidget {
  final PaymentTutorialModel channel;
  const PaymentTutorialScreen({Key? key, required this.channel})
      : super(key: key);

  @override
  _PaymentTutorialScreen createState() => _PaymentTutorialScreen();
}

class _PaymentTutorialScreen extends State<PaymentTutorialScreen> {
  final List<bool> _isExpandedChannel = List.generate(50, (_) => false);
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
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: AutoSizeText(
              widget.channel.channel,
              maxFontSize: 15,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => {
                Get.back(),
              },
            ),
          ),
          body: SingleChildScrollView(
            child: ExpansionPanelList(
              expansionCallback: (index, isExpanded) => setState(() {
                _isExpandedChannel[index] = !isExpanded;
              }),
              children: [
                for (int i = 0; i < widget.channel.channel_bank.length; i++)
                  ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (_, isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                widget.channel.channel_bank[i].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    body: Builder(
                      builder: (BuildContext context) => Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var item
                                in widget.channel.channel_bank[i].tutorial)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 24, right: 12),
                                        child: Icon(
                                          Icons.circle,
                                          size: 8,
                                          color: Colors.orange.shade800,
                                        ),
                                      ),
                                      Flexible(child: Text(item)),
                                    ],
                                  ),
                                  const Padding(padding: EdgeInsets.all(8))
                                ],
                              )
                          ],
                        ),
                      ),
                    ),
                    isExpanded: _isExpandedChannel[i],
                  )
              ],
            ),
          )),
    );
  }
}
