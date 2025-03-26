import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A component that creates smooth fade transitions for content elements
/// when navigating between onboarding screens.
class FadeTransitionContent extends StatefulWidget {
  final Widget child;
  final int pageIndex;
  final int currentPageIndex;
  final Duration inDuration;
  final Duration outDuration;
  final Duration delay;
  final Offset slideOffset;

  const FadeTransitionContent({
    super.key,
    required this.child,
    required this.pageIndex,
    required this.currentPageIndex,
    this.inDuration = const Duration(milliseconds: 600),
    this.outDuration = const Duration(milliseconds: 400),
    this.delay = const Duration(milliseconds: 100),
    this.slideOffset = const Offset(0, 30),
  });

  @override
  State<FadeTransitionContent> createState() => _FadeTransitionContentState();
}

class _FadeTransitionContentState extends State<FadeTransitionContent> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.inDuration,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: widget.slideOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    if (widget.pageIndex == widget.currentPageIndex) {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void didUpdateWidget(FadeTransitionContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Only animate if the visibility state changed
    if (widget.pageIndex == widget.currentPageIndex && 
        oldWidget.currentPageIndex != widget.currentPageIndex) {
      // We're now the active page - animate in
      _controller.forward(from: 0.0);
    } else if (widget.pageIndex != widget.currentPageIndex && 
              oldWidget.currentPageIndex == widget.pageIndex) {
      // We're no longer the active page - animate out
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: _slideAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
} 