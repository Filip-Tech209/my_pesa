// main.dart
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_pesa/controllers/auth_controllers.dart';
import 'package:my_pesa/splash_screen.dart';
import 'theme.dart';


// Global state controller for theme toggling
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

Future<void> main() async {
  // 1. Initialize GetStorage (needed for your controller's _storage)
  await GetStorage.init();

  // 2. Register the controller so Get.find can locate it
  Get.put(AuthController());
  runApp(const BankingApp());
}

class BankingApp extends StatelessWidget {
  const BankingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return GetMaterialApp(
          title: 'Apex Bank',
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: currentMode,
          home: SplashScreen(),
        );
      },
    );
  }
}