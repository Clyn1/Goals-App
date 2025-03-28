import 'package:flutter/material.dart';
import '../../models/onboarding_data.dart';
import '../../components/onboarding_page.dart';
import '../auth/auth_screen.dart';

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
    // Navigate to AuthScreen instead of popping
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
  
  bool _handleDragEnd(DragEndDetails details) {
    final double dragDistance = _dragUpdateX - _dragStartX;
    
    // Detect swipe direction and navigate accordingly if it exceeds threshold
    if (dragDistance.abs() >= _swipeThreshold) {
      // Prevent swiping left (forward) on the last page
      if (dragDistance < 0 && _currentPageIndex == onboardingScreens.length - 1) {
        return true; // Cancel the swipe
      }
      
      // Prevent swiping right (backward) on the first page
      if (dragDistance > 0 && _currentPageIndex == 0) {
        return true; // Cancel the swipe
      }
      
      if (dragDistance > 0) {
        // Swiped right - go back
        _navigateBack();
        return true; // We handled the swipe
      } else {
        // Swiped left - go forward
        _navigateToNextPage();
        return true; // We handled the swipe
      }
    }
    return false; // Let the PageView handle the swipe
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: (details) {
          if (!_handleDragEnd(details)) {
            // If our handler returns false, let the default behavior happen
            // This allows minor swipes that don't exceed threshold to be handled by PageView
          }
        },
        child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF2D3142),
        ),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            // Disable the glow effect when overscrolling
            overscroll.disallowIndicator();
            return true;
          },
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            physics: const ClampingScrollPhysics(), // Prevent bouncing
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
      ),
    ),
    );
  }
} 