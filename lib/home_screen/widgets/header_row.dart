import 'package:flutter/material.dart';
import 'package:my_pesa/login_screen.dart';
import 'package:my_pesa/main.dart';
import 'package:my_pesa/models/data_model.dart';
import 'package:my_pesa/text_styles.dart';
import 'package:my_pesa/theme.dart';



Widget HeaderRow(BuildContext context, UserAccount account) {

  String getGreeting(String timeString) {
    try {
      // 1. Handle empty or null strings
      if (timeString.isEmpty || timeString == "N/A" || timeString == "0") {
        return 'Hello,'; // Fallback greeting
      }

      // 2. Parse safely
      final DateTime now = DateTime.parse(timeString);
      final int hour = now.hour;

      if (hour < 12) {
        return 'Good Morning,';
      } else if (hour < 17) {
        return 'Good Afternoon,';
      } else {
        return 'Good Evening,';
      }
    } catch (e) {
      // 3. If parsing fails (e.g. invalid date format), return a neutral greeting
      return 'Welcome,'; 
    }
  }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final String greeting = getGreeting(account.currentTime);

  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Signed In', style: AppTextStyles.h3),
          content: const Text('You can continue to explore the app or signout at any time.'),
          actions: [
            ElevatedButton(
              onPressed: () { Navigator.pop(context); },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor, 
                padding: const EdgeInsets.symmetric(
                  horizontal:32,
                  vertical: 16,
                ),
                 shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )
              ),
              child: Text(
                'Stay',
                style: AppTextStyles.labelSmall.copyWith(
                  color: Colors.white
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, 
                padding: const EdgeInsets.symmetric(
                  horizontal:32,
                  vertical: 16,
                ),
                 shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )
              ),
              child: Text(
                'Sign Out',
                style: AppTextStyles.labelSmall.copyWith(
                  color: Colors.white
                ),
              ),
            ),
            
          ],
        );
      },
    );
  }
  return Container(
    padding: const EdgeInsets.all(16.0), // Adds space inside the card
    margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0), // Adds space outside
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(16), // Slightly rounded for a modern look
      boxShadow: [
        BoxShadow(
          color: isDark
              ? Colors.black.withOpacity(0.2)
              : Colors.grey.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primaryBlue,
          backgroundImage: const AssetImage('assets/images/avatar.jpg'),
        ),
        const SizedBox(width: 16), // Increased spacing between avatar and text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting, 
                style: AppTextStyles.labelMedium.copyWith(
                  fontSize: 14, 
                  color: isDark ? Colors.white : Colors.grey[600]
                )
              ),
              const SizedBox(height: 2),
              Text(
                account.username, 
                style: AppTextStyles.h3.copyWith(
                  fontSize: 20, 
                  fontWeight: FontWeight.w600
                )
              ),
            ],
          ),
        ),
        // Theme Switcher & Logout
        IconButton(
          icon: Icon(
            isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined, 
            color: isDark ? Colors.white : Theme.of(context).primaryColor,
          ),
          onPressed: () {
            themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
          },
        ),
        IconButton(
          icon: Icon(Icons.person_2_outlined, color: isDark ? Colors.white : Theme.of(context).primaryColor),
          onPressed: showLogoutDialog,
        ),
      ],
    ),
  );
}

