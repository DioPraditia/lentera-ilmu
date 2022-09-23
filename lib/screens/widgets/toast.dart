import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

void showBottomFlash({
  bool persistent = true,
  EdgeInsets margin = EdgeInsets.zero,
  required BuildContext context,
  required String message,
  required Widget icon,
}) {
  showFlash(
    duration: const Duration(seconds: 2),
    context: context,
    persistent: persistent,
    builder: (_, controller) {
      return Flash(
        controller: controller,
        margin: margin,
        behavior: FlashBehavior.fixed,
        position: FlashPosition.bottom,
        borderRadius: BorderRadius.circular(8.0),
        borderColor: Colors.teal,
        boxShadows: kElevationToShadow[8],
        // backgroundGradient: RadialGradient(
        //   colors: [Colors.amber, Colors.black87],
        //   center: Alignment.topLeft,
        //   radius: 2,
        // ),
        onTap: () => controller.dismiss(),
        // forwardAnimationCurve: Curves.easeInCirc,
        // reverseAnimationCurve: Curves.bounceIn,
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.grey),
          child: FlashBar(
            // title: Text('Hello Flash'),
            content: Text(message),
            // indicatorColor: Colors.red,
            icon: icon,
            primaryAction: TextButton(
              onPressed: () => controller.dismiss(),
              child: const Text('TUTUP'),
            ),
            // actions: <Widget>[
            //   TextButton(
            //       onPressed: () => controller.dismiss('Yes, I do!'),
            //       child: Text('YES')),
            //   TextButton(
            //       onPressed: () => controller.dismiss('No, I do not!'),
            //       child: Text('NO')),
            // ],
          ),
        ),
      );
    },
  ).then((_) {
    if (_ != null) {
      _showMessage(_.toString(), context);
    }
  });
}

void _showMessage(String message, BuildContext context) {
  showFlash(
      context: context,
      duration: const Duration(seconds: 1),
      builder: (_, controller) {
        return Flash(
          controller: controller,
          position: FlashPosition.top,
          behavior: FlashBehavior.fixed,
          child: FlashBar(
            icon: const Icon(
              Icons.face,
              size: 36.0,
              color: Colors.black,
            ),
            content: Text(message),
          ),
        );
      });
}
