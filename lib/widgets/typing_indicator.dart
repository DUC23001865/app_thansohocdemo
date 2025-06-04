import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
          milliseconds: 1200), // Thời gian cho một chu kỳ animation
      vsync: this,
    )..repeat(); // Lặp lại animation

    _animation = TweenSequence<double>([
      TweenSequenceItem<double>(tween: Tween(begin: 0.0, end: 1.0), weight: 30),
      TweenSequenceItem<double>(tween: Tween(begin: 1.0, end: 0.0), weight: 30),
      TweenSequenceItem<double>(
          tween: Tween(begin: 0.0, end: 0.0), weight: 40), // Giữ ở 0 một lúc
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(double opacity) {
    return Container(
      width: 6,
      height: 6,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white
            .withOpacity(opacity), // Màu trắng với độ trong suốt thay đổi
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Dot 1 delayed
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            // Slight delay for the first dot
            final delayedOpacity = _animation.value <= 0.4
                ? _animation.value / 0.4 // Animate in faster
                : _animation.value <= 0.8
                    ? 1.0
                    : (_animation.value - 0.8) / 0.2; // Fade out faster
            final adjustedOpacity = _animation.value >= 0.6
                ? (1.0 - _animation.value) / 0.4
                : _animation.value / 0.6; // Simple fade in/out across 60% cycle
            return _buildDot(adjustedOpacity);
          },
        ),
        // Dot 2 delayed further
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final delayedValue =
                (_controller.value + 0.2) % 1.0; // Delay by 20% of cycle
            final opacity = delayedValue >= 0.6
                ? (1.0 - delayedValue) / 0.4
                : delayedValue / 0.6; // Simple fade in/out across 60% cycle
            return _buildDot(opacity);
          },
        ),
        // Dot 3 delayed even further
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final delayedValue =
                (_controller.value + 0.4) % 1.0; // Delay by 40% of cycle
            final opacity = delayedValue >= 0.6
                ? (1.0 - delayedValue) / 0.4
                : delayedValue / 0.6; // Simple fade in/out across 60% cycle
            return _buildDot(opacity);
          },
        ),
      ],
    );
  }
}
