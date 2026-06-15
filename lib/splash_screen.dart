import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:my_pesa/controllers/auth_controllers.dart';
import 'package:my_pesa/login_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final AuthController authController =Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    ///navigate Based on auth state after 2.5 seconds
    Future.delayed(const Duration(milliseconds:2500), (){
      if(authController.isFirstTime){
          Get.off(()=> LoginScreen());
      }else if(authController.isLoggedIn){
          Get.off(()=> LoginScreen());
      }else{
          Get.off(()=> LoginScreen());
      }
    });

    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
              Theme.of(context).primaryColor.withOpacity(0.6),
            ],
          ),
        ),
        child: Stack(
          children: [
            // 1. Background pattern
            Positioned.fill(
              child: Opacity(
                opacity: 0.05,
                child: GridPattern(
                  color: Colors.white,
                ),
              ),
            ),

            // 2. Main content centered
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1200),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/logos/my-pesa-logo.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.contain,
                            // Tint the image to new blue if a pure white logo vanishes against the white circle
                            // color: Theme.of(context).primaryColor,
                            colorBlendMode: BlendMode.srcIn, 
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),

                  /// Animated text
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1200),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: const Column(
                      children: [
                        Text(
                          "Simple& Secure",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            letterSpacing:1,
                          ),
                        ),
                        // Text(
                        //   "SOLUTION",
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 32,
                        //     fontWeight: FontWeight.w600,
                        //     letterSpacing: 1,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 3. Bottom tagline
            Positioned(
              bottom: 48,
              left: 0,
              right: 0,
              child: FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  final version = snapshot.hasData 
                      ? "Version ${snapshot.data!.version}" 
                      : "Loading...";

                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1200),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: child,
                      );
                    },
                    child: Text(
                      version,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridPattern extends StatelessWidget {
  final Color color;
  const GridPattern({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(color: color),
    );
  }
}

class GridPainter extends CustomPainter {
  final Color color;
  GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;

    const spacing = 20.0;

    // Vertical lines
    for (var i = 0.0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    // Horizontal lines
    for (var i = 0.0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}