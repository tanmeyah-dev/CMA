import 'package:flutter/material.dart';

// Simple replacement for FadeIn that uses only standard Flutter widgets
class SimpleFadeIn extends StatefulWidget {
  final Widget child;
  final dynamic delay; // Accept both Duration and double
  final String? direction; // "TOP", "BOTTOM", "LEFT", "RIGHT"

  const SimpleFadeIn({
    Key? key,
    required this.child,
    this.delay,
    this.direction,
  }) : super(key: key);

  @override
  State<SimpleFadeIn> createState() => _SimpleFadeInState();
}

class _SimpleFadeInState extends State<SimpleFadeIn> with SingleTickerProviderStateMixin {
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
    if (widget.direction != null) {
      switch (widget.direction!.toUpperCase()) {
        case "TOP":
          beginOffset = const Offset(0, -0.3);
          break;
        case "BOTTOM":
          beginOffset = const Offset(0, 0.3);
          break;
        case "LEFT":
          beginOffset = const Offset(-0.3, 0);
          break;
        case "RIGHT":
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


