import 'package:flutter/material.dart';
import 'package:chiclet/chiclet.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:goalsapp/features/onboarding/widgets/common/onboarding_progress.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
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
                      ),
                    ),
                  ),
                ),
              
              // Expanded space for center content
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
                          // Icon with animation
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
                              color: backgroundColor,
                            ),
                          ).animate()
                            .fadeIn(duration: 600.ms)
                            .scale(delay: 300.ms, curve: Curves.elasticOut),
                          
                          const SizedBox(height: 30),
                          
                          // Title with animation
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3142),
                            ),
                            textAlign: TextAlign.center,
                          ).animate()
                            .fadeIn(delay: 300.ms)
                            .moveY(begin: 20, end: 0, delay: 300.ms, duration: 600.ms),
                          
                          const SizedBox(height: 16),
                          
                          // Description with animation
                          Text(
                            description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF9C9EB9),
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ).animate()
                            .fadeIn(delay: 500.ms)
                            .moveY(begin: 20, end: 0, delay: 500.ms, duration: 600.ms),
                        ],
                      ),
                    ),
                  ).animate()
                    .fadeIn(duration: 800.ms)
                    .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.0, 1.0), curve: Curves.easeOutQuint),
                ),
              ),
              
              // Button at the bottom
              Align(
                alignment: Alignment.center,
                child: ChicletAnimatedButton(
                  onPressed: onButtonPressed,
                  backgroundColor: Colors.white,
                  buttonColor: Colors.grey.shade300,
                  foregroundColor: backgroundColor,
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
              
              const SizedBox(height: 30),
              
              // Progress indicator
              if (totalPages > 1)
                Center(
                  child: OnboardingProgress(
                    currentStep: currentIndex + 1,
                    totalSteps: totalPages,
                    activeColor: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
} 