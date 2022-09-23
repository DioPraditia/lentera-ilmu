import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/models/lms/subscription_item.dart';
import 'package:lentera_ilmu/services/utils.dart';

class SubscriptionActivityScreen extends StatefulWidget {
  final SubscriptionItemModel activity;
  const SubscriptionActivityScreen({Key? key, required this.activity})
      : super(key: key);

  @override
  _SubscriptionActivityScreen createState() => _SubscriptionActivityScreen();
}

class _SubscriptionActivityScreen extends State<SubscriptionActivityScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // scrollController.dispose();
    // tutorialController.dispose();
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const AutoSizeText(
            "Kegiatan",
            maxFontSize: 16,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.activity.thumbnail ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: AutoSizeText(
                  widget.activity.name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  maxFontSize: 14,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: AutoSizeText(
                  widget.activity.descriptions,
                  maxFontSize: 12,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 24,
                          color: Colors.teal,
                        ),
                        const Padding(padding: EdgeInsets.all(4)),
                        AutoSizeText(
                          widget.activity.activity_location ?? "-",
                          maxFontSize: 12,
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(4)),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 24,
                          color: Colors.teal,
                        ),
                        const Padding(padding: EdgeInsets.all(4)),
                        AutoSizeText(
                          parseDate(widget.activity.activity_date ??
                              "0000-00-00 00:00:00"),
                          maxFontSize: 12,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
