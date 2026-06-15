import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pesa/controllers/auth_controllers.dart';
import 'package:my_pesa/home_screen/home_screen.dart';
import 'text_styles.dart';
import 'theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<String> _otpCode = [];
  final int _pinLength = 5;
  final AuthController authController = Get.find<AuthController>();

  void _onKeyPress(String value) {
    if (_otpCode.length < _pinLength) {
      setState(() => _otpCode.add(value));
    }
  }

  void _onBackspace() {
    if (_otpCode.isNotEmpty) {
      setState(() => _otpCode.removeLast());
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  void _handleLogin() {
    String inputPin = _otpCode.join();

    // Replace 'authController.userPin' with the variable name holding your stored password
    if (inputPin == "80528") { 
      Get.to(() => const MainLayoutWrapper());
    } else {
      _showErrorSnackBar("Incorrect PIN. Please try again.");
      setState(() {
        _otpCode.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('Welcome Back', style: AppTextStyles.h1),
                  const SizedBox(height: 8),
                  Text('Enter your 5-digit security access PIN', style: AppTextStyles.labelMedium),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pinLength, (index) {
                  bool isFilled = index < _otpCode.length;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isFilled
                          ? AppColors.primaryBlue
                          : (isDark ? Colors.grey[700] : Colors.grey[300]),
                    ),
                  );
                }),
              ),
              Column(
                children: [
                  for (var row in [['1', '2', '3'], ['4', '5', '6'], ['7', '8', '9']])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: row.map((val) => _buildNumButton(val)).toList(),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 80, height: 80),
                      _buildNumButton('0'),
                      _buildBackspaceButton(),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: _otpCode.length == _pinLength ? _handleLogin : null,
                child: Text('LOG IN', style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumButton(String value) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: 64,
      height: 64,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: const CircleBorder(),
          side: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
        onPressed: () => _onKeyPress(value),
        child: Text(value, style: AppTextStyles.h2),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return Container(
      margin: const EdgeInsets.all(8),
      width: 64,
      height: 64,
      child: IconButton(
        icon: const Icon(Icons.backspace_outlined, size: 24),
        onPressed: _onBackspace,
      ),
    );
  }
}