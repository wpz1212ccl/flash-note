import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../providers/database_provider.dart';
import '../../../../services/export_service.dart';
import '../../../../shared/extensions/context_extensions.dart';

class ExportSection extends ConsumerWidget {
  const ExportSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.isDarkMode;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    final options = [
      ('JSON 格式', Icons.code_rounded, '完整数据，可导入', ExportFormat.json),
      ('Markdown 格式', Icons.article_outlined, '可读性好，适合笔记软件', ExportFormat.markdown),
      ('纯文本', Icons.text_snippet_outlined, '最简洁，通用兼容', ExportFormat.text),
    ];

    return Column(
      children: options.map((opt) {
        return ListTile(
          leading: Icon(opt.$2, color: secondaryColor),
          title: Text(opt.$1),
          subtitle: Text(opt.$3, style: TextStyle(fontSize: 12, color: secondaryColor)),
          trailing: const Icon(Icons.download_outlined, size: 18),
          onTap: () async {
            final db = ref.read(appDatabaseProvider);
            final exportService = ExportService(db.entryDao, db.reminderDao);

            String path;
            switch (opt.$4) {
              case ExportFormat.json:
                path = await exportService.exportAsJson();
              case ExportFormat.markdown:
                path = await exportService.exportAsMarkdown();
              case ExportFormat.text:
                path = await exportService.exportAsText();
            }

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('已导出到: $path'), duration: const Duration(seconds: 3)),
              );
            }
          },
        );
      }).toList(),
    );
  }
}

enum ExportFormat { json, markdown, text }
