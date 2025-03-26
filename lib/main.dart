import 'package:flutter/material.dart';
import 'package:goalsapp/common/theme/app_theme.dart';
import 'package:goalsapp/features/onboarding/screens/onboarding_screen.dart';

void main() {
  runApp(const GoalsApp());
}

class GoalsApp extends StatelessWidget {
  const GoalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goalify',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(context),
      home: const OnboardingScreen(),
    );
  }
}

