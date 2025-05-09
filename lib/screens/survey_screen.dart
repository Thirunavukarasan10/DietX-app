import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'progress_screen.dart'; // Import the ProgressScreen

class SurveyScreen extends StatefulWidget {
  final Function(String) onNameSubmitted;
  
  const SurveyScreen({
    Key? key,
    required this.onNameSubmitted,
  }) : super(key: key);

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedGoal = 'Lose weight';
  String _selectedGender = 'Male';
  DateTime _selectedDate = DateTime.now().subtract(const Duration(days: 365 * 20));
  double _heightCm = 175;
  int _currentWeight = 70;
  int _targetWeight = 65;
  
  final List<String> _goals = ['Lose weight', 'Gain weight', 'Stay healthy'];
  final List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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

                const SizedBox(height: 16),

                // Page title
                Text(
                  'Health Profile',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  'Complete your details for a personalized experience',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 24),

                // Progress indicator
                Container(
                  width: double.infinity,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: const Color(0xFFA7DBA2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // 1. Name Section
                _buildSectionTitle('What is your name?', 
                  'We will use this to personalize your experience'),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // 2. Goal Section
                _buildSectionTitle('What is your goal?', 
                  'We will customize your plan based on your goal'),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _goals.map((goal) => _buildSelectionChip(
                    text: goal,
                    isSelected: _selectedGoal == goal,
                    onTap: () {
                      setState(() {
                        _selectedGoal = goal;
                      });
                    },
                  )).toList(),
                ),
                
                const SizedBox(height: 30),
                
                // 3. Gender Section
                _buildSectionTitle('What is your gender?', 
                  'This helps us calculate accurate metrics for you'),
                Wrap(
                  spacing: 10,
                  children: _genders.map((gender) => _buildSelectionChip(
                    text: gender,
                    isSelected: _selectedGender == gender,
                    onTap: () {
                      setState(() {
                        _selectedGender = gender;
                      });
                    },
                  )).toList(),
                ),
                
                const SizedBox(height: 30),
                
                // 4. Date of Birth Section
                _buildSectionTitle('Your date of birth?', 
                  'This helps us determine appropriate health recommendations'),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('MMMM d, yyyy').format(_selectedDate),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const Icon(Icons.calendar_today, color: Colors.black54),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // 5. Height Section
                _buildSectionTitle('How tall are you?', 
                  'Your height is important for calculating health metrics'),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA7DBA2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              '${_heightCm.toStringAsFixed(0)} cm',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          width: 120,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F0F0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              '${(_heightCm / 30.48).toStringAsFixed(1)} ft',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const Color(0xFFA7DBA2),
                        inactiveTrackColor: const Color(0xFFF0F0F0),
                        thumbColor: const Color(0xFFA7DBA2),
                        overlayColor: const Color(0x29A7DBA2),
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
                      ),
                      child: Slider(
                        value: _heightCm,
                        min: 120,
                        max: 220,
                        onChanged: (value) {
                          setState(() {
                            _heightCm = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 30),
                
                // 6. Current Weight Section
                _buildSectionTitle('Your current weight?', 
                  'This helps us track your progress'),
                _buildWeightSelector(
                  value: _currentWeight,
                  onDecrease: () {
                    setState(() {
                      if (_currentWeight > 30) _currentWeight--;
                    });
                  },
                  onIncrease: () {
                    setState(() {
                      if (_currentWeight < 200) _currentWeight++;
                    });
                  },
                  unit: 'kg',
                ),
                
                const SizedBox(height: 30),
                
                // 7. Target Weight Section
                _buildSectionTitle('Your target weight?', 
                  'Let us know what goal you\'re aiming for'),
                _buildWeightSelector(
                  value: _targetWeight,
                  onDecrease: () {
                    setState(() {
                      if (_targetWeight > 30) _targetWeight--;
                    });
                  },
                  onIncrease: () {
                    setState(() {
                      if (_targetWeight < 200) _targetWeight++;
                    });
                  },
                  unit: 'kg',
                ),
                
                const SizedBox(height: 40),
                
                // Submit Button
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFFA7DBA2),
                  ),
                  child: InkWell(
                    onTap: () {
                      _submitData();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.arrow_forward, color: Colors.black),
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
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSelectionChip({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFA7DBA2) : const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.black : Colors.black54,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildWeightSelector({
    required int value,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
    required String unit,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onDecrease,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.remove, color: Colors.black54),
          ),
        ),
        Container(
          width: 140,
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFA7DBA2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: onIncrease,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.add, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFA7DBA2),
              onPrimary: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitData() {
    // First pass the name back via the callback
    widget.onNameSubmitted(_nameController.text);
    
    // Create a data model from the collected information
    final userData = {
      'name': _nameController.text,
      'goal': _selectedGoal,
      'gender': _selectedGender,
      'dateOfBirth': _selectedDate.toIso8601String(),
      'height': _heightCm,
      'currentWeight': _currentWeight,
      'targetWeight': _targetWeight,
    };
    
    // Instead of showing a dialog, navigate directly to the ProgressScreen
    Get.to(() => ProgressScreen(userData: userData));
  }
}