import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/navigation/app_router.dart';
import '../core/theme/momentum_theme.dart';
import 'providers/app_initialisation_provider.dart';
import 'providers/theme_mode_provider.dart';

class MomentumApp extends ConsumerWidget {
  const MomentumApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialisation = ref.watch(appInitialisationProvider);
    final themeMode = ref.watch(themeModeProvider);

    return initialisation.when(
      loading: () => MaterialApp(
        title: 'Momentum',
        debugShowCheckedModeBanner: false,
        theme: MomentumTheme.inkLight,
        darkTheme: MomentumTheme.inkDark,
        themeMode: themeMode,
        home: const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (error, stackTrace) => MaterialApp(
        title: 'Momentum',
        debugShowCheckedModeBanner: false,
        theme: MomentumTheme.inkLight,
        darkTheme: MomentumTheme.inkDark,
        themeMode: themeMode,
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
        themeMode: themeMode,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
