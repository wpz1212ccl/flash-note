import 'package:flutter/material.dart';

class SpringAnimation extends StatefulWidget {
  final Widget child;
  final bool trigger;
  final Offset beginOffset;
  final Offset endOffset;
  final double beginScale;
  final double endScale;
  final Duration duration;

  const SpringAnimation({
    super.key,
    required this.child,
    this.trigger = true,
    this.beginOffset = const Offset(0, 20),
    this.endOffset = Offset.zero,
    this.beginScale = 0.95,
    this.endScale = 1.0,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<SpringAnimation> createState() => _SpringAnimationState();
}

class _SpringAnimationState extends State<SpringAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offset;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _offset = Tween(begin: widget.beginOffset, end: widget.endOffset)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _scale = Tween(begin: widget.beginScale, end: widget.endScale)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    if (widget.trigger) _controller.forward();
  }

  @override
  void didUpdateWidget(SpringAnimation old) {
    super.didUpdateWidget(old);
    if (widget.trigger && !old.trigger) {
      _controller.forward(from: 0);
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
        return Transform.translate(
          offset: _offset.value,
          child: Transform.scale(scale: _scale.value, child: child),
        );
      },
      child: widget.child,
    );
  }
}
