import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

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
    title: 'Meet Your Pet Companion',
    description: 'Choose from adorable pets that grow and evolve as you achieve your goals. Your companion will encourage and celebrate with you every step of the way!',
    icon: Symbols.pets_rounded,
    backgroundColor: sunsetOrange,
    buttonText: 'Next',
  ),
  OnboardingData(
    title: 'Create Meaningful Goals',
    description: 'Set daily, weekly or long-term goals with customizable categories, reminders, and milestones. Break larger goals into manageable sub-tasks.',
    icon: Iconsax.task_square,
    backgroundColor: coralRed,
    buttonText: 'Next',
  ),
  OnboardingData(
    title: 'Grow Together',
    description: 'Watch your pet evolve through five stages as you complete goals. Unlock new abilities, customize your pet, and create a beautiful habitat for your companion.',
    icon: FontAwesomeIcons.seedling,
    backgroundColor: creamColor,
    buttonText: 'Get Started',
  ),
]; 