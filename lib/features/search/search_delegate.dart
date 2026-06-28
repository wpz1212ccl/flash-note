import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/utils/date_formatter.dart';
import '../../data/database/app_database.dart';
import '../../shared/extensions/context_extensions.dart';

class FlashNoteSearchDelegate extends SearchDelegate<Entry?> {
  final Future<List<Entry>> Function(String query) searchProvider;

  FlashNoteSearchDelegate({required this.searchProvider});

  @override
  String get searchFieldLabel => '搜索笔记...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: AppTextStyles.bodyMedium(AppColors.textSecondary),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults(context);

  Widget _buildSearchResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text(
          '输入关键词搜索',
          style: AppTextStyles.bodyMedium(context.isDarkMode ? AppColors.darkTextSecondary : AppColors.textSecondary),
        ),
      );
    }

    return FutureBuilder<List<Entry>>(
      future: searchProvider(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('搜索出错: ${snapshot.error}'));
        }
        final results = snapshot.data ?? [];
        if (results.isEmpty) {
          return Center(
            child: Text(
              '未找到相关笔记',
              style: AppTextStyles.bodyMedium(context.isDarkMode ? AppColors.darkTextSecondary : AppColors.textSecondary),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.lg),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final entry = results[index];
            final tagColor = entry.color != null ? Color(int.parse(entry.color!)) : AppColors.apricot;
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
              title: Text(
                entry.content.length > 60 ? '${entry.content.substring(0, 60)}...' : entry.content,
                style: AppTextStyles.bodyMedium(
                  context.isDarkMode ? AppColors.lightCream : AppColors.warmBlack,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                DateFormatter.cardTime(entry.createdAt),
                style: AppTextStyles.caption(context.isDarkMode ? AppColors.darkTextSecondary : AppColors.textSecondary),
              ),
              leading: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: tagColor, shape: BoxShape.circle),
              ),
              onTap: () {
                close(context, entry);
                Navigator.of(context).pushNamed('/detail/${entry.id}');
              },
            );
          },
        );
      },
    );
  }
}
