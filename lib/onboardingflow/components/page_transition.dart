import 'package:flutter/material.dart';

/// A custom page route that provides various transition animations
class PageTransition extends PageRouteBuilder {
  final Widget child;
  final TransitionType type;
  final Curve curve;
  final Alignment alignment;
  final Duration duration;

  PageTransition({
    required this.child,
    this.type = TransitionType.fade,
    this.curve = Curves.easeInOut,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) : super(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            switch (type) {
              case TransitionType.fade:
                return FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
                  child: child,
                );

              case TransitionType.rightToLeft:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(curvedAnimation),
                  child: child,
                );

              case TransitionType.leftToRight:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  ).animate(curvedAnimation),
                  child: child,
                );

              case TransitionType.topToBottom:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, -1),
                    end: Offset.zero,
                  ).animate(curvedAnimation),
                  child: child,
                );

              case TransitionType.bottomToTop:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(curvedAnimation),
                  child: child,
                );

              case TransitionType.scale:
                return ScaleTransition(
                  alignment: alignment,
                  scale: Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(curvedAnimation),
                  child: child,
                );

              case TransitionType.rotate:
                return RotationTransition(
                  turns: Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(curvedAnimation),
                  child: child,
                );

              case TransitionType.fadeAndScale:
                return FadeTransition(
                  opacity: Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(curvedAnimation),
                  child: ScaleTransition(
                    scale: Tween<double>(
                      begin: 0.8,
                      end: 1.0,
                    ).animate(curvedAnimation),
                    child: child,
                  ),
                );

              default:
                return FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
                  child: child,
                );
            }
          },
        );
}

/// Enum representing different transition types
enum TransitionType {
  fade,
  rightToLeft,
  leftToRight,
  topToBottom,
  bottomToTop,
  scale,
  rotate,
  fadeAndScale,
} 