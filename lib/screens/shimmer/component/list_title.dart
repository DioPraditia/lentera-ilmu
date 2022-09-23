import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ListTitleShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width * 0.30,
            color: Colors.grey,
          ),
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width * 0.20,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
