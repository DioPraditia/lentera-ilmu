import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/lms.dart';
import 'package:lentera_ilmu/screens/subscription/subscription_screen.dart';
import 'package:lentera_ilmu/screens/transaction/cart/cart_screen.dart';
import 'package:lentera_ilmu/screens/widgets/list_course_item.dart';

class SubscriptinListScreen extends StatefulWidget {
  const SubscriptinListScreen({Key? key}) : super(key: key);

  @override
  _SubscriptinListScreen createState() => _SubscriptinListScreen();
}

class _SubscriptinListScreen extends State<SubscriptinListScreen> {
  late ScrollController scrollController;
  final lmsController = Get.put(LMSController());
  @override
  void initState() {
    super.initState();
    lmsController.getListSubscriptions(0, 20, true);
    scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      lmsController.getListSubscriptions(lmsController.lastPage + 1, 20, false);
    }
    if (scrollController.offset <= 0) {
      lmsController.getListSubscriptions(0, 20, false);
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
          actions: [
            GestureDetector(
              onTap: () => Get.to(() => const CartScreen()),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.shopping_cart,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: GetBuilder<LMSController>(
          builder: (course) => course.programLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ),
                )
              : course.subscriptions.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/img/empty/coming_soon.png",
                            width: MediaQuery.of(context).size.width * .60,
                          ),
                          const Padding(padding: EdgeInsets.all(14)),
                          const Padding(
                            padding: EdgeInsets.all(14),
                            child: Text(
                              "Program belum tersedia. Silahkan kunjungi halaman ini dilain waktu...",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(24)),
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
                              onPressed: () => {
                                Get.back(),
                                lmsController.getHomeData(),
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80.0),
                                  color: Colors.teal,
                                ),
                                padding: const EdgeInsets.all(0),
                                child: const AutoSizeText(
                                  "Kembali",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxFontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: course.subscriptions.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () => Get.to(
                            () => SubscriptionScreen(
                              subscriptionId: course.subscriptions[index].id,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            child: ListCourseItem(
                              image:
                                  course.subscriptions[index].thumbnail ?? '',
                              title: course.subscriptions[index].name,
                              mentor: course.subscriptions[index].mentor_name,
                              descriptions:
                                  course.subscriptions[index].descriptions,
                              price: course.subscriptions[index]
                                  .subscription_prices![0].selling_price,
                              showPrice: true,
                            ),
                          ),
                        );
                      }),
        ),
      ),
    );
  }
}
