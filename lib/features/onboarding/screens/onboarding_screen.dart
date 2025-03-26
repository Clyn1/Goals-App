import 'package:flutter/material.dart';
import '../models/onboarding_data.dart';
import '../widgets/common/onboarding_page.dart';
import '../widgets/common/page_transition.dart';
import '../../auth/screens/auth_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  
  // Variables for tracking swipe gestures
  double _dragStartX = 0.0;
  double _dragUpdateX = 0.0;
  static const double _swipeThreshold = 100.0;

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
        duration: const Duration(milliseconds: 400),
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
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _completeOnboarding() {
    // Navigate to auth screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }
  
  // Handle swipe gestures
  void _onDragStart(DragStartDetails details) {
    _dragStartX = details.globalPosition.dx;
  }
  
  void _onDragUpdate(DragUpdateDetails details) {
    _dragUpdateX = details.globalPosition.dx;
  }
  
  void _onDragEnd(DragEndDetails details) {
    final double dragDistance = _dragUpdateX - _dragStartX;
    
    // Detect swipe direction and navigate accordingly if it exceeds threshold
    if (dragDistance.abs() >= _swipeThreshold) {
      if (dragDistance > 0) {
        // Swiped right - go back
        _navigateBack();
      } else {
        // Swiped left - go forward
        _navigateToNextPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF2D3142),
        ),
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
          itemCount: onboardingScreens.length,
          pageSnapping: true,
          itemBuilder: (context, index) {
            final screen = onboardingScreens[index];
            final isLastPage = index == onboardingScreens.length - 1;
            
              // No fancy transitions, just show the page directly
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
      ),
    );
  }
}

