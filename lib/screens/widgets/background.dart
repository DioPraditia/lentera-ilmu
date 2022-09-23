import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // ignore: sized_box_for_whitespace
    return Container(
      // color: Colors.red,
      width: size.width,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Positioned(
          //   top: 0,
          //   right: 0,
          //   child: Image.asset("assets/img/auth/top1.png"),
          // ),
          // Positioned(
          //   top: 0,
          //   right: 0,
          //   child: Image.asset("assets/img/auth/top2.png"),
          // ),
          // Positioned(
          //   top: 50,
          //   right: 30,
          //   child: Image.asset("assets/img/auth/main.png",
          //       width: size.width * 0.35),
          // ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   child: Image.asset("assets/img/auth/bottom1.png"),
          // ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   child: Image.asset("assets/img/auth/bottom2.png"),
          // ),
          child
        ],
      ),
    );
  }
}
