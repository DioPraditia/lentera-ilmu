import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ListCourseShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            color: Colors.grey,
            width: MediaQuery.of(context).size.width * 0.22,
            height: MediaQuery.of(context).size.width * 0.22,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        height: 10,
                        width: MediaQuery.of(context).size.width * 0.20,
                        color: Colors.grey,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        height: 10,
                        width: MediaQuery.of(context).size.width * 0.60,
                        color: Colors.grey,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        height: 10,
                        width: MediaQuery.of(context).size.width * 0.60,
                        color: Colors.grey,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        height: 10,
                        width: MediaQuery.of(context).size.width * 0.35,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only(left: 6),
                  width: 30,
                  height: 30,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
