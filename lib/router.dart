import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/home/home_screen.dart';
import 'features/tasks/tasks_screen.dart';
import 'features/gacha/gacha_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/auth/auth_screen.dart';
import 'features/scaffold_with_navbar.dart';
import 'providers/auth_provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _shellNavigatorTasksKey = GlobalKey<NavigatorState>(debugLabel: 'tasks');
final _shellNavigatorGachaKey = GlobalKey<NavigatorState>(debugLabel: 'gacha');
final _shellNavigatorSettingsKey = GlobalKey<NavigatorState>(debugLabel: 'settings');

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final isAuthRoute = state.uri.path == '/auth';

      if (!isLoggedIn && !isAuthRoute) {
        return '/auth';
      }
      if (isLoggedIn && isAuthRoute) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorTasksKey,
            routes: [
              GoRoute(
                path: '/tasks',
                builder: (context, state) => const TasksScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorGachaKey,
            routes: [
              GoRoute(
                path: '/gacha',
                builder: (context, state) => const GachaScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSettingsKey,
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
