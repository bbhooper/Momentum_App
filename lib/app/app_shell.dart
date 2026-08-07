import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/momentum_palette.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.currentPath, required this.child});

  final String currentPath;
  final Widget child;

  static const _paths = <String>[
    '/',
    '/sleep',
    '/fuel',
    '/care',
    '/move',
    '/rewards',
    '/diary',
  ];

  bool get _isSettingsPath => currentPath.startsWith('/settings');

  @override
  Widget build(BuildContext context) {
    if (_isSettingsPath) {
      return Scaffold(body: child);
    }

    final selectedIndex = _selectedIndex(currentPath);
    final colors = context.momentumColors;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: child),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 8,
            right: 12,
            child: Material(
              color: colors.card.withValues(alpha: 0.92),
              shape: const CircleBorder(),
              elevation: 0,
              child: IconButton(
                tooltip: 'Settings',
                onPressed: () => context.push('/settings'),
                icon: const Icon(Icons.settings_outlined),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          context.go(_paths[index]);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.bed_outlined),
            selectedIcon: Icon(Icons.bed),
            label: 'Sleep',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_drink_outlined),
            selectedIcon: Icon(Icons.local_drink),
            label: 'Fuel',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Care',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_run_outlined),
            selectedIcon: Icon(Icons.directions_run),
            label: 'Move',
          ),
          NavigationDestination(
            icon: Icon(Icons.card_giftcard_outlined),
            selectedIcon: Icon(Icons.card_giftcard),
            label: 'Rewards',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_note_outlined),
            selectedIcon: Icon(Icons.edit_note),
            label: 'Diary',
          ),
        ],
      ),
    );
  }

  int _selectedIndex(String currentPath) {
    final index = _paths.indexWhere((path) {
      if (path == '/') {
        return currentPath == '/';
      }

      return currentPath == path || currentPath.startsWith('$path/');
    });

    return index == -1 ? 0 : index;
  }
}
