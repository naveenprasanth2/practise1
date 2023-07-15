import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  final bool isTrue;
  final double size;
  final Color color;
  final IconData iconData;

  const CircleContainer({
    Key? key,
    required this.isTrue,
    required this.size,
    required this.color,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 2),
            ),
            child: Center(
              child: Icon(iconData),
            ),
          ),
          if (!isTrue)
            Positioned.fill(
              child: CustomPaint(
                painter: StrikeThroughPainter(),
              ),
            ),
        ],
      ),
    );
  }
}

class StrikeThroughPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black // Replace with your desired strike-through line color
      ..strokeWidth = 2.0; // Replace with your desired strike-through line thickness

    final startX = size.width * 0.2;
    final startY = size.height * 0.8;
    final endX = size.width * 0.8;
    final endY = size.height * 0.2;

    canvas.drawLine(
      Offset(startX, startY),
      Offset(endX, endY),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
