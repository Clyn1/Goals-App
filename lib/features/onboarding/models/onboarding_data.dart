import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color backgroundColor;
  final String buttonText;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.backgroundColor,
    required this.buttonText,
  });
}

// Warm color scheme
final Color sunsetOrange = const Color(0xFFFF7E5F);  // Warm orange
final Color coralRed = const Color(0xFFE95F5C);      // Coral red
final Color creamColor = const Color(0xFFF5E6CA);    // Warm cream

final List<OnboardingData> onboardingScreens = [
  OnboardingData(
    title: 'Set Smart Goals',
    description: 'Create specific, measurable goals with deadlines and track your daily progress toward achieving them.',
    icon: Icons.track_changes_rounded,
    backgroundColor: sunsetOrange,
    buttonText: 'Next',
  ),
  OnboardingData(
    title: 'Build Better Habits',
    description: 'Turn your aspirations into daily habits with reminders, streaks, and visual progress tracking.',
    icon: Iconsax.calendar_tick,
    backgroundColor: coralRed,
    buttonText: 'Next',
  ),
  OnboardingData(
    title: 'Stay Motivated',
    description: 'Celebrate milestones, earn achievements, and stay accountable with friends to reach your potential.',
    icon: Icons.emoji_events_rounded,
    backgroundColor: creamColor,
    buttonText: 'Get Started',
  ),
]; 