import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/textured_page.dart';
import '../widgets/settings_section.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TexturedPage(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _SettingsHeader(title: 'Settings', onBack: () => _goBack(context)),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              children: [
                SettingsSection(
                  title: 'Appearance',
                  children: [
                    SettingsTile(
                      icon: Icons.palette_outlined,
                      title: 'Display & themes',
                      subtitle: 'Ink · system, light or dark',
                      onTap: () => context.push('/settings/display'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SettingsSection(
                  title: 'Personalisation',
                  children: [
                    SettingsTile(
                      icon: Icons.home_outlined,
                      title: 'Home Care',
                      subtitle: 'Tasks, demand levels and defaults',
                      onTap: () => context.push('/settings/home-care'),
                    ),
                    const SettingsTile(
                      icon: Icons.tune_outlined,
                      title: 'Modules & trackers',
                      subtitle: 'Choose what Momentum tracks',
                      enabled: false,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const SettingsSection(
                  title: 'App',
                  children: [
                    SettingsTile(
                      icon: Icons.notifications_none_outlined,
                      title: 'Notifications',
                      enabled: false,
                    ),
                    SettingsTile(
                      icon: Icons.storage_outlined,
                      title: 'Data & backup',
                      enabled: false,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const SettingsSection(
                  title: 'Information',
                  children: [
                    SettingsTile(
                      icon: Icons.shield_outlined,
                      title: 'Privacy',
                      enabled: false,
                    ),
                    SettingsTile(
                      icon: Icons.info_outline,
                      title: 'About',
                      enabled: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _goBack(BuildContext context) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.go('/');
  }
}

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader({required this.title, required this.onBack});

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
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }
}
