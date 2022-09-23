import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/lms.dart';
import 'package:lentera_ilmu/models/lms/course_module_item.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// ignore: must_be_immutable
class YoutubeVideoPlayer extends StatefulWidget {
  bool lock = true;
  CourseModuleItem video;
  YoutubeVideoPlayer({Key? key, required this.lock, required this.video})
      : super(key: key);
  @override
  _YoutubeVideoPlayer createState() => _YoutubeVideoPlayer();
}

class _YoutubeVideoPlayer extends State<YoutubeVideoPlayer> {
  final lmsController = Get.put(LMSController());
  @override
  void initState() {
    super.initState();
    lmsController.setSelectedCourse(widget.video);
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
      home: GetBuilder<LMSController>(builder: (lms) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const Text("Video Player"),
            centerTitle: false,
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
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      YoutubePlayerIFrame(
                        controller: lms.youtubeController,
                        aspectRatio: 16 / 9,
                      ),
                    ],
                  ),
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
                        lms.course.creator_name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.purple,
                        ),
                        maxFontSize: 12,
                      ),
                      const Padding(padding: EdgeInsets.all(1)),
                      AutoSizeText(
                        widget.video.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        maxFontSize: 16,
                      ),
                      const Padding(padding: EdgeInsets.all(2)),
                      AutoSizeText(
                        widget.video.description!,
                        maxFontSize: 12,
                      ),
                    ],
                  ),
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
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              maxFontSize: 12,
                              maxLines: 1,
                            ),
                            const Padding(padding: EdgeInsets.all(4)),
                            for (var course in module.module_items)
                              course.id != widget.video.id
                                  ? Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () => {
                                            if (course.id != widget.video.id)
                                              {
                                                if (lms.course.user_course !=
                                                        null ||
                                                    widget.lock == false ||
                                                    lms.course.member == 0)
                                                  {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            YoutubeVideoPlayer(
                                                          lock: widget.lock,
                                                          video: course,
                                                        ),
                                                      ),
                                                    )
                                                  }
                                                else
                                                  {
                                                    if (course.is_preview == 1)
                                                      {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                YoutubeVideoPlayer(
                                                              lock: widget.lock,
                                                              video: course,
                                                            ),
                                                          ),
                                                        )
                                                      }
                                                    else
                                                      {null}
                                                  }
                                              }
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            // padding: const EdgeInsets.all(4),
                                            // margin: const EdgeInsets.only(left: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                      )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Divider()
                                      ],
                                    )
                                  : Container(),
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
