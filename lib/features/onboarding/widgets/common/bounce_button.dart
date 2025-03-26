import 'package:flutter/material.dart';
import 'package:chiclet/chiclet.dart';

class BounceButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color buttonColor;
  final Color foregroundColor;
  final double height;
  final double width;

  const BounceButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.white,
    this.buttonColor = Colors.grey,
    this.foregroundColor = Colors.blue,
    this.height = 56,
    this.width = 200,
  }) : super(key: key);

  @override
  State<BounceButton> createState() => _BounceButtonState();
}

class _BounceButtonState extends State<BounceButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: ChicletAnimatedButton(
          onPressed: widget.onPressed,
          backgroundColor: widget.backgroundColor,
          buttonColor: widget.buttonColor,
          foregroundColor: widget.foregroundColor,
          height: widget.height,
          width: widget.width,
          child: widget.child,
        ),
      ),
    );
  }
} 