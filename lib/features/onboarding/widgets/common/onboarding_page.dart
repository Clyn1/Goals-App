import 'package:flutter/material.dart';
import 'package:chiclet/chiclet.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color backgroundColor;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final bool showSkipButton;
  final VoidCallback? onSkip;

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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon with animation
                      Icon(
                        icon,
                        size: 120,
                        color: Colors.white.withOpacity(0.9),
                      ).animate()
                        .fadeIn(duration: 600.ms)
                        .scale(delay: 300.ms),
                      
                      const SizedBox(height: 40),
                      
                      // Title with animation
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ).animate()
                        .fadeIn(delay: 300.ms)
                        .moveY(begin: 20, end: 0, delay: 300.ms, duration: 600.ms),
                      
                      const SizedBox(height: 16),
                      
                      // Description with animation
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                      ).animate()
                        .fadeIn(delay: 500.ms)
                        .moveY(begin: 20, end: 0, delay: 500.ms, duration: 600.ms),
                    ],
                  ),
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
            ],
          ),
        ),
      ),
    );
  }
} 