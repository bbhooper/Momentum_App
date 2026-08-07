import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/app/providers/theme_mode_provider.dart';

void main() {
  group('themeModeProvider', () {
    test('defaults to following the system theme', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(themeModeProvider), ThemeMode.system);
    });

    test('can switch between light, dark and system modes', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(themeModeProvider.notifier);

      notifier.setMode(ThemeMode.light);
      expect(container.read(themeModeProvider), ThemeMode.light);

      notifier.setMode(ThemeMode.dark);
      expect(container.read(themeModeProvider), ThemeMode.dark);

      notifier.setMode(ThemeMode.system);
      expect(container.read(themeModeProvider), ThemeMode.system);
    });
  });
}
