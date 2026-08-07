import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/theme_mode_provider.dart';
import '../../../../core/theme/momentum_palette.dart';
import '../../../../shared/widgets/textured_page.dart';

class DisplayThemeSettingsPage extends ConsumerWidget {
  const DisplayThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.momentumColors;
    final themeMode = ref.watch(themeModeProvider);

    return TexturedPage(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _Header(title: 'Display & themes', onBack: () => context.pop()),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              children: [
                Text('THEME', style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: 8),
                Material(
                  color: colors.card,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: colors.divider),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: const ListTile(
                    leading: Icon(Icons.auto_stories_outlined),
                    title: Text('Ink'),
                    subtitle: Text('Inky blue-blacks, blue greys and sage'),
                    trailing: Icon(Icons.check_circle_outline),
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'APPEARANCE',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 8),
                Material(
                  color: colors.card,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: colors.divider),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      _ThemeModeTile(
                        title: 'Follow system',
                        icon: Icons.brightness_auto_outlined,
                        value: ThemeMode.system,
                        groupValue: themeMode,
                        onChanged: (value) =>
                            ref.read(themeModeProvider.notifier).setMode(value),
                      ),
                      Divider(height: 1, indent: 56, color: colors.divider),
                      _ThemeModeTile(
                        title: 'Light',
                        icon: Icons.light_mode_outlined,
                        value: ThemeMode.light,
                        groupValue: themeMode,
                        onChanged: (value) =>
                            ref.read(themeModeProvider.notifier).setMode(value),
                      ),
                      Divider(height: 1, indent: 56, color: colors.divider),
                      _ThemeModeTile(
                        title: 'Dark',
                        icon: Icons.dark_mode_outlined,
                        value: ThemeMode.dark,
                        groupValue: themeMode,
                        onChanged: (value) =>
                            ref.read(themeModeProvider.notifier).setMode(value),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Moss, Maple and Stone will plug into this screen once their '
                  'app themes are implemented.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeModeTile extends StatelessWidget {
  const _ThemeModeTile({
    required this.title,
    required this.icon,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String title;
  final IconData icon;
  final ThemeMode value;
  final ThemeMode groupValue;
  final ValueChanged<ThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;

    return ListTile(
      onTap: () => onChanged(value),
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Back',
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ],
      ),
    );
  }
}
