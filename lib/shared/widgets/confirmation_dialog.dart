import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final Color confirmColor;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.message,
    this.title = '确认',
    this.confirmText = '确定',
    this.cancelText = '取消',
    this.confirmColor = AppColors.danger,
    required this.onConfirm,
  });

  static Future<bool?> show(
    BuildContext context, {
    required String message,
    String title = '确认',
    String confirmText = '确定',
    String cancelText = '取消',
    Color confirmColor = AppColors.danger,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        confirmColor: confirmColor,
        onConfirm: () => Navigator.pop(context, true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusLg)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelText, style: TextStyle(color: AppColors.textSecondary)),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(confirmText, style: TextStyle(color: confirmColor)),
        ),
      ],
    );
  }
}
