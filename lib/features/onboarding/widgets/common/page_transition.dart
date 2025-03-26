import 'package:flutter/material.dart';

class FadeScalePageTransition extends StatelessWidget {
  final Widget child;
  final PageController controller;
  final int index;
  final int currentIndex;

  const FadeScalePageTransition({
    Key? key,
    required this.child,
    required this.controller,
    required this.index,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Listen to page offset changes for animation calculations
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        // Safely handle empty positions or when page is null
        if (controller.positions.isEmpty || !controller.position.hasContentDimensions) {
          return this.child;
        }
        
        // Safely get the page value or default to the index
        final double page = controller.page ?? index.toDouble();
        final double pageOffset = page - index;
        final bool isLeaving = pageOffset.abs() > 0.5;
        final bool isForward = pageOffset > 0;
        final bool isBackward = pageOffset < 0;
        
        // Scale and opacity transformations
        double scale = 1.0;
        double opacity = 1.0;
        
        // Apply different animations based on direction and page position
        if (isBackward) {
          // Coming in from left side
          if (pageOffset.abs() <= 1.0) {
            // Page is coming into view
            scale = 0.8 + (0.2 * (1 - pageOffset.abs()));
            opacity = 0.5 + (0.5 * (1 - pageOffset.abs()));
          }
        } else if (isForward) {
          // Going out to left side
          if (pageOffset <= 1.0) {
            // Page is leaving view
            scale = 1.0 - (0.1 * pageOffset);
            opacity = 1.0 - (0.5 * pageOffset);
          }
        }
        
        // Apply transforms to child
        return Opacity(
          opacity: opacity,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..scale(scale, scale),
            child: this.child,
          ),
        );
      },
      child: child,
    );
  }
}

// A more elaborate 3D page flip transition
class FlipPageTransition extends StatelessWidget {
  final Widget child;
  final PageController controller;
  final int index;

  const FlipPageTransition({
    Key? key,
    required this.child,
    required this.controller,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        // Safely handle empty positions or when page is null
        if (controller.positions.isEmpty || !controller.position.hasContentDimensions) {
          return this.child;
        }
        
        // Safely get the page value or default to the index
        final double page = controller.page ?? index.toDouble();
        final double pageOffset = page - index;
        final isPreviousPage = pageOffset > 0;
        final isNextPage = pageOffset < 0;
        
        // The percentage to transform by
        final double transformPercent = pageOffset.abs().clamp(0.0, 1.0);
        
        // Flip less aggressively (only 75 degrees instead of 90)
        final double rotationY = isPreviousPage
            ? transformPercent * -0.75 * 3.1415927 // Convert to radians
            : transformPercent * 0.75 * 3.1415927;
        
        // Add perspective effect
        final Matrix4 transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001) // perspective
          ..rotateY(rotationY);
        
        // Add depth (z-translation) based on flip direction
        double z = isPreviousPage 
            ? -transformPercent * 200
            : transformPercent * 200;
        transform.translate(0.0, 0.0, z);
        
        // Adjust opacity for a fade effect during transition
        double opacity = 1.0;
        if (transformPercent > 0.5) {
          opacity = (1.0 - transformPercent) * 2.0; // Fade out second half
        }
        
        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Transform(
            alignment: isPreviousPage ? Alignment.centerRight : Alignment.centerLeft,
            transform: transform,
            child: this.child,
          ),
        );
      },
    );
  }
}

// A professional slide-and-scale transition
class SlideScaleTransition extends StatelessWidget {
  final Widget child;
  final PageController controller;
  final int index;

  const SlideScaleTransition({
    Key? key,
    required this.child,
    required this.controller,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        // Safely handle empty positions or when page is null
        if (controller.positions.isEmpty || !controller.position.hasContentDimensions) {
          return this.child;
        }

        // Safely get the page value or default to the index
        final double page = controller.page ?? index.toDouble();
        final double pageOffset = page - index;
        final double absPageOffset = pageOffset.abs();
        
        // Calculate position and scale
        double yTranslation = 0.0;
        double scale = 1.0;
        
        // Current page moving out or next page coming in
        if (absPageOffset < 1.0) {
          // Current page scaling down and moving up slightly as it exits
          // Next page scaling up and moving up from bottom
          final bool isLeaving = pageOffset > 0;
          
          if (isLeaving) {
            // Current page leaving
            scale = 1.0 - (absPageOffset * 0.2);
            yTranslation = -30.0 * absPageOffset;
          } else {
            // Next page coming in
            scale = 0.8 + (absPageOffset * 0.2);
            yTranslation = 30.0 * (1 - absPageOffset);
          }
        }
        
        // Apply the transformation
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..translate(0.0, yTranslation)
            ..scale(scale, scale),
          child: this.child,
        );
      },
    );
  }
}

// A simpler, more reliable fade transition
class SimpleFadeTransition extends StatelessWidget {
  final Widget child;
  final PageController controller;
  final int index;

  const SimpleFadeTransition({
    Key? key,
    required this.child,
    required this.controller,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        // Initial case - just show the widget without animation
        if (controller.positions.isEmpty || !controller.position.hasContentDimensions) {
          return child;
        }
        
        final double page = controller.page ?? index.toDouble();
        final double pageOffset = (page - index).abs();
        
        // Simple cross-fade effect
        final double opacity = 1.0 - (pageOffset.clamp(0.0, 0.8) * 1.25);
        
        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: child,
        );
      },
    );
  }
}

// A simple horizontal slide transition with no scaling
class SimpleSlideTransition extends StatelessWidget {
  final Widget child;
  final PageController controller;
  final int index;

  const SimpleSlideTransition({
    Key? key,
    required this.child,
    required this.controller,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        // Initial case - just show the widget without animation
        if (controller.positions.isEmpty || !controller.position.hasContentDimensions) {
          return child;
        }
        
        final double page = controller.page ?? index.toDouble();
        final double pageOffset = page - index;
        final Size size = MediaQuery.of(context).size;
        
        // Calculate the horizontal offset based on swipe direction
        // Use a dampened effect (only move 30% of screen width)
        final double xOffset = pageOffset * size.width * 0.3;
        
        return Transform.translate(
          offset: Offset(xOffset, 0),
          child: child,
        );
      },
    );
  }
}

// A premium transition that combines slide and fade
class PremiumTransition extends StatelessWidget {
  final Widget child;
  final PageController controller;
  final int index;

  const PremiumTransition({
    Key? key,
    required this.child,
    required this.controller,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        // Initial case - just show the widget without animation
        if (controller.positions.isEmpty || !controller.position.hasContentDimensions) {
          return child;
        }
        
        final double page = controller.page ?? index.toDouble();
        final double pageOffset = page - index;
        final Size size = MediaQuery.of(context).size;
        
        // Direction-aware effects
        final bool isLeaving = pageOffset > 0;
        final bool isEntering = pageOffset < 0;
        final double absOffset = pageOffset.abs();
        
        // Calculate opacity based on direction
        double opacity = 1.0;
        if (isLeaving) {
          // Fading out slower (stays visible longer while sliding away)
          opacity = 1.0 - (absOffset * 0.7);
        } else if (isEntering) {
          // Fading in faster (appears quickly while sliding in)
          opacity = 0.3 + (absOffset * 0.7);
        }
        
        // Calculate slide offset with direction
        double slideMultiplier = isLeaving ? 1.0 : -1.0;
        // Apply xOffset with dampening (only 40% of screen width)
        double xOffset = slideMultiplier * absOffset * size.width * 0.4;
        
        // Add a very subtle scaling effect (barely noticeable)
        double scale = 1.0;
        if (isLeaving) {
          // Very subtle shrink as it leaves (max 2% smaller)
          scale = 1.0 - (absOffset * 0.02);
        } else if (isEntering) {
          // Very subtle grow as it enters (starts 2% smaller)
          scale = 0.98 + (absOffset * 0.02);
        }
        
        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..translate(xOffset, 0.0)
              ..scale(scale, scale),
            child: child,
          ),
        );
      },
    );
  }
} 