import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onTap;
  final double progress;  // Added progress parameter to control the progress bar

  const NextButton({
    super.key, 
    required this.onTap,
    this.progress = 0.0,  // Default to no progress
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue, // Changed from AppColors.buttonNavy to standard blue
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 66,
              height: 66,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Center(
                child: const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
            // Circular progress indicator (customizable with the progress parameter)
            SizedBox(
              width: 70,
              height: 70,
              child: CircularProgressIndicator(
                value: progress,  // Updated to use the progress value passed in
                backgroundColor: Colors.transparent,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green), // Changed to a standard green color
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
