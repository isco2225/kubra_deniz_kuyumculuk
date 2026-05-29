import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.size = 42});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _InfinityRingPainter(),
      ),
    );
  }
}

class _InfinityRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1
      ..shader = const LinearGradient(
        colors: [AppColors.mutedGold, AppColors.gold, AppColors.mutedGold],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final left = Rect.fromCircle(
      center: Offset(size.width * 0.35, size.height * 0.5),
      radius: size.width * 0.22,
    );
    final right = Rect.fromCircle(
      center: Offset(size.width * 0.65, size.height * 0.5),
      radius: size.width * 0.22,
    );

    canvas.drawArc(left, 0.45, 5.2, false, ringPaint);
    canvas.drawArc(right, 3.55, 5.2, false, ringPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
