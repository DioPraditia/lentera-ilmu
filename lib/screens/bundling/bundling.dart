// ignore: unused_import
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:auto_size_text/auto_size_text.dart';
// ignore: unused_import
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/lms.dart';
import 'package:lentera_ilmu/controllers/order.dart';
import 'package:lentera_ilmu/screens/shimmer/home_shimmer.dart';
import 'package:lentera_ilmu/screens/subscription/subscription_screen.dart';
import 'package:lentera_ilmu/screens/transaction/cart/cart_screen.dart';
import 'package:lentera_ilmu/services/utils.dart';

class Bundling extends StatefulWidget {
  const Bundling({Key? key}) : super(key: key);

  @override
  State<Bundling> createState() => _BundlingState();
}

class _BundlingState extends State<Bundling> {
  final lmsController = Get.put(LMSController());
  final orderController = Get.put(OrderController());

  Future refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    lmsController.getHomeData();
  }

  @override
  void initState() {
    super.initState();
    // Upgrader.clearSavedSettings();

    lmsController.onInit();
    lmsController.getHomeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LMSController>(
      builder: (lms) {
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
                "Paket Bundling",
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
            body: Stack(
              children: [
                ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    lms.loading
                        ? HomeNewsShimmer()
                        : Column(
                            children: [
                              Image.asset(
                                'assets/img/Bundling-banner.png',
                                width: MediaQuery.of(context).size.width,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 370,
                                height: 265,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 5.0,
                                      offset: const Offset(
                                        0,
                                        3,
                                      ),
                                    ),
                                  ],
                                ),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: lms.subscriptions.length,
                                  itemBuilder: (contex, index) =>
                                      GestureDetector(
                                    onTap: () => Get.to(
                                      () => SubscriptionScreen(
                                        subscriptionId:
                                            lms.subscriptions[index].id,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 35,
                                        left: 17,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 230,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 77,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Image.network(
                                                      lms.subscriptions[index]
                                                          .thumbnail!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                AutoSizeText(
                                                  lms.subscriptions[index].name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                  maxFontSize: 15,
                                                  minFontSize: 12,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                AutoSizeText(
                                                  "Mulai dari ${formatCurrency.format(double.parse(lms.subscriptions[index].subscription_prices![0].selling_price))}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.teal,
                                                  ),
                                                  maxFontSize: 13,
                                                  minFontSize: 11,
                                                ),
                                                const SizedBox(
                                                  height: 17,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 24),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Row(
                                                              children: const [
                                                                AutoSizeText(
                                                                  "Rp.200.000",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    color: Colors
                                                                        .teal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                  maxFontSize:
                                                                      16,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              width: 7,
                                                            ),
                                                            Container(
                                                              width: 33,
                                                              height: 21,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        220,
                                                                        220),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          4),
                                                                ),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child:
                                                                    AutoSizeText(
                                                                  " 15%",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                  maxFontSize:
                                                                      13,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 7,
                                                        ),
                                                        const AutoSizeText(
                                                          "Promo Akhir Tahun",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Popppins",
                                                            color: Color(
                                                                0x70252424),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            height: 230,
                                            decoration: const BoxDecoration(
                                                color: Colors.white),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 77,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Image.network(
                                                      lms.subscriptions[index]
                                                          .thumbnail!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                AutoSizeText(
                                                  lms.subscriptions[index].name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                  maxFontSize: 15,
                                                  minFontSize: 12,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                AutoSizeText(
                                                  "Mulai dari ${formatCurrency.format(double.parse(lms.subscriptions[index].subscription_prices![0].selling_price))}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.teal,
                                                  ),
                                                  maxFontSize: 13,
                                                  minFontSize: 11,
                                                ),
                                                const SizedBox(
                                                  height: 35,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 47,
                                                        width: 110,
                                                        child: TextButton(
                                                            style: ButtonStyle(
                                                              padding: MaterialStateProperty.all<
                                                                      EdgeInsets>(
                                                                  const EdgeInsets
                                                                      .all(11)),
                                                              foregroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .teal),
                                                              shape: MaterialStateProperty
                                                                  .all<
                                                                      RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  side: const BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .teal),
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              orderController.goToPaymentSubscription(
                                                                  lms.subscription
                                                                      .id,
                                                                  lms.subscription
                                                                      .name,
                                                                  lms.subscription
                                                                          .subscription_prices![
                                                                      index]);
                                                            },
                                                            child: const Text(
                                                                "Beli Paket")),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Container(
                                width: 370,
                                height: 265,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 5.0,
                                      offset: const Offset(
                                        0,
                                        3,
                                      ),
                                    ),
                                  ],
                                ),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: lms.subscriptions.length,
                                  itemBuilder: (contex, index) =>
                                      GestureDetector(
                                    onTap: () => Get.to(
                                      () => SubscriptionScreen(
                                        subscriptionId:
                                            lms.subscriptions[index].id,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 35,
                                        left: 17,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 230,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 77,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Image.network(
                                                      lms.subscriptions[index]
                                                          .thumbnail!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                AutoSizeText(
                                                  lms.subscriptions[index].name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                  maxFontSize: 15,
                                                  minFontSize: 12,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                AutoSizeText(
                                                  "Mulai dari ${formatCurrency.format(double.parse(lms.subscriptions[index].subscription_prices![0].selling_price))}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.teal,
                                                  ),
                                                  maxFontSize: 13,
                                                  minFontSize: 11,
                                                ),
                                                const SizedBox(
                                                  height: 17,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 24),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Row(
                                                              children: const [
                                                                AutoSizeText(
                                                                  "Rp.200.000",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    color: Colors
                                                                        .teal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                  maxFontSize:
                                                                      16,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              width: 7,
                                                            ),
                                                            Container(
                                                              width: 33,
                                                              height: 21,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        220,
                                                                        220),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          4),
                                                                ),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child:
                                                                    AutoSizeText(
                                                                  " 15%",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                  maxFontSize:
                                                                      13,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 7,
                                                        ),
                                                        const AutoSizeText(
                                                          "Promo Akhir Tahun",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Popppins",
                                                            color: Color(
                                                                0x70252424),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            height: 230,
                                            decoration: const BoxDecoration(
                                                color: Colors.white),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 77,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Image.network(
                                                      lms.subscriptions[index]
                                                          .thumbnail!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                AutoSizeText(
                                                  lms.subscriptions[index].name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                  maxFontSize: 15,
                                                  minFontSize: 12,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                AutoSizeText(
                                                  "Mulai dari ${formatCurrency.format(double.parse(lms.subscriptions[index].subscription_prices![0].selling_price))}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.teal,
                                                  ),
                                                  maxFontSize: 13,
                                                  minFontSize: 11,
                                                ),
                                                const SizedBox(
                                                  height: 35,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 47,
                                                        width: 110,
                                                        child: TextButton(
                                                            style: ButtonStyle(
                                                              padding: MaterialStateProperty.all<
                                                                      EdgeInsets>(
                                                                  const EdgeInsets
                                                                      .all(11)),
                                                              foregroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .teal),
                                                              shape: MaterialStateProperty
                                                                  .all<
                                                                      RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  side: const BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .teal),
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              orderController.goToPaymentSubscription(
                                                                  lms.subscription
                                                                      .id,
                                                                  lms.subscription
                                                                      .name,
                                                                  lms.subscription
                                                                          .subscription_prices![
                                                                      index]);
                                                            },
                                                            child: const Text(
                                                                "Beli Paket")),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Container(
                                width: 370,
                                height: 265,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 5.0,
                                      offset: const Offset(
                                        0,
                                        3,
                                      ),
                                    ),
                                  ],
                                ),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: lms.subscriptions.length,
                                  itemBuilder: (contex, index) =>
                                      GestureDetector(
                                    onTap: () => Get.to(
                                      () => SubscriptionScreen(
                                        subscriptionId:
                                            lms.subscriptions[index].id,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 35,
                                        left: 17,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 230,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 77,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Image.network(
                                                      lms.subscriptions[index]
                                                          .thumbnail!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                AutoSizeText(
                                                  lms.subscriptions[index].name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                  maxFontSize: 15,
                                                  minFontSize: 12,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                AutoSizeText(
                                                  "Mulai dari ${formatCurrency.format(double.parse(lms.subscriptions[index].subscription_prices![0].selling_price))}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.teal,
                                                  ),
                                                  maxFontSize: 13,
                                                  minFontSize: 11,
                                                ),
                                                const SizedBox(
                                                  height: 17,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 24),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Row(
                                                              children: const [
                                                                AutoSizeText(
                                                                  "Rp.200.000",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    color: Colors
                                                                        .teal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                  maxFontSize:
                                                                      16,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              width: 7,
                                                            ),
                                                            Container(
                                                              width: 33,
                                                              height: 21,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        220,
                                                                        220),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          4),
                                                                ),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child:
                                                                    AutoSizeText(
                                                                  " 15%",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                  maxFontSize:
                                                                      13,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 7,
                                                        ),
                                                        const AutoSizeText(
                                                          "Promo Akhir Tahun",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Popppins",
                                                            color: Color(
                                                                0x70252424),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            height: 230,
                                            decoration: const BoxDecoration(
                                                color: Colors.white),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 77,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Image.network(
                                                      lms.subscriptions[index]
                                                          .thumbnail!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                AutoSizeText(
                                                  lms.subscriptions[index].name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                  maxFontSize: 15,
                                                  minFontSize: 12,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                AutoSizeText(
                                                  "Mulai dari ${formatCurrency.format(double.parse(lms.subscriptions[index].subscription_prices![0].selling_price))}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.teal,
                                                  ),
                                                  maxFontSize: 13,
                                                  minFontSize: 11,
                                                ),
                                                const SizedBox(
                                                  height: 35,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 47,
                                                        width: 110,
                                                        child: TextButton(
                                                            style: ButtonStyle(
                                                              padding: MaterialStateProperty.all<
                                                                      EdgeInsets>(
                                                                  const EdgeInsets
                                                                      .all(11)),
                                                              foregroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .teal),
                                                              shape: MaterialStateProperty
                                                                  .all<
                                                                      RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  side: const BorderSide(
                                                                      width:
                                                                          2.0,
                                                                      color: Colors
                                                                          .teal),
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              orderController.goToPaymentSubscription(
                                                                  lms.subscription
                                                                      .id,
                                                                  lms.subscription
                                                                      .name,
                                                                  lms.subscription
                                                                          .subscription_prices![
                                                                      index]);
                                                            },
                                                            child: const Text(
                                                                "Beli Paket")),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
