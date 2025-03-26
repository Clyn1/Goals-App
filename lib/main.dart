import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:goalsapp/features/onboarding/widgets/theme/app_theme.dart';
import 'package:goalsapp/features/onboarding/screens/onboarding_screen.dart';
import 'firebase_options.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
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

