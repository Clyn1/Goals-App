import 'package:flutter/material.dart';

class OnboardingProgress extends StatefulWidget {
  final int currentStep;
  final int totalSteps;
  final Color activeColor;
  final Color inactiveColor;
  
  const OnboardingProgress({
    super.key, 
    required this.currentStep, 
    required this.totalSteps,
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.white,
  });

  @override
  State<OnboardingProgress> createState() => _OnboardingProgressState();
}

class _OnboardingProgressState extends State<OnboardingProgress> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..forward();
  }
  
  @override
  void didUpdateWidget(OnboardingProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep) {
      _animationController.reset();
      _animationController.forward();
    }
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.totalSteps,
        (index) {
          final isActive = index < widget.currentStep;
          final isCurrent = index == widget.currentStep - 1;
          
          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              // Calculate dot width - current dot grows with elastic effect
              double dotWidth = 10.0;
              if (isCurrent) {
                final curvedAnimation = CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.elasticOut,
                );
                dotWidth = 10 + (10 * curvedAnimation.value);
              }
              
              // Calculate blur radius with animation
              double blurRadius = 0;
              if (isCurrent) {
                blurRadius = 4 + (2 * _animationController.value);
              }
              
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                height: 10,
                width: dotWidth,
                decoration: BoxDecoration(
                  color: isActive 
                      ? widget.activeColor 
                      : widget.inactiveColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isCurrent
                      ? [
                          BoxShadow(
                            color: widget.activeColor.withOpacity(0.5),
                            blurRadius: blurRadius,
                            spreadRadius: 1,
                          )
                        ] 
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
} 