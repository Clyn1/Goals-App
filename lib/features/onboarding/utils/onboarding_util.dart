import 'package:goalsapp/features/onboarding/controllers/onboarding_controller.dart';
import 'package:goalsapp/features/onboarding/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class OnboardingUtil {
  // Check if onboarding is completed and return the appropriate screen
  static Future<Widget> checkOnboardingStatus({
    required Widget homeScreen,
  }) async {
    final controller = OnboardingController();
    final isOnboardingComplete = await controller.isOnboardingComplete();
    
    if (isOnboardingComplete) {
      return homeScreen;
    } else {
      return const OnboardingScreen();
    }
  }
} 