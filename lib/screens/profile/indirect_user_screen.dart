import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lentera_ilmu/controllers/profile.dart';

class IndirectUserScreen extends StatefulWidget {
  final int userId;
  final int onBackUserId;
  const IndirectUserScreen(
      {Key? key, required this.userId, required this.onBackUserId})
      : super(key: key);

  @override
  _IndirectUserScreen createState() => _IndirectUserScreen();
}

class _IndirectUserScreen extends State<IndirectUserScreen> {
  late ScrollController scrollController;
  final profileController = Get.put(ProfileController());
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
  String getInitials(String bankAccountName) => bankAccountName
      .trim()
      .split(RegExp(' +'))
      .map((s) => s[0])
      .take(2)
      .join();
  @override
  void initState() {
    super.initState();
    profileController.getListDirectUsers(
        page: 0, restartData: true, userId: widget.userId);
    scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      profileController.getListDirectUsers(
        page: profileController.lastPage + 1,
        restartData: false,
        userId: widget.userId,
      );
    }
    if (scrollController.offset <= 0) {
      profileController.getListDirectUsers(
        page: 0,
        restartData: true,
        userId: widget.userId,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      profileController.getListDirectUsers(
        page: 0,
        restartData: true,
        userId: widget.onBackUserId,
      );
      profileController.setTreeIncrement(profileController.treeCounter - 1);
      Get.back();
      return true;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Roboto',
        ),
        debugShowCheckedModeBanner: false,
        home: GetBuilder<ProfileController>(
          builder: (profil) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: const AutoSizeText(
                "Indirect User",
                maxFontSize: 16,
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => {
                  profil.getListDirectUsers(
                    page: 0,
                    restartData: true,
                    userId: widget.onBackUserId,
                  ),
                  profil.setTreeIncrement(profil.treeCounter - 1),
                  Get.back(),
                },
              ),
            ),
            body: profil.loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.teal,
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    itemCount: profil.directUsers.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (_, i) {
                      return GestureDetector(
                        onTap: () => {
                          if ((profil.treeCounter + 1) <= 5 &&
                              profil.directUsers[i].total_direct_users! > 0)
                            {
                              profil.setTreeIncrement(profil.treeCounter + 1),
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IndirectUserScreen(
                                    userId: profil.directUsers[i].id,
                                    onBackUserId: widget.userId,
                                  ),
                                ),
                              )
                            }
                          else
                            {null}
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(
                              top: 4, bottom: 4, left: 8, right: 8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 2.0,
                                  offset: Offset(0.0, 0.75))
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.teal,
                                    child: Text(
                                      getInitials(profil.directUsers[i].name),
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const Padding(padding: EdgeInsets.all(8)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        profil.directUsers[i].name,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxFontSize: 14,
                                      ),
                                      const Padding(padding: EdgeInsets.all(1)),
                                      AutoSizeText(
                                        profil.directUsers[i].phone,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                        maxFontSize: 12,
                                      ),
                                      const Padding(padding: EdgeInsets.all(1)),
                                      AutoSizeText(
                                        profil.directUsers[i]
                                                    .subscription_status ==
                                                "subscribe"
                                            ? "Berlangganan Hingga ${profil.directUsers[i].subscription_until_date}"
                                            : "Belum Berlangganan",
                                        style: TextStyle(
                                          color: profil.directUsers[i]
                                                      .subscription_status ==
                                                  "subscribe"
                                              ? Colors.green
                                              : Colors.orange,
                                          fontSize: 12,
                                        ),
                                        maxFontSize: 12,
                                      ),
                                      const Padding(padding: EdgeInsets.all(2)),
                                      if (profil.directUsers[i]
                                              .subscription_status ==
                                          "subscribe")
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 3,
                                                  bottom: 4,
                                                  left: 4,
                                                  right: 4),
                                              decoration: BoxDecoration(
                                                color: profil.directUsers[i]
                                                            .total_direct_users! >
                                                        0
                                                    ? Colors.purple
                                                    : Colors.orange,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(2)),
                                              ),
                                              child: Text(
                                                profil.directUsers[i]
                                                            .total_direct_users! >
                                                        0
                                                    ? "${profil.directUsers[i].total_direct_users} Pengguna Direct"
                                                    : "Belum Memiliki Direct",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                            // const Padding(padding: EdgeInsets.all(4)),
                                            // Container(
                                            //   padding: const EdgeInsets.only(
                                            //       top: 3, bottom: 4, left: 4, right: 4),
                                            //   decoration: const BoxDecoration(
                                            //     color: Colors.indigo,
                                            //     borderRadius: BorderRadius.all(
                                            //         Radius.circular(2)),
                                            //   ),
                                            //   child: const Text(
                                            //     "5 Indirect User",
                                            //     style: TextStyle(
                                            //       color: Colors.white,
                                            //       fontSize: 10,
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        )
                                    ],
                                  ),
                                ],
                              ),
                              if (profil.directUsers[i].subscription_status ==
                                      "subscribe" &&
                                  profil.treeCounter < 5)
                                const Icon(
                                  Icons.arrow_right,
                                  size: 30,
                                  color: Colors.teal,
                                )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
