import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

class EmptyState extends StatefulWidget {
  const EmptyState({super.key});

  @override
  State<EmptyState> createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    _floatAnim = Tween(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final secondaryColor = context.isDarkMode ? AppColors.darkTextSecondary : AppColors.textSecondary;

    return Center(
      child: AnimatedBuilder(
        animation: _floatAnim,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, -_floatAnim.value),
            child: child,
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              size: const Size(80, 80),
              painter: _EmptyPainter(context.isDarkMode),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text(
              '灵感来了？\n点击 + 开始记录',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge(secondaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyPainter extends CustomPainter {
  final bool isDark;
  _EmptyPainter(this.isDark);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Pen body
    canvas.drawLine(Offset(cx - 10, cy + 25), Offset(cx - 10, cy - 15), paint);
    // Pen tip
    final tipPath = Path()
      ..moveTo(cx - 18, cy - 15)
      ..lineTo(cx - 10, cy - 30)
      ..lineTo(cx - 2, cy - 15)
      ..close();
    canvas.drawPath(tipPath, paint);

    // Lines flying off
    paint.strokeWidth = 1.5;
    canvas.drawArc(const Rect.fromLTWH(0, 0, 0, 0), 0, 0, false, paint);
    // Arc lines
    canvas.drawLine(Offset(cx + 10, cy + 15), Offset(cx + 30, cy + 5), paint);
    canvas.drawLine(Offset(cx + 10, cy + 22), Offset(cx + 30, cy + 18), paint);
    canvas.drawLine(Offset(cx + 10, cy + 29), Offset(cx + 25, cy + 32), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
