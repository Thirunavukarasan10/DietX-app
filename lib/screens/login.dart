import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'survey_screen.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateForm);
    _passwordController.removeListener(_validateForm);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _emailController.text.isNotEmpty && 
                     _passwordController.text.isNotEmpty &&
                     _isValidEmail(_emailController.text) &&
                     _passwordController.text.length >= 6;
    });
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
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

                // Welcome back text
                Text(
                  'Welcome back',
                  style: GoogleFonts.dancingScript(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 48),

                // Email field
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(12),
                    border: _emailController.text.isNotEmpty && !_isValidEmail(_emailController.text)
                        ? Border.all(color: Colors.red, width: 1.0)
                        : null,
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Poppins',
                      ),
                      errorStyle: TextStyle(height: 0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      if (!_isValidEmail(value)) {
                        return '';
                      }
                      return null;
                    },
                  ),
                ),
                if (_emailController.text.isNotEmpty && !_isValidEmail(_emailController.text))
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                    child: Text(
                      'Please enter a valid email',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),

                const SizedBox(height: 16),

                // Password field
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(12),
                    border: _passwordController.text.isNotEmpty && _passwordController.text.length < 6
                        ? Border.all(color: Colors.red, width: 1.0)
                        : null,
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Poppins',
                      ),
                      errorStyle: TextStyle(height: 0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      if (value.length < 6) {
                        return '';
                      }
                      return null;
                    },
                  ),
                ),
                if (_passwordController.text.isNotEmpty && _passwordController.text.length < 6)
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                    child: Text(
                      'Password must be at least 6 characters',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),

                // Forget password text
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Implement forgot password functionality
                      Get.snackbar(
                        'Reset Password',
                        'Password reset link sent to your email',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Color(0xFFA7DBA2),
                        colorText: Colors.black,
                      );
                    },
                    child: const Text(
                      'Forget password ?',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Login button
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: _isFormValid 
                        ? const Color(0xFFA7DBA2) 
                        : const Color(0xFFD8D8D8),
                  ),
                  child: InkWell(
                    onTap: _isFormValid
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              // Navigate to SurveyScreen with required parameter
                              Get.to(() => SurveyScreen(
                                    onNameSubmitted: (name) {
                                      print("Name submitted: $name");
                                    },
                                  ));
                            }
                          }
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(
                            Icons.arrow_forward, 
                            color: _isFormValid ? Colors.black : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account ? ",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.off(() => const Signup());
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}