library rolling_bottom_bar;

import 'package:flutter/material.dart';

import 'constant/constant.dart';

class BottomBarPainter extends CustomPainter {
  BottomBarPainter({@required this.position, this.color, this.showShadow})
      : _paint = Paint()
          ..color = color ?? Colors.white
          ..isAntiAlias = true,
        _shadowColor = Colors.grey.shade600;

  /// position
  final double? position;

  /// Color for the bottom bar
  final Color? color;

  /// Paint value to custom painter
  final Paint? _paint;

  /// Shadow Color
  final Color? _shadowColor;

  /// Boolean to show shadow
  final bool? showShadow;

  @override
  void paint(Canvas canvas, Size size) {
    _drawBar(canvas, size);
    _drawFloatingCircle(canvas);
  }

  @override
  bool shouldRepaint(BottomBarPainter oldDelegate) {
    return position != oldDelegate.position || color != oldDelegate.color;
  }

  /// draw bottom bar
  void _drawBar(Canvas canvas, Size size) {
    const left = kMargin;
    final right = size.width - kMargin;
    const top = kMargin;
    const bottom = top + kHeight;

    final path = Path()
      ..moveTo(left + kTopRadius, top)
      ..lineTo(position! - kTopRadius, top)
      ..relativeArcToPoint(
        const Offset(kTopRadius, kTopRadius),
        radius: const Radius.circular(kTopRadius),
      )
      ..relativeArcToPoint(
        const Offset((kCircleRadius + kCircleMargin) * 2, 0.0),
        radius: const Radius.circular(kCircleRadius + kCircleMargin),
        clockwise: false,
      )
      ..relativeArcToPoint(
        const Offset(kTopRadius, -kTopRadius),
        radius: const Radius.circular(kTopRadius),
      )
      ..lineTo(right - kTopRadius, top)
      ..relativeArcToPoint(
        const Offset(kTopRadius, kTopRadius),
        radius: const Radius.circular(kTopRadius),
      )
      ..lineTo(right, bottom - kBottomRadius)
      ..relativeArcToPoint(
        const Offset(-kBottomRadius, kBottomRadius),
        radius: const Radius.circular(kBottomRadius),
      )
      ..lineTo(left + kBottomRadius, bottom)
      ..relativeArcToPoint(
        const Offset(-kBottomRadius, -kBottomRadius),
        radius: const Radius.circular(kBottomRadius),
      )
      ..lineTo(left, top + kTopRadius)
      ..relativeArcToPoint(
        const Offset(kTopRadius, -kTopRadius),
        radius: const Radius.circular(kTopRadius),
      );
    if (this.showShadow!) {
      canvas..drawShadow(path, _shadowColor!, 5.0, true);
    }
    canvas.drawPath(path, _paint!);
  }

  /// Function used to draw the circular indicator
  void _drawFloatingCircle(Canvas canvas) {
    final path = Path()
      ..addArc(
        Rect.fromCircle(
          center: Offset(
            position! + kCircleMargin + kCircleRadius,
            kMargin + kCircleMargin,
          ),
          radius: kCircleRadius,
        ),
        0,
        kPi * 2,
      );
    if (this.showShadow!) {
      canvas..drawShadow(path, _shadowColor!, 5.0, true);
    }
    canvas.drawPath(path, _paint!);
  }
}
