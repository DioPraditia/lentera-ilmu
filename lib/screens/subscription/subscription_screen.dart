import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/lms.dart';
import 'package:lentera_ilmu/controllers/order.dart';
import 'package:lentera_ilmu/screens/course/course_screen.dart';
import 'package:lentera_ilmu/screens/subscription/subscription_activity_screen.dart';
import 'package:lentera_ilmu/services/utils.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: unused_import
import 'package:path/path.dart' as p;

class SubscriptionScreen extends StatefulWidget {
  final int subscriptionId;
  const SubscriptionScreen({Key? key, required this.subscriptionId})
      : super(key: key);

  @override
  _SubscriptionScreen createState() => _SubscriptionScreen();
}

class _SubscriptionScreen extends State<SubscriptionScreen> {
  final lmsController = Get.put(LMSController());
  final orderController = Get.put(OrderController());
  @override
  void initState() {
    super.initState();
    lmsController.getSubscriptionDetails(widget.subscriptionId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _launchUrl(String url) async {
    if (url != "") {
      // ignore: deprecated_member_use
      if (await canLaunch(url)) {
        // ignore: deprecated_member_use
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      // onGenerateInitialRoutes: (_) => lmsController.getCourse(widget.course.id),
      debugShowCheckedModeBanner: false,
      home: GetBuilder<LMSController>(builder: (lms) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const AutoSizeText(
              "Program Berlangganan",
              maxFontSize: 16,
            ),
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => {
                Get.back(),
              },
            ),
            actions: const [
              // GestureDetector(
              //   onTap: () => Get.to(() => CartScreen()),
              //   child: Container(
              //     padding: const EdgeInsets.all(8),
              //     child: const Icon(
              //       Icons.shopping_cart,
              //       size: 24,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
          body: lms.loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .27,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: NetworkImage(lms.subscription.image ??
                                lms.subscription.thumbnail!),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        // child: Text("dsmslk"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(48),
                            topRight: Radius.circular(48),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              lms.subscription.mentor_name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.purple,
                              ),
                              maxFontSize: 12,
                              maxLines: 1,
                            ),
                            const Padding(padding: EdgeInsets.all(1)),
                            AutoSizeText(
                              lms.subscription.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                              maxFontSize: 16,
                            ),
                            const Padding(padding: EdgeInsets.all(2)),
                            AutoSizeText(
                              lms.subscription.descriptions,
                              maxFontSize: 12,
                            ),
                            (lms.subscription.user_subscription != null)
                                ? (lms.subscription.group_link != null &&
                                        lms.subscription.group_link != "")
                                    ? Container(
                                        padding: const EdgeInsets.only(top: 4),
                                        decoration: const BoxDecoration(
                                          // color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(48),
                                            topRight: Radius.circular(48),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                      vertical: 10),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  // ignore: deprecated_member_use
                                                  primary: Colors.white,
                                                  minimumSize:
                                                      const Size(50, 16),
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80.0),
                                                  ),
                                                ),
                                                onPressed: () => {
                                                  _launchUrl(lms.subscription
                                                          .group_link ??
                                                      "")
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 40.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    color: Colors.teal,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: const Text(
                                                    "Buka Grup",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container()
                                : Container()
                          ],
                        ),
                      ),
                      const Divider(thickness: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: AutoSizeText(
                              "${lms.subscription.user_subscription == null ? "Mulai Berlangganan" : "Perpanjang Langganan"} ",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                              maxFontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .23,
                            child: ListView.builder(
                              itemCount:
                                  lms.subscription.subscription_prices!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (contex, index) => GestureDetector(
                                onTap: () => {
                                  orderController.goToPaymentSubscription(
                                      lms.subscription.id,
                                      lms.subscription.name,
                                      lms.subscription
                                          .subscription_prices![index])
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: MediaQuery.of(context).size.width /
                                      ((3) <= 3 ? 3 : 3.3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal.shade200,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      boxShadow: const <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 2.0,
                                            offset: Offset(0.0, 0.75))
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // const Padding(padding: EdgeInsets.all(4)),
                                        AutoSizeText(
                                          "${lms.subscription.subscription_prices![index].subscription_month} Bulan",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxFontSize: 14,
                                          maxLines: 1,
                                        ),
                                        AutoSizeText(
                                          formatCurrency.format(double.parse(lms
                                              .subscription
                                              .subscription_prices![index]
                                              .selling_price)),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                          maxFontSize: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(thickness: 6),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var item
                                    in lms.subscription.subscription_items!)
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => {
                                          if (lms.subscription
                                                  .user_subscription !=
                                              null)
                                            {
                                              if (item.item_type == 'activity')
                                                {
                                                  Get.to(
                                                    () =>
                                                        SubscriptionActivityScreen(
                                                      activity: item,
                                                    ),
                                                  )
                                                }
                                              else if (item.item_type ==
                                                  "course")
                                                {
                                                  Get.to(
                                                    () => CourseScreen(
                                                      courseId: item.course_id!,
                                                      lock: false,
                                                    ),
                                                  )
                                                }
                                              else
                                                {null}
                                            }
                                          else
                                            {null}
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          color: Colors.transparent,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(
                                                    parseSubscriptionItemType(
                                                        item.item_type),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.purple,
                                                    ),
                                                    maxFontSize: 12,
                                                    maxLines: 1,
                                                  ),
                                                  AutoSizeText(
                                                    item.name,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    maxFontSize: 14,
                                                  ),
                                                  if (item.item_type ==
                                                      'activity')
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AutoSizeText(
                                                          item.activity_location!,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: Colors.grey,
                                                          ),
                                                          maxFontSize: 12,
                                                          maxLines: 1,
                                                        ),
                                                        AutoSizeText(
                                                          parseDate(item
                                                                  .activity_date ??
                                                              "0000-00-00 00:00:00"),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: Colors.grey,
                                                          ),
                                                          maxFontSize: 12,
                                                          maxLines: 1,
                                                        ),
                                                      ],
                                                    )
                                                ],
                                              ),
                                              Icon(
                                                lms.subscription
                                                            .user_subscription !=
                                                        null
                                                    ? Icons.play_arrow
                                                    : Icons.lock,
                                                size: 24,
                                                color: Colors.teal,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        );
      }),
    );
  }
}
