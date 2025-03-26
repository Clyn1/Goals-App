import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController {
  final PageController pageController = PageController();
  
  // Used to track if onboarding is completed
  Future<void> setOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
  }
  
  // Check if onboarding is already completed
  Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingComplete') ?? false;
  }
  
  // Navigate to the next page
  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  
  // Skip to the last page
  void skipToEnd(int lastPageIndex) {
    pageController.animateToPage(
      lastPageIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
  
  // Dispose the controller when not needed
  void dispose() {
    pageController.dispose();
  }
} 