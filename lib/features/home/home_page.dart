import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../data/database/app_database.dart';
import '../../providers/entry_providers.dart';
import '../../providers/settings_providers.dart';
import '../../shared/extensions/context_extensions.dart';
import '../search/search_delegate.dart';
import 'enums/view_mode.dart';
import 'widgets/timeline_header.dart';
import 'widgets/timeline_card.dart';
import 'widgets/grid_card.dart';
import 'widgets/empty_state.dart';
import 'widgets/fab_button.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();
  String? _selectedTag;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewMode = ref.watch(viewModeProvider);
    final entriesAsync = _selectedTag == null
        ? ref.watch(allEntriesProvider)
        : ref.watch(entriesByTagProvider(_selectedTag!));

    final isDark = context.isDarkMode;
    final bgColor = isDark ? AppColors.darkBg : AppColors.warmWhite;
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.surface;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            entriesAsync.when(
              data: (entries) => CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    expandedHeight: 140,
                    pinned: true,
                    collapsedHeight: 60,
                    backgroundColor: bgColor,
                    surfaceTintColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      background: TimelineHeader(
                        date: DateTime.now(),
                        viewMode: viewMode,
                        onToggleView: () {
                          ref.read(viewModeProvider.notifier).setViewMode(
                            viewMode == ViewMode.timeline ? ViewMode.grid : ViewMode.timeline,
                          );
                        },
                        onSearch: () {
                          showSearch(
                            context: context,
                            delegate: FlashNoteSearchDelegate(
                              searchProvider: (query) => ref.read(searchResultsProvider(query).future),
                            ),
                          );
                        },
                      ),
                      collapseMode: CollapseMode.parallax,
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _TagRowDelegate(
                      selectedTag: _selectedTag,
                      onTagSelected: (tag) => setState(() => _selectedTag = tag),
                      isDark: isDark,
                      surfaceColor: surfaceColor,
                    ),
                  ),
                  if (entries.isEmpty)
                    const SliverFillRemaining(child: EmptyState())
                  else if (viewMode == ViewMode.grid)
                    _buildGridView(entries)
                  else
                    _buildTimelineView(entries, isDark),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('加载失败: $err')),
            ),
            Positioned(
              right: AppSpacing.lg,
              bottom: AppSpacing.lg,
              child: FabButton(
                scrollController: _scrollController,
                onPressed: () => Navigator.of(context).pushNamed('/capture'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridView(List<Entry> entries) {
    return SliverPadding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => RepaintBoundary(child: GridCard(entry: entries[index])),
          childCount: entries.length,
        ),
      ),
    );
  }

  Widget _buildTimelineView(List<Entry> entries, bool isDark) {
    final grouped = _groupByDate(entries);
    final items = <Widget>[];
    for (final day in grouped.entries) {
      for (final entry in day.value) {
        items.add(TimelineCard(entry: entry));
      }
      // Add spacer between day groups
      items.add(const SizedBox(height: AppSpacing.md));
    }
    if (items.isNotEmpty) items.removeLast(); // Remove trailing spacer

    return SliverPadding(
      padding: const EdgeInsets.only(top: AppSpacing.md, bottom: 80),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => RepaintBoundary(child: items[index]),
          childCount: items.length,
        ),
      ),
    );
  }

  Map<DateTime, List<Entry>> _groupByDate(List<Entry> entries) {
    final map = <DateTime, List<Entry>>{};
    for (final entry in entries) {
      final date = DateTime(entry.createdAt.year, entry.createdAt.month, entry.createdAt.day);
      map.putIfAbsent(date, () => []).add(entry);
    }
    return map;
  }
}

class _TagRowDelegate extends SliverPersistentHeaderDelegate {
  final String? selectedTag;
  final void Function(String?) onTagSelected;
  final bool isDark;
  final Color surfaceColor;

  _TagRowDelegate({
    required this.selectedTag,
    required this.onTagSelected,
    required this.isDark,
    required this.surfaceColor,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: surfaceColor,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      child: Row(
        children: [
          _TagDot(
            color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
            isSelected: selectedTag == null,
            isAll: true,
            onTap: () => onTagSelected(null),
          ),
          const SizedBox(width: AppSpacing.md),
          ...AppColors.tagColors.map((color) => Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: _TagDot(
              color: color,
              isSelected: _colorToHex(color) == selectedTag,
              onTap: () => onTagSelected(_colorToHex(color)),
            ),
          )),
        ],
      ),
    );
  }

  String _colorToHex(Color c) => c.toARGB32().toRadixString(16).padLeft(8, '0');

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant _TagRowDelegate oldDelegate) =>
      selectedTag != oldDelegate.selectedTag || isDark != oldDelegate.isDark;
}

class _TagDot extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final bool isAll;
  final VoidCallback onTap;

  const _TagDot({
    required this.color,
    required this.isSelected,
    this.isAll = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isSelected ? 28 : 20,
        height: isSelected ? 28 : 20,
        decoration: BoxDecoration(
          color: isAll ? null : color,
          shape: BoxShape.circle,
          border: isAll
              ? Border.all(color: color, width: 1.5)
              : isSelected
                  ? Border.all(color: color.withAlpha(100), width: 3)
                  : null,
        ),
        child: isAll ? const Icon(Icons.all_inclusive_rounded, size: 12) : null,
      ),
    );
  }
}
