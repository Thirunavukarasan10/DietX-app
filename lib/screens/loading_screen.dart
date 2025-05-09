import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'results_screen.dart'; // Ensure this file exists and is correctly located

class LoadingScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const LoadingScreen({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();

    // Setup animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    // Start timer to update progress
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_progressValue < 1.0) {
        setState(() {
          _progressValue += 0.02;
        });
      } else {
        timer.cancel();
      }
    });

    // Navigate to results after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ResultsScreen(userData: widget.userData),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Character Image
            Image.asset(
              'assets/images/loading.png', // Make sure this image exists in assets/images/
              height: 180,
              width: 180,
            ),

            const SizedBox(height: 32),

            // Title
            Text(
              'Preparing your plan',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // Subtitle
            Text(
              'Setting up your nutrition plans and\nanalyzing your goals...',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 40),

            // Progress indicator
            Container(
              width: 240,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: 240 * _progressValue,
                    decoration: BoxDecoration(
                      color: const Color(0xFFA7DBA2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
