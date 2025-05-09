import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math'; // For min function

class ResultsScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ResultsScreen({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract data from userData
    final String name = userData['name'] ?? 'User';
    final int currentWeight = userData['currentWeight'] ?? 70;
    final int targetWeight = userData['targetWeight'] ?? 65;
    final double height = userData['height'] ?? 175.0;
    final String goal = userData['goal'] ?? 'Stay healthy';

    // Calculate BMI
    final double bmi = currentWeight / ((height / 100) * (height / 100));
    String bmiCategory = _getBMICategory(bmi);

    // Calculate weeks to goal
    final int weightDifference = (targetWeight - currentWeight).abs();
    final int weeksToGoal =
        (weightDifference / 0.5).ceil(); // Assuming 0.5kg per week
    final DateTime goalDate =
        DateTime.now().add(Duration(days: weeksToGoal * 7));
    final String goalDateStr =
        "${goalDate.day} ${_getMonth(goalDate.month)} ${goalDate.year}";

    // Calculate calories and macros
    final int dailyCalories = _calculateCalories(
        currentWeight,
        height,
        userData['gender'] ?? 'Male',
        userData['age'] ?? 30,
        userData['activityLevel'] ?? 'Moderate');

    // Calculate macros in grams
    final int carbsGrams =
        ((dailyCalories * 0.5) / 4).round(); // 4 calories per gram of carbs
    final int proteinGrams =
        ((dailyCalories * 0.2) / 4).round(); // 4 calories per gram of protein
    final int fatGrams =
        ((dailyCalories * 0.3) / 9).round(); // 9 calories per gram of fat

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section with graph
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF8FFEA),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Your personal program is ready',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    // Improved and more attractive weight progress graph
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3389FF),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  '$currentWeight kg',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF222222),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  '$targetWeight kg',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 120,
                            child: CustomPaint(
                              size: const Size(double.infinity, 120),
                              painter: AttractiveGraphPainter(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Today',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                goalDateStr,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF7FF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '$weeksToGoal weeks · ${_getWeeklyRate(currentWeight, targetWeight)} kg/week',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Calories Section (separate box)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3389FF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.local_fire_department,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$dailyCalories kcal',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Daily calories',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Nutritional Recommendations Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Nutritional Recommendations',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Macros with exact gram amounts
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // Carbs
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.grain,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Carbs',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildProgressBar(
                                          50, Colors.red[400]!),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '$carbsGrams g',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Protein
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.green[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.egg_alt,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Protein',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildProgressBar(
                                          20, Colors.green[400]!),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '$proteinGrams g',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Fat
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.amber[700],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.opacity,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fat',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildProgressBar(
                                          30, Colors.amber[700]!),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '$fatGrams g',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Water
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.water_drop,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Water',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildProgressBar(
                                          80, Colors.blue[400]!),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${_calculateWaterIntake(currentWeight)} ml',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // BMI Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BMI (Body Mass Index)',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bmi.toStringAsFixed(1),
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: _getBMIColor(bmi),
                                ),
                              ),
                              Text(
                                bmiCategory,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: _getBMIColor(bmi),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 200,
                            child: _buildBMIScale(bmi),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Program Recommendations - Matching the design in the second image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00656B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How to reach your goal',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Do these 4 activities',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Activities Grid - 2x2 with turquoise color from the second image
                      Row(
                        children: [
                          Expanded(
                            child: _buildActivityCard(
                              icon: '🥗',
                              title: 'Track your food',
                              color: const Color(0xFF61C0BF),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildActivityCard(
                              icon: '',
                              title: 'Do Workouts',
                              color: const Color(0xFF61C0BF),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildActivityCard(
                              icon: '🚰',
                              title: 'Stay hydrated',
                              color: const Color(0xFF61C0BF),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildActivityCard(
                              icon: '⚖️',
                              title: 'Update your weight',
                              color: const Color(0xFF61C0BF),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Explore Home Button - Matching the green button in the second image
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CD964),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Explore Home',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard({
    required String icon,
    required String title,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            icon,
            style: const TextStyle(
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double percentage, Color color) {
    return Container(
      height: 8,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: percentage / 100,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildBMIScale(double bmi) {
    return Container(
      height: 16,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [
            Colors.blue,
            Colors.green,
            Colors.yellow,
            Colors.orange,
            Colors.red,
          ],
        ),
      ),
      child: Stack(
        children: [
          // BMI marker
          Positioned(
            left: _getBMIPosition(bmi) * 200,
            top: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to position BMI marker
  double _getBMIPosition(double bmi) {
    if (bmi < 18.5) {
      return bmi / 40; // Underweight zone (0-0.46)
    } else if (bmi < 25) {
      return 0.25 + ((bmi - 18.5) / 26); // Normal zone (0.46-0.6)
    } else if (bmi < 30) {
      return 0.6 + ((bmi - 25) / 25); // Overweight zone (0.6-0.8)
    } else {
      return min(0.8 + ((bmi - 30) / 50), 0.95); // Obese zone (0.8-1.0)
    }
  }

  Color _getBMIColor(double bmi) {
    if (bmi < 18.5) {
      return Colors.blue;
    } else if (bmi < 25) {
      return Colors.green;
    } else if (bmi < 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 25) {
      return 'Normal weight';
    } else if (bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  // Helper function to calculate calories based on user data
  int _calculateCalories(
      int weight, double height, String gender, int age, String activityLevel) {
    double bmr = 0;
    if (gender == 'Male') {
      bmr = 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      bmr = 10 * weight + 6.25 * height - 5 * age - 161;
    }

    // Apply activity multiplier
    double activityMultiplier = 1.2; // Sedentary
    switch (activityLevel) {
      case 'Light':
        activityMultiplier = 1.375;
        break;
      case 'Moderate':
        activityMultiplier = 1.55;
        break;
      case 'Active':
        activityMultiplier = 1.725;
        break;
      case 'Very Active':
        activityMultiplier = 1.9;
        break;
    }

    return (bmr * activityMultiplier).round();
  }

  // Helper function to calculate water intake
  int _calculateWaterIntake(int weight) {
    // Standard calculation: 30ml per kg of body weight
    return (weight * 30).round();
  }

  // Helper function to get weight change per week
  String _getWeeklyRate(int currentWeight, int targetWeight) {
    if (currentWeight > targetWeight) {
      return '-0.5'; // Weight loss
    } else if (currentWeight < targetWeight) {
      return '+0.5'; // Weight gain
    } else {
      return '0.0'; // Maintain weight
    }
  }

  String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}

// New attractive graph painter for more visually appealing chart
// New attractive graph painter for more visually appealing chart
class AttractiveGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create gradient for filling under the curve
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFFFFE082).withOpacity(0.5),
        const Color(0xFFFFCC80).withOpacity(0.1),
      ],
    );

    // Main curve paint
    final curvePaint = Paint()
      ..color = const Color(0xFFFFB300)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // Glow effect
    final glowPaint = Paint()
      ..color = const Color(0xFFFFB300).withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    // Fill paint
    final fillPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    // Create path for the curve
    final path = Path();
    path.moveTo(0, size.height * 0.8);

    // More professional looking curve with multiple control points
    path.cubicTo(
      size.width * 0.2,
      size.height * 0.75,
      size.width * 0.4,
      size.height * 0.4,
      size.width * 0.6,
      size.height * 0.3,
    );

    path.cubicTo(
      size.width * 0.75,
      size.height * 0.2,
      size.width * 0.9,
      size.height * 0.15,
      size.width,
      size.height * 0.1,
    );

    // Create fill path
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    // Draw in order: fill, glow, main curve
    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, curvePaint);

    // Draw markers
    final dotPaint = Paint()
      ..color = const Color(0xFFFFB300)
      ..style = PaintingStyle.fill;

    final dotStrokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Start dot
    canvas.drawCircle(Offset(0, size.height * 0.8), 8, dotPaint);
    canvas.drawCircle(Offset(0, size.height * 0.8), 8, dotStrokePaint);

    // End dot
    canvas.drawCircle(Offset(size.width, size.height * 0.1), 8, dotPaint);
    canvas.drawCircle(Offset(size.width, size.height * 0.1), 8, dotStrokePaint);

    // Add intermediate points with decorative dots
    final points = [
      Offset(size.width * 0.25, size.height * 0.6),
      Offset(size.width * 0.5, size.height * 0.35),
      Offset(size.width * 0.75, size.height * 0.2),
    ];

    for (final point in points) {
      canvas.drawCircle(point, 4, Paint()..color = Colors.white);
      canvas.drawCircle(point, 3, Paint()..color = const Color(0xFFFFB300));
    }

    // Add decorative dashed horizontal lines
    final dashedLinePaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw 3 horizontal dashed lines
    for (int i = 1; i <= 3; i++) {
      double y = size.height * i / 4;
      double dashWidth = 5;
      double dashSpace = 3;
      double startX = 0;

      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, y),
          Offset(startX + dashWidth, y),
          dashedLinePaint,
        );
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
