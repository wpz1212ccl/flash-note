import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/utils/haptic_feedback.dart';
import '../../providers/entry_providers.dart';
import '../../providers/reminder_providers.dart';
import '../../shared/extensions/context_extensions.dart';
import 'widgets/tag_selector.dart';
import 'widgets/reminder_picker.dart';

class CapturePage extends ConsumerStatefulWidget {
  final String? entryId;

  const CapturePage({super.key, this.entryId});

  @override
  ConsumerState<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends ConsumerState<CapturePage> {
  final TextEditingController _controller = TextEditingController();
  int? _selectedTagIndex;
  DateTime? _reminderTime;
  bool _isSaving = false;

  bool get isEditMode => widget.entryId != null;

  @override
  void initState() {
    super.initState();
    if (isEditMode) {
      _loadEntry();
    }
  }

  Future<void> _loadEntry() async {
    final entry = await ref.read(singleEntryProvider(widget.entryId!).future);
    if (entry != null && mounted) {
      _controller.text = entry.content;
      if (entry.tag != null && entry.color != null) {
        final colorHex = entry.color!;
        final idx = predefinedTags.indexWhere((t) =>
            t.color.toARGB32().toRadixString(16).padLeft(8, '0') == colorHex);
        if (idx >= 0) _selectedTagIndex = idx;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    if (_isSaving) return;
    _isSaving = true;

    try {
      final entryRepo = ref.read(entryRepositoryProvider);
      String? tagName;
      String? tagColor;

      if (_selectedTagIndex != null) {
        tagName = predefinedTags[_selectedTagIndex!].name;
        tagColor = predefinedTags[_selectedTagIndex!].color.toARGB32().toRadixString(16).padLeft(8, '0');
      }

      if (isEditMode) {
        await entryRepo.updateEntryContent(widget.entryId!, content, null);
      } else {
        await entryRepo.createEntry(content: content, tag: tagName, color: tagColor);
      }

      if (_reminderTime != null && !isEditMode) {
        final reminderRepo = ref.read(reminderRepositoryProvider);
        await reminderRepo.createReminder(content: content, dueTime: _reminderTime!);
      }

      if (mounted) Navigator.pop(context, true);
    } finally {
      _isSaving = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final bgColor = isDark ? AppColors.darkBg : AppColors.warmWhite;
    final textColor = isDark ? AppColors.lightCream : AppColors.warmBlack;
    final accentColor = Theme.of(context).colorScheme.primary;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _save().then((_) => Navigator.pop(context));
      },
      child: Scaffold(
        backgroundColor: bgColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              _buildTopBar(accentColor),
              const SizedBox(height: AppSpacing.md),
              TagSelector(
                selectedIndex: _selectedTagIndex,
                onTagSelected: (index, tag) {
                  HapticHelper.light();
                  setState(() => _selectedTagIndex = index);
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(child: _buildInputArea(textColor)),
              _buildToolbar(accentColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(Color accentColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => _save().then((_) => Navigator.pop(context)),
              child: const Icon(Icons.arrow_back_ios_rounded, size: 20),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => _save().then((_) => Navigator.pop(context)),
              child: Text('保存', style: TextStyle(color: accentColor, fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
      child: TextField(
        controller: _controller,
        autofocus: true,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: AppTextStyles.bodyLarge(textColor),
        cursorColor: AppColors.apricot,
        decoration: const InputDecoration.collapsed(hintText: ''),
      ),
    );
  }

  Widget _buildToolbar(Color accentColor) {
    final isDark = context.isDarkMode;
    final dividerColor = isDark ? AppColors.darkDivider : AppColors.divider;

    return Container(
      height: 48 + context.bottomPadding,
      padding: EdgeInsets.only(bottom: context.bottomPadding),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: dividerColor, width: 0.5)),
      ),
      child: Row(
        children: [
          const SizedBox(width: AppSpacing.xxl),
          // Reminder button
          GestureDetector(
            onTap: () async {
              final time = await ReminderPicker.show(context);
              if (time != null) setState(() => _reminderTime = time);
            },
            child: Icon(
              _reminderTime != null ? Icons.access_time : Icons.access_time_outlined,
              color: _reminderTime != null ? accentColor : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
              size: 22,
            ),
          ),
          const Spacer(),
          if (isEditMode)
            PopupMenuButton<String>(
              icon: Icon(Icons.more_horiz, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
              onSelected: (value) {
                if (value == 'delete') {
                  _confirmDelete();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'delete', child: Text('删除', style: TextStyle(color: AppColors.danger))),
              ],
            ),
          const SizedBox(width: AppSpacing.lg),
        ],
      ),
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认'),
        content: const Text('确定删除这条记录吗？'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusLg)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('取消', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(entryRepositoryProvider).deleteEntry(widget.entryId!);
              if (context.mounted) {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // close page
              }
            },
            child: const Text('删除', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
  }
}
