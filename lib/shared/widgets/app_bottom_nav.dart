import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/reminder_providers.dart';

class AppBottomNav extends ConsumerWidget {
  const AppBottomNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeCount = ref.watch(activeRemindersProvider).valueOrNull?.length ?? 0;
    final location = GoRouterState.of(context).uri.toString();
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.primary;

    int currentIndex;
    if (location.startsWith('/todo')) {
      currentIndex = 1;
    } else if (location.startsWith('/settings')) {
      currentIndex = 2;
    } else {
      currentIndex = 0;
    }

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 64 + MediaQuery.of(context).padding.bottom,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor.withAlpha(200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: currentIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
                label: '主页',
                isSelected: currentIndex == 0,
                accentColor: accentColor,
                onTap: () => context.go('/home'),
              ),
              _NavItem(
                icon: currentIndex == 1
                    ? Icons.check_circle_rounded
                    : Icons.check_circle_outline_rounded,
                label: '待办',
                isSelected: currentIndex == 1,
                accentColor: accentColor,
                badge: activeCount > 0 ? activeCount : null,
                onTap: () => context.go('/todo'),
              ),
              _NavItem(
                icon: currentIndex == 2 ? Icons.settings : Icons.settings_outlined,
                label: '设置',
                isSelected: currentIndex == 2,
                accentColor: accentColor,
                onTap: () => context.go('/settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Color accentColor;
  final int? badge;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.accentColor,
    this.badge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? accentColor : AppColors.textSecondary;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: color, size: 24),
                if (badge != null)
                  Positioned(
                    right: -8,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.danger,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                      child: Text(
                        '${badge! > 99 ? '99+' : badge}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(fontSize: 10, color: color, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
