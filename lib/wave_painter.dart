import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height - 40);
    for (double i = 0; i <= size.width; i += 20) {
      path.lineTo(i, size.height - 40 + 20 * (i % 40 == 0 ? 1 : -1));
    }
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}//
