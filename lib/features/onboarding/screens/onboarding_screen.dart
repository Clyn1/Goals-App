import 'package:flutter/material.dart';
import 'package:goalsapp/features/onboarding/controllers/onboarding_controller.dart';
import 'package:goalsapp/features/onboarding/models/onboarding_data.dart';
import 'package:goalsapp/features/onboarding/widgets/common/onboarding_page.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:goalsapp/features/onboarding/widgets/theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  final OnboardingController _controller = OnboardingController();
  int _currentPage = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    // Slight delay to improve visual experience
    Future.delayed(const Duration(milliseconds: 200), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _completeOnboarding() {
    // Save onboarding completion status
    _controller.setOnboardingComplete();
    
    // Show a simple completion message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Onboarding completed! 🎉'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Following best practice: immersive experience with animations
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Scaffold(
          body: Opacity(
            opacity: _animationController.value,
            child: PageView.builder(
              controller: _controller.pageController,
              itemCount: onboardingScreens.length,
              onPageChanged: _onPageChanged,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final screen = onboardingScreens[index];
                final isLastPage = index == onboardingScreens.length - 1;
                
                return OnboardingPage(
                  title: screen.title,
                  description: screen.description,
                  icon: screen.icon,
                  backgroundColor: screen.backgroundColor,
                  buttonText: screen.buttonText,
                  showSkipButton: !isLastPage,
                  onSkip: () => _controller.skipToEnd(onboardingScreens.length - 1),
                  onButtonPressed: isLastPage 
                    ? _completeOnboarding 
                    : _controller.nextPage,
                  currentIndex: index,
                  totalPages: onboardingScreens.length,
                );
              },
            ).animate().fadeIn(duration: 300.ms),
          ),
        );
      },
    );
  }
}

