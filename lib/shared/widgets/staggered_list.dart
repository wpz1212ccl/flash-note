import 'package:flutter/material.dart';

class StaggeredList extends StatefulWidget {
  final List<Widget> children;
  final Duration staggerDelay;
  final Duration duration;

  const StaggeredList({
    super.key,
    required this.children,
    this.staggerDelay = const Duration(milliseconds: 50),
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  State<StaggeredList> createState() => _StaggeredListState();
}

class _StaggeredListState extends State<StaggeredList>
    with SingleTickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _opacities;
  late final List<Animation<double>> _translations;

  @override
  void initState() {
    super.initState();
    _controllers = [];
    _opacities = [];
    _translations = [];
    for (var i = 0; i < widget.children.length; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: widget.duration,
      );
      _controllers.add(controller);
      _opacities.add(
        Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.6, curve: Curves.easeOutCubic),
          ),
        ),
      );
      _translations.add(
        Tween(begin: 20.0, end: 0.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.6, curve: Curves.easeOutCubic),
          ),
        ),
      );
    }
    _startAnimation();
  }

  void _startAnimation() {
    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(widget.staggerDelay * i, () {
        if (mounted) _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.children.length, (i) {
        return AnimatedBuilder(
          animation: _controllers[i],
          builder: (context, child) {
            return Opacity(
              opacity: _opacities[i].value,
              child: Transform.translate(
                offset: Offset(0, _translations[i].value),
                child: child,
              ),
            );
          },
          child: widget.children[i],
        );
      }),
    );
  }
}
