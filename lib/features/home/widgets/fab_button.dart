import 'package:flutter/material.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/utils/haptic_feedback.dart';

class FabButton extends StatefulWidget {
  final VoidCallback onPressed;
  final ScrollController scrollController;

  const FabButton({
    super.key,
    required this.onPressed,
    required this.scrollController,
  });

  @override
  State<FabButton> createState() => _FabButtonState();
}

class _FabButtonState extends State<FabButton> with SingleTickerProviderStateMixin {
  late AnimationController _hideController;
  late Animation<double> _scaleAnim;
  late Animation<double> _offsetAnim;
  late Animation<double> _opacityAnim;
  bool _isVisible = true;
  double _lastScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _hideController = AnimationController(
      vsync: this,
      duration: AppDurations.normal,
    );
    _scaleAnim = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _hideController, curve: Curves.easeInOut),
    );
    _offsetAnim = Tween(begin: 0.0, end: 80.0).animate(
      CurvedAnimation(parent: _hideController, curve: Curves.easeInOut),
    );
    _opacityAnim = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _hideController, curve: Curves.easeInOut),
    );

    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = widget.scrollController.offset;
    if (offset > _lastScrollOffset && offset > 100 && _isVisible) {
      _isVisible = false;
      _hideController.forward();
    } else if (offset < _lastScrollOffset && !_isVisible) {
      _isVisible = true;
      _hideController.reverse();
    }
    _lastScrollOffset = offset;
  }

  @override
  void dispose() {
    _hideController.dispose();
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: _hideController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _offsetAnim.value),
          child: Transform.scale(
            scale: _scaleAnim.value,
            child: Opacity(
              opacity: _opacityAnim.value,
              child: child,
            ),
          ),
        );
      },
      child: GestureDetector(
        onTapDown: (_) => HapticHelper.medium(),
        onTap: widget.onPressed,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: accentColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: accentColor.withAlpha(77),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}
