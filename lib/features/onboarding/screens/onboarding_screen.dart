import 'package:flutter/material.dart';
import '../models/onboarding_data.dart';
import '../widgets/common/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

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
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _navigateBack() {
    if (_currentPageIndex > 0) {
      _pageController.animateToPage(
        _currentPageIndex - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF2D3142),
        ),
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          physics: const ClampingScrollPhysics(),
          itemCount: onboardingScreens.length,
          pageSnapping: true,
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

