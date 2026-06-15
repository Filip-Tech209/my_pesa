// text_styles.dart
import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle h1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  static final TextStyle h2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.3,
  );

  static final TextStyle h3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );
}