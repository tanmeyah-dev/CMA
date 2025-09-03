import 'package:flutter/material.dart';

// Global animation replacements that can be imported anywhere in the project
// These replace the missing simple_animations package functionality

// Simple fade-in animation widget
class FadeIn extends StatefulWidget {
  final Widget child;
  final dynamic delay; // Accept both Duration and double
  final SlideFrom? from;

  const FadeIn({
    Key? key,
    required this.child,
    this.delay,
    this.from,
  }) : super(key: key);

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    // Convert delay to Duration if it's a double
    Duration delayDuration = Duration.zero;
    if (widget.delay is double) {
      delayDuration = Duration(milliseconds: (widget.delay * 1000).round());
    } else if (widget.delay is Duration) {
      delayDuration = widget.delay;
    }

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Set up slide animation based on direction
    Offset beginOffset = Offset.zero;
    if (widget.from != null) {
      switch (widget.from!) {
        case SlideFrom.TOP:
          beginOffset = const Offset(0, -0.3);
          break;
        case SlideFrom.BOTTOM:
          beginOffset = const Offset(0, 0.3);
          break;
        case SlideFrom.LEFT:
          beginOffset = const Offset(-0.3, 0);
          break;
        case SlideFrom.RIGHT:
          beginOffset = const Offset(0.3, 0);
          break;
      }
    }

    _slideAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    // Start animation after delay
    Future.delayed(delayDuration, () {
      if (mounted) {
        _controller.forward();
      }
    });
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
        return Transform.translate(
          offset: _slideAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

// Enum for slide directions
enum SlideFrom {
  TOP,
  BOTTOM,
  LEFT,
  RIGHT,
}


