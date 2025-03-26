import 'package:flutter/material.dart';
import 'package:chiclet/chiclet.dart';
import 'package:goalsapp/features/onboarding/widgets/common/onboarding_progress.dart';
import 'package:goalsapp/features/onboarding/widgets/common/bounce_button.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color backgroundColor;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final bool showSkipButton;
  final VoidCallback? onSkip;
  final int currentIndex;
  final int totalPages;
  final VoidCallback? onBackPressed;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.backgroundColor,
    required this.buttonText,
    required this.onButtonPressed,
    this.showSkipButton = true,
    this.onSkip,
    this.currentIndex = 0,
    this.totalPages = 3,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundColor == const Color(0xFFF5E6CA)
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF5E6CA), // Cream
                  Color(0xFFEDD9B4), // Darker cream
                ],
              )
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  backgroundColor,
                  backgroundColor.withOpacity(0.8),
                ],
              ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App title
              const Text(
                'GOALIFY',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 1.5,
                ),
              ),
              
              // Skip button
              if (showSkipButton && onSkip != null)
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: onSkip,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              
              // Main content area
              Expanded(
                child: Center(
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon
                          Container(
                            height: 160,
                            width: 160,
                            decoration: BoxDecoration(
                              color: backgroundColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              icon,
                              size: 80,
                              color: backgroundColor == const Color(0xFFF5E6CA) 
                                  ? const Color(0xFF5B4B8A) // Dark purple for cream background
                                  : backgroundColor,
                            ),
                          ),
                          
                          const SizedBox(height: 30),
                          
                          // Title
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3142),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Description
                          Text(
                            description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF9C9EB9),
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Progress indicator
              if (totalPages > 1)
                Center(
                  child: OnboardingProgress(
                    currentStep: currentIndex + 1,
                    totalSteps: totalPages,
                    activeColor: const Color(0xFFFFC107), // Gold/Amber dots
                    inactiveColor: Colors.white,
                  ),
                ),
              
              const SizedBox(height: 24),
              
              // Button at the bottom
              Stack(
                alignment: Alignment.center,
                children: [
                  // Main continue/get started button (always centered)
                  Center(
                    child: BounceButton(
                      onPressed: onButtonPressed,
                      backgroundColor: Colors.white,
                      buttonColor: Colors.grey.shade300,
                      foregroundColor: backgroundColor == const Color(0xFFF5E6CA) 
                          ? const Color(0xFF5B4B8A) // Dark purple for cream background
                          : backgroundColor,
                      height: 56,
                      width: 200,
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  
                  // Back button - only show if not on first page and onBackPressed is provided
                  if (currentIndex > 0 && onBackPressed != null)
                    Positioned(
                      left: 0,
                      child: BounceButton(
                        onPressed: () => onBackPressed!(),
                        backgroundColor: Colors.white,
                        buttonColor: Colors.grey.shade300,
                        foregroundColor: backgroundColor == const Color(0xFFF5E6CA) 
                            ? const Color(0xFF5B4B8A) 
                            : backgroundColor,
                        height: 56,
                        width: 56,
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          size: 24,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 