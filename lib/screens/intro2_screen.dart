import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'intro3_screen.dart';

class Intro2Screen extends StatelessWidget {
  const Intro2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Logo in top left corner
          Positioned(
            top: 20,
            left: 20,
            child: Image.asset(
              'assets/images/logo.png', // Your logo image
              width: 40,
              height: 40,
            ),
          ),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Main image with circular background
                Container(
                  width: 280,
                  height: 280,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0F0E0),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/intro2_screen.png', // <- Changed image
                      width: 240,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Card with text and navigation button
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Track your Diet',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Monitor your diet habits with our\nsimple tracking system',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Next button with 75% progress
                      CustomProgressButton(
                        progress: 0.75,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Intro3Screen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomProgressButton extends StatelessWidget {
  final double progress;
  final VoidCallback onPressed;

  const CustomProgressButton({
    Key? key,
    required this.progress,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          // Progress indicator
          CustomPaint(
            size: const Size(60, 60),
            painter: ProgressPainter(
              backgroundColor: const Color(0xFFE0E0E0),
              progressColor: const Color(0xFF4CAF50), // Green fill
              progress: progress,
              strokeWidth: 4,
            ),
          ),
          // Button
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Material(
                color: const Color(0xFF071440),
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: onPressed,
                  customBorder: const CircleBorder(),
                  child: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final Color backgroundColor;
  final Color progressColor;
  final double progress;
  final double strokeWidth;

  ProgressPainter({
    required this.backgroundColor,
    required this.progressColor,
    required this.progress,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      -math.pi / 2,
      progress * 2 * math.pi,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
