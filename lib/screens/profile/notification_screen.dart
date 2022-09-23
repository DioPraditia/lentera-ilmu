import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/profile.dart';
import 'package:lentera_ilmu/services/utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreen createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  final profileController = Get.put(ProfileController());
  late ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    profileController.getListNotifications(
        page: 0, size: 20, resetData: true, withLoading: true);
    profileController.read = [];
    scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      profileController.getListNotifications(
          page: profileController.lastPage + 1, size: 20, resetData: false);
    }
    if (scrollController.offset <= 0) {
      profileController.read = [];
      profileController.getListNotifications(
          page: 0, size: 20, resetData: true);
    }
  }

  Future refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    profileController.getListNotifications(page: 0, size: 20, resetData: true);
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
            "Notifikasi",
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
        body: RefreshIndicator(
          color: Colors.teal,
          onRefresh: () => refreshData(),
          child: GetBuilder<ProfileController>(
            builder: (profile) {
              return profile.loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.teal,
                      ),
                    )
                  // ignore: prefer_is_empty
                  : profile.notifications.length < 1
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/img/empty/coming_soon.png",
                                width: MediaQuery.of(context).size.width * .60,
                              ),
                              const Padding(padding: EdgeInsets.all(14)),
                              const Text(
                                  "Ups... Belum ada notifikasi nih buat Kamu."),
                              const Padding(padding: EdgeInsets.all(24)),
                            ],
                          ),
                        )
                      : ListView.separated(
                          controller: scrollController,
                          itemCount: profile.notifications.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (_, i) {
                            return GestureDetector(
                              onTap: () => {
                                profileController.readNotification(
                                    notification: profile.notifications[i],
                                    context: context)
                              },
                              child: Container(
                                color: (profile.notifications[i].read == 1 ||
                                        profile.read.contains(
                                            profile.notifications[i].id))
                                    ? Colors.white
                                    : Colors.green.shade50,
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      parseDate(
                                          profile.notifications[i].created_on),
                                      maxFontSize: 12,
                                      style: const TextStyle(
                                        color: Colors.purple,
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.all(2)),
                                    AutoSizeText(
                                      profile.notifications[i].title,
                                      maxFontSize: 12,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.all(2)),
                                    AutoSizeText(
                                      profile.notifications[i].message,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      maxFontSize: 23,
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        );
            },
          ),
        ),
      ),
    );
  }
}
