import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/lms.dart';
import 'package:lentera_ilmu/screens/course/youtube_video_player.dart';

// ignore: must_be_immutable
class DeskripsiCourse extends StatefulWidget {
  bool lock = true;
  DeskripsiCourse({Key? key, required this.lock}) : super(key: key);

  @override
  State<DeskripsiCourse> createState() => _DeskripsiCourseState();
}

class _DeskripsiCourseState extends State<DeskripsiCourse> {
  double edge = 24;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: GetBuilder<LMSController>(
        builder: (lms) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: const AutoSizeText(
                "Detail Kursus",
                maxFontSize: 16,
              ),
              centerTitle: false,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => {
                  Get.back(),
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 17,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            bottom: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(
                                lms.course.image ?? lms.course.thumbnail!,
                                width: 80,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: lms.course.creator_name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.purple,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '\n${lms.course.title}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: const [
                              AutoSizeText(
                                "Deskripsi",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              AutoSizeText(
                                lms.course.description!,
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(thickness: 6),
                    for (var module in lms.course.modules!)
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  module.title,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                  maxFontSize: 14,
                                  maxLines: 1,
                                ),
                                const Padding(padding: EdgeInsets.all(4)),
                                for (var course in module.module_items)
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => {
                                          if (lms.course.user_course != null ||
                                              widget.lock == false)
                                            {
                                              Get.to(
                                                () => YoutubeVideoPlayer(
                                                  lock: widget.lock,
                                                  video: course,
                                                ),
                                                transition:
                                                    Transition.rightToLeft,
                                                duration: const Duration(
                                                    milliseconds: 400),
                                              ),
                                            }
                                          else
                                            {
                                              if (course.is_preview == 1)
                                                {
                                                  Get.to(
                                                    () => YoutubeVideoPlayer(
                                                      lock: widget.lock,
                                                      video: course,
                                                    ),
                                                    transition:
                                                        Transition.rightToLeft,
                                                    duration: const Duration(
                                                        microseconds: 400),
                                                  ),
                                                }
                                              else
                                                {null}
                                            }
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 18),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .72,
                                                child: AutoSizeText(
                                                  course.title,
                                                  textAlign: TextAlign.left,
                                                  maxFontSize: 12,
                                                ),
                                              ),
                                              lms.course.price_type == "free"
                                                  ? Icon(
                                                      widget.lock == false ||
                                                              course.is_preview ==
                                                                  1
                                                          ? Icons.play_arrow
                                                          : Icons.lock,
                                                      size: 28,
                                                      color: Colors.teal,
                                                    )
                                                  : Icon(
                                                      lms.course.user_course !=
                                                                  null ||
                                                              course.is_preview ==
                                                                  1 ||
                                                              widget.lock ==
                                                                  false
                                                          ? Icons.play_arrow
                                                          : Icons.lock,
                                                      size: 28,
                                                      color: Colors.teal,
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Divider()
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
            ),
          );
        },
      ),
    );
  }
}
