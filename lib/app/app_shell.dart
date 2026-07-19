import 'package:flutter/material.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final destinations = <NavigationDestination>[
      const NavigationDestination(
        icon: Icon(Icons.home_outlined),
        label: 'Home',
      ),
      const NavigationDestination(
        icon: Icon(Icons.bed_outlined),
        label: 'Sleep',
      ),
      const NavigationDestination(
        icon: Icon(Icons.local_drink_outlined),
        label: 'Fuel',
      ),
      const NavigationDestination(
        icon: Icon(Icons.favorite_outline),
        label: 'Care',
      ),
      const NavigationDestination(
        icon: Icon(Icons.directions_run_outlined),
        label: 'Move',
      ),
      const NavigationDestination(
        icon: Icon(Icons.card_giftcard_outlined),
        label: 'Rewards',
      ),
      const NavigationDestination(
        icon: Icon(Icons.edit_note_outlined),
        label: 'Diary',
      ),
    ];

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(destinations: destinations),
    );
  }
}
