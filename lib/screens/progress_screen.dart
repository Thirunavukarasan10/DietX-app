import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loading_screen.dart';

class ProgressScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ProgressScreen({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  String _selectedProgress = 'Relaxed'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CircleAvatar(
                  backgroundColor: const Color(0xFFEEEEEE),
                  radius: 24,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Title
              Text(
                'Choose the progress?',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 6),
              
              Text(
                'We will use this data to give you a better diet type for you',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 40),

              // Progress Options
              _buildProgressOption(
                title: 'Power up',
                difficulty: 'Hard',
                weeks: '4 weeks',
                gain: '+3Kg/week',
                isSelected: _selectedProgress == 'Power up',
                onTap: () {
                  setState(() {
                    _selectedProgress = 'Power up';
                  });
                },
              ),

              const SizedBox(height: 16),

              _buildProgressOption(
                title: 'Steady',
                difficulty: 'Medium',
                weeks: '8 weeks',
                gain: '+1.5Kg/week',
                isSelected: _selectedProgress == 'Steady',
                onTap: () {
                  setState(() {
                    _selectedProgress = 'Steady';
                  });
                },
              ),

              const SizedBox(height: 16),

              _buildProgressOption(
                title: 'Relaxed',
                difficulty: 'Easy',
                weeks: '16 weeks',
                gain: '+0.75Kg/week',
                isSelected: _selectedProgress == 'Relaxed',
                onTap: () {
                  setState(() {
                    _selectedProgress = 'Relaxed';
                  });
                },
              ),

              // Spacer to push the button to the bottom
              const Spacer(),

              // Done Button
              Container(
                width: double.infinity,
                height: 56,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: const Color(0xFFA7DBA2),
                ),
                child: InkWell(
                  onTap: () {
                    // Add progress to user data
                    final updatedUserData = {
                      ...widget.userData,
                      'progress': _selectedProgress,
                    };
                    
                    // Navigate to loading screen
                    Get.to(() => LoadingScreen(userData: updatedUserData));
                  },
                  borderRadius: BorderRadius.circular(28),
                  child: Center(
                    child: Text(
                      'Done',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressOption({
    required String title,
    required String difficulty,
    required String weeks,
    required String gain,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final Color difficultyColor = difficulty == 'Hard'
        ? Colors.red
        : difficulty == 'Medium'
            ? Colors.amber
            : Colors.green;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD1F4C1) : const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  difficulty,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: difficultyColor,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  weeks,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const Spacer(),
                Text(
                  gain,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}