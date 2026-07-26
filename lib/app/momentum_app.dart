import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/navigation/app_router.dart';
import '../core/theme/momentum_theme.dart';
import 'providers/app_initialisation_provider.dart';

class MomentumApp extends ConsumerStatefulWidget {
  const MomentumApp({super.key});

  @override
  ConsumerState<MomentumApp> createState() => _MomentumAppState();
}

class _MomentumAppState extends ConsumerState<MomentumApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _cycleThemeMode() {
    setState(() {
      _themeMode = switch (_themeMode) {
        ThemeMode.system => ThemeMode.light,
        ThemeMode.light => ThemeMode.dark,
        ThemeMode.dark => ThemeMode.system,
      };
    });
  }

  IconData get _themeIcon {
    return switch (_themeMode) {
      ThemeMode.system => Icons.brightness_auto_outlined,
      ThemeMode.light => Icons.light_mode_outlined,
      ThemeMode.dark => Icons.dark_mode_outlined,
    };
  }

  Widget _withThemeToggle(BuildContext context, Widget? child) {
    return Stack(
      children: [
        Positioned.fill(child: child ?? const SizedBox.shrink()),
        Positioned(
          top: MediaQuery.paddingOf(context).top + 8,
          right: 12,
          child: Material(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
            shape: const CircleBorder(),
            elevation: 2,
            child: IconButton(
              onPressed: _cycleThemeMode,
              icon: Icon(_themeIcon),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final initialisation = ref.watch(appInitialisationProvider);

    return initialisation.when(
      loading: () => MaterialApp(
        title: 'Momentum',
        debugShowCheckedModeBanner: false,
        theme: MomentumTheme.inkLight,
        darkTheme: MomentumTheme.inkDark,
        themeMode: _themeMode,
        builder: _withThemeToggle,
        home: const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (error, stackTrace) => MaterialApp(
        title: 'Momentum',
        debugShowCheckedModeBanner: false,
        theme: MomentumTheme.inkLight,
        darkTheme: MomentumTheme.inkDark,
        themeMode: _themeMode,
        builder: _withThemeToggle,
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Momentum could not open its local database.\n\n$error',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      data: (_) => MaterialApp.router(
        title: 'Momentum',
        debugShowCheckedModeBanner: false,
        theme: MomentumTheme.inkLight,
        darkTheme: MomentumTheme.inkDark,
        themeMode: _themeMode,
        routerConfig: AppRouter.router,
        builder: _withThemeToggle,
      ),
    );
  }
}
