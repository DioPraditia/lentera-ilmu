import 'package:flutter/material.dart';
import 'package:lentera_ilmu/screens/shimmer/component/list_course.dart';
import 'package:lentera_ilmu/screens/shimmer/component/list_title.dart';
import 'package:shimmer/shimmer.dart';

// ignore: use_key_in_widget_constructors
class HomeCourseShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        children: [
          ListTitleShimmer(),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (_, __) => ListCourseShimmer(),
          ),
        ],
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class HomeSubscriptionShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        children: [
          ListTitleShimmer(),
          SizedBox(
            height: MediaQuery.of(context).size.width * .5,
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: ListView.builder(
                  itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (contex, index) => Container(
                        color: Colors.grey,
                        margin: const EdgeInsets.all(2),
                        width: MediaQuery.of(context).size.width / 1.9,
                        height: MediaQuery.of(context).size.width / 1.9,
                      )),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class HomeNewsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        margin: const EdgeInsets.all(8),
        height: 100,
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class HomeCategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      enabled: true,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width / 5,
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (contex, index) => Container(
                        color: Colors.grey,
                        margin: const EdgeInsets.all(2),
                        width: MediaQuery.of(context).size.width / 5,
                        height: MediaQuery.of(context).size.width / 5,
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
