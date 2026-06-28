import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_durations.dart';
import '../../core/utils/haptic_feedback.dart';
import '../../providers/entry_providers.dart';
import '../../shared/extensions/context_extensions.dart';
import 'widgets/tag_selector.dart';

class OverlayController extends StateNotifier<bool> {
  OverlayController() : super(false);

  void show() => state = true;
  void hide() => state = false;
}

final overlayControllerProvider = StateNotifierProvider<OverlayController, bool>((ref) {
  return OverlayController();
});

class GlobalCaptureOverlay extends ConsumerStatefulWidget {
  final Widget child;

  const GlobalCaptureOverlay({super.key, required this.child});

  @override
  ConsumerState<GlobalCaptureOverlay> createState() => _GlobalCaptureOverlayState();
}

class _GlobalCaptureOverlayState extends ConsumerState<GlobalCaptureOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnim;
  late Animation<double> _fadeAnim;
  final TextEditingController _textController = TextEditingController();
  int? _selectedTagIndex;
  double _dragOffset = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.slow,
    );
    _slideAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    ref.listenManual(overlayControllerProvider, (prev, next) {
      if (next) {
        _controller.forward();
        _textController.clear();
        _selectedTagIndex = null;
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _saveAndClose() {
    final content = _textController.text.trim();
    if (content.isEmpty) {
      ref.read(overlayControllerProvider.notifier).hide();
      return;
    }

    String? tagName;
    String? tagColor;
    if (_selectedTagIndex != null) {
      tagName = predefinedTags[_selectedTagIndex!].name;
      tagColor = predefinedTags[_selectedTagIndex!].color.toARGB32().toRadixString(16).padLeft(8, '0');
    }

    ref.read(entryRepositoryProvider).createEntry(content: content, tag: tagName, color: tagColor);
    ref.read(overlayControllerProvider.notifier).hide();
  }

  @override
  Widget build(BuildContext context) {
    final isVisible = ref.watch(overlayControllerProvider);

    return Stack(
      children: [
        widget.child,
        if (isVisible || _controller.isAnimating)
          GestureDetector(
            onTap: () => ref.read(overlayControllerProvider.notifier).hide(),
            child: AnimatedBuilder(
              animation: _fadeAnim,
              builder: (context, child) {
                return Container(
                  color: Colors.black.withAlpha((77 * _fadeAnim.value).round()),
                );
              },
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: MediaQuery.of(context).size.height * 0.75,
          child: AnimatedBuilder(
            animation: _slideAnim,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, (1 - _slideAnim.value) * 600 + _dragOffset),
                child: child,
              );
            },
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  setState(() => _dragOffset += details.delta.dy);
                }
              },
              onVerticalDragEnd: (details) {
                if (_dragOffset > 100 || details.velocity.pixelsPerSecond.dy > 500) {
                  ref.read(overlayControllerProvider.notifier).hide();
                }
                setState(() => _dragOffset = 0);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: context.isDarkMode ? AppColors.darkSurface : AppColors.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(40),
                      blurRadius: 20,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: AppSpacing.sm),
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.textSecondary.withAlpha(80),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TagSelector(
                        selectedIndex: _selectedTagIndex,
                        onTagSelected: (index, tag) {
                          HapticHelper.light();
                          setState(() => _selectedTagIndex = index);
                        },
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                          child: TextField(
                            controller: _textController,
                            autofocus: true,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            style: TextStyle(
                              fontSize: 18,
                              color: context.isDarkMode ? AppColors.lightCream : AppColors.warmBlack,
                            ),
                            cursorColor: AppColors.apricot,
                            decoration: const InputDecoration.collapsed(hintText: ''),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _saveAndClose,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.apricot,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                            ),
                            child: const Text('保存'),
                          ),
                        ),
                      ),
                      SizedBox(height: context.bottomPadding + AppSpacing.md),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
