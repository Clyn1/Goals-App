import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/onboarding_data.dart';
import '../widgets/common/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void _navigateToNextPage() {
    if (_currentPageIndex < onboardingScreens.length - 1) {
      _pageController.animateToPage(
        _currentPageIndex + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _navigateBack() {
    if (_currentPageIndex > 0) {
      _pageController.animateToPage(
        _currentPageIndex - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _completeOnboarding() {
    // Simple completion - staying on the last page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Onboarding completed! 🎉'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use ClampingScrollPhysics to prevent overscroll bounce but allow swiping
    const ScrollPhysics scrollPhysics = ClampingScrollPhysics();
    
    return Scaffold(
      body: Container(
        // This container will fill any gaps with a dark color
        color: const Color(0xFF2D3142), // Dark background color
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          physics: scrollPhysics,
          itemCount: onboardingScreens.length,
          itemBuilder: (context, index) {
            final screen = onboardingScreens[index];
            final isLastPage = index == onboardingScreens.length - 1;
            
            return OnboardingPage(
              currentIndex: _currentPageIndex,
              totalPages: onboardingScreens.length,
              backgroundColor: screen.backgroundColor,
              icon: screen.icon,
              title: screen.title,
              description: screen.description,
              buttonText: isLastPage ? 'Get Started' : 'Continue',
              showSkipButton: !isLastPage,
              onButtonPressed: _navigateToNextPage,
              onSkip: _completeOnboarding,
              onBackPressed: _navigateBack,
            );
          },
        ),
      ),
    );
  }
}

