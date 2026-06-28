import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/home/home_page.dart';
import 'features/todo/todo_page.dart';
import 'features/settings/settings_page.dart';
import 'features/capture/capture_page.dart';
import 'features/detail/detail_page.dart';
import 'features/capture/capture_overlay.dart';
import 'shared/widgets/app_bottom_nav.dart';

class FlashNoteApp extends ConsumerWidget {
  const FlashNoteApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final accentColor = ref.watch(accentColorProvider);

    final router = GoRouter(
      navigatorKey: NavigationService.navigatorKey,
      initialLocation: '/home',
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return Scaffold(
              body: navigationShell,
              bottomNavigationBar: const AppBottomNav(),
            );
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/home',
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: HomePage(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/todo',
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: TodoPage(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/settings',
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: SettingsPage(),
                  ),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/capture',
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 350),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            child: CapturePage(entryId: state.extra as String?),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween(begin: const Offset(0, 1), end: Offset.zero).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
                ),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
          ),
        ),
        GoRoute(
          path: '/detail/:id',
          pageBuilder: (context, state) {
            final id = state.pathParameters['id']!;
            return CustomTransitionPage(
              transitionDuration: const Duration(milliseconds: 350),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              child: DetailPage(entryId: id),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          },
        ),
      ],
    );

    return GlobalCaptureOverlay(
      child: MaterialApp.router(
        routerConfig: router,
        theme: AppTheme.buildLightTheme(accentColor),
        darkTheme: AppTheme.buildDarkTheme(accentColor),
        themeMode: themeMode,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
