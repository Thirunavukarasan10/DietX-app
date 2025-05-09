import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diet_x/screens/login.dart';

class Intro3Screen extends StatelessWidget {
  const Intro3Screen({Key? key}) : super(key: key);

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
              'assets/images/logo.png',
              width: 40,
              height: 40,
            ),
          ),

          // Login button in top right corner
          Positioned(
            top: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const LoginScreen()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE0F0E0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image with circular background
                Container(
                  width: 280,
                  height: 280,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0F0E0),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/intro3_screen.png',
                      width: 240,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Card
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
                        "Live Healthy & Stay strong",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Let's Start the journey and live healthy together!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Modified Start button to match the image
                      SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF4CAF50),
                                width: 4,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () => Get.to(() => const LoginScreen()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0A0A50), // Dark blue/navy
                                padding: EdgeInsets.zero,
                                shape: const CircleBorder(),
                                elevation: 0,
                              ),
                              child: const Center(
                                child: Text(
                                  'Start',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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