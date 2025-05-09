import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _numberController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _nameController.removeListener(_validateForm);
    _numberController.removeListener(_validateForm);
    _emailController.removeListener(_validateForm);
    _passwordController.removeListener(_validateForm);
    _nameController.dispose();
    _numberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _nameController.text.isNotEmpty &&
                    _numberController.text.isNotEmpty &&
                    _isValidPhone(_numberController.text) &&
                    _emailController.text.isNotEmpty &&
                    _isValidEmail(_emailController.text) &&
                    _passwordController.text.length >= 6;
    });
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^\d{10}$').hasMatch(phone);
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFEEEEEE),
                      radius: 24,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Sign up text
                  Text(
                    'Sign up',
                    style: GoogleFonts.dancingScript(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Name field with validation
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(12),
                      border: _nameController.text.isEmpty && _formSubmitted
                          ? Border.all(color: Colors.red, width: 1.0)
                          : null,
                    ),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter name',
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
                        return null;
                      },
                    ),
                  ),
                  if (_nameController.text.isEmpty && _formSubmitted)
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                      child: Text(
                        'Name is required',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Number field with validation
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(12),
                      border: _numberController.text.isNotEmpty && !_isValidPhone(_numberController.text)
                          ? Border.all(color: Colors.red, width: 1.0)
                          : null,
                    ),
                    child: TextFormField(
                      controller: _numberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Enter number (10 digits)',
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
                        if (!_isValidPhone(value)) {
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                  if (_numberController.text.isNotEmpty && !_isValidPhone(_numberController.text))
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                      child: Text(
                        'Please enter a valid 10-digit number',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Email field with validation
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(12),
                      border: _emailController.text.isNotEmpty && !_isValidEmail(_emailController.text)
                          ? Border.all(color: Colors.red, width: 1.0)
                          : null,
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter email',
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

                  // Password field with validation
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(12),
                      border: _passwordController.text.isNotEmpty && _passwordController.text.length < 6
                          ? Border.all(color: Colors.red, width: 1.0)
                          : null,
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter password (min. 6 characters)',
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

                  const SizedBox(height: 48),

                  // Create Account button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: _isFormValid 
                          ? Color(0xFFA7DBA2) 
                          : Color(0xFFD8D8D8),
                    ),
                    child: InkWell(
                      onTap: _isFormValid
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                // Show success message before navigating
                                Get.snackbar(
                                  'Account Created',
                                  'Your account has been created successfully!',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Color(0xFFA7DBA2),
                                  colorText: Colors.black,
                                  duration: Duration(seconds: 2),
                                );
                                
                                // Delayed navigation to login screen
                                Future.delayed(Duration(seconds: 2), () {
                                  Get.off(() => LoginScreen());
                                });
                              } else {
                                setState(() {
                                  _formSubmitted = true;
                                });
                              }
                            }
                          : null,
                      child: Center(
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: _isFormValid ? Colors.black : Colors.grey,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account ? ",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.off(() => LoginScreen());
                        },
                        child: Text(
                          'Login',
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
      ),
    );
  }

  bool _formSubmitted = false;
}