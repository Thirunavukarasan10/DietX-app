import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double size;
  
  const Logo({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: LogoPainter(),
    );
  }
}

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    
    final path = Path();
    
    // Hand shape
    path.moveTo(size.width * 0.3, size.height * 0.2);
    path.lineTo(size.width * 0.15, size.height * 0.45);
    path.lineTo(size.width * 0.3, size.height * 0.55);
    path.lineTo(size.width * 0.25, size.height * 0.8);
    path.lineTo(size.width * 0.4, size.height * 0.75);
    path.lineTo(size.width * 0.45, size.height * 0.5);
    path.lineTo(size.width * 0.6, size.height * 0.7);
    path.lineTo(size.width * 0.7, size.height * 0.55);
    path.lineTo(size.width * 0.55, size.height * 0.4);
    path.lineTo(size.width * 0.75, size.height * 0.35);
    path.lineTo(size.width * 0.65, size.height * 0.2);
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}