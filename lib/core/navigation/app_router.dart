import 'package:go_router/go_router.dart';

import '../../app/app_shell.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/sleep/presentation/pages/sleep_page.dart';
import '../../features/fuel/presentation/pages/fuel_page.dart';
import '../../features/care/presentation/pages/care_page.dart';
import '../../features/move/presentation/pages/move_page.dart';
import '../../features/rewards/presentation/pages/rewards_page.dart';
import '../../features/diary/presentation/pages/diary_page.dart';
import '../../features/insights/presentation/pages/insights_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import 'route_names.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (_, state, child) => AppShell(
          currentPath: state.uri.path,
          child: child,
  ),
        routes: [
          GoRoute(
            path: '/',
            name: RouteNames.home,
            builder: (_, _) => const HomePage(),
          ),
          GoRoute(
            path: '/sleep',
            name: RouteNames.sleep,
            builder: (_, _) => const SleepPage(),
          ),
          GoRoute(
            path: '/fuel',
            name: RouteNames.fuel,
            builder: (_, _) => const FuelPage(),
          ),
          GoRoute(
            path: '/care',
            name: RouteNames.care,
            builder: (_, _) => const CarePage(),
          ),
          GoRoute(
            path: '/move',
            name: RouteNames.move,
            builder: (_, _) => const MovePage(),
          ),
          GoRoute(
            path: '/rewards',
            name: RouteNames.rewards,
            builder: (_, _) => const RewardsPage(),
          ),
          GoRoute(
            path: '/diary',
            name: RouteNames.diary,
            builder: (_, _) => const DiaryPage(),
          ),
          GoRoute(
            path: '/insights',
            name: RouteNames.insights,
            builder: (_, _) => const InsightsPage(),
          ),
          GoRoute(
            path: '/settings',
            name: RouteNames.settings,
            builder: (_, _) => const SettingsPage(),
          ),
        ],
      ),
    ],
  );
}
