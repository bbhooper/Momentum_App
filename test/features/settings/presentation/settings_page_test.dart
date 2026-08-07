import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum/app/providers/theme_mode_provider.dart';
import 'package:momentum/core/theme/momentum_palette.dart';
import 'package:momentum/features/settings/presentation/pages/display_theme_settings_page.dart';
import 'package:momentum/features/settings/presentation/pages/home_care_settings_page.dart';
import 'package:momentum/features/settings/presentation/pages/settings_page.dart';

void main() {
  testWidgets('Settings shows the implemented and planned sections', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: _SettingsTestApp()));
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('APPEARANCE'), findsOneWidget);
    expect(find.text('Display & themes'), findsOneWidget);
    expect(find.text('PERSONALISATION'), findsOneWidget);
    expect(find.text('Home Care'), findsOneWidget);
    expect(find.text('Modules & trackers'), findsOneWidget);

    // Planned destinations are deliberately visible but disabled.
    final modulesTile = tester.widget<ListTile>(
      find.widgetWithText(ListTile, 'Modules & trackers'),
    );
    expect(modulesTile.enabled, isFalse);
  });

  testWidgets('Display settings can change the theme mode', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const _SettingsTestApp(initialLocation: '/settings/display'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Display & themes'), findsOneWidget);
    expect(find.text('Ink'), findsOneWidget);
    expect(find.text('Follow system'), findsOneWidget);
    expect(container.read(themeModeProvider), ThemeMode.system);

    await tester.tap(find.text('Dark'));
    await tester.pump();

    expect(container.read(themeModeProvider), ThemeMode.dark);

    await tester.tap(find.text('Light'));
    await tester.pump();

    expect(container.read(themeModeProvider), ThemeMode.light);
  });

  testWidgets('Home Care settings destination is available', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: _SettingsTestApp(initialLocation: '/settings/home-care'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Home Care'), findsOneWidget);
    expect(find.text('Task customisation'), findsOneWidget);
    expect(find.textContaining('built-in task library'), findsOneWidget);
  });
}

class _SettingsTestApp extends StatefulWidget {
  const _SettingsTestApp({this.initialLocation = '/settings'});

  final String initialLocation;

  @override
  State<_SettingsTestApp> createState() => _SettingsTestAppState();
}

class _SettingsTestAppState extends State<_SettingsTestApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: widget.initialLocation,
      routes: [
        GoRoute(
          path: '/settings',
          builder: (_, _) => const SettingsPage(),
          routes: [
            GoRoute(
              path: 'display',
              builder: (_, _) => const DisplayThemeSettingsPage(),
            ),
            GoRoute(
              path: 'home-care',
              builder: (_, _) => const HomeCareSettingsPage(),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        extensions: const <ThemeExtension<dynamic>>[MomentumPalette.inkLight],
      ),
    );
  }
}
