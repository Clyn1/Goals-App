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

// Colors inspired by the travel app UI design in 4183095.jpg
final Color salmonRed = const Color(0xFFFF7366);
final Color deepBlue = const Color(0xFF2C3E50);
final Color skyBlue = const Color(0xFF3498DB);

final List<OnboardingData> onboardingScreens = [
  OnboardingData(
    title: 'Set Smart Goals',
    description: 'Create specific, measurable goals with deadlines and track your daily progress toward achieving them.',
    icon: Icons.track_changes_rounded,
    backgroundColor: salmonRed,
    buttonText: 'Next',
  ),
  OnboardingData(
    title: 'Build Better Habits',
    description: 'Turn your aspirations into daily habits with reminders, streaks, and visual progress tracking.',
    icon: Iconsax.calendar_tick,
    backgroundColor: deepBlue,
    buttonText: 'Next',
  ),
  OnboardingData(
    title: 'Stay Motivated',
    description: 'Celebrate milestones, earn achievements, and stay accountable with friends to reach your potential.',
    icon: Icons.emoji_events_rounded,
    backgroundColor: skyBlue,
    buttonText: 'Get Started',
  ),
]; 