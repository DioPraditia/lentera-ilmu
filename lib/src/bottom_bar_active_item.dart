import 'package:flutter/material.dart';

import 'constant/constant.dart';

class BottomBarActiveItem extends StatelessWidget {
  const BottomBarActiveItem(
    this.index, {
    this.itemWidget,
    this.scrollPosition,
    this.onTap,
  });

  /// item index
  final int index;

  /// item
  final Widget? itemWidget;

  /// Double value to indicate the item position
  final double? scrollPosition;

  /// Function called when an item was tapped
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    final icon = itemWidget!;
    return InkWell(
      child: SizedBox.fromSize(
        size: const Size(kIconSize, kIconSize),
        child: Opacity(
            opacity: kPi * 2 * (scrollPosition! % 1) == 0 ? 1 : 0, child: icon),
      ),
      onTap: () => onTap!(index),
    );
  }
}