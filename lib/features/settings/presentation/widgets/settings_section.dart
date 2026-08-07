import 'package:flutter/material.dart';

import '../../../../core/theme/momentum_palette.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title.toUpperCase(),
            style: textTheme.labelSmall?.copyWith(
              color: colors.secondaryInk,
              letterSpacing: 1.1,
            ),
          ),
        ),
        Material(
          color: colors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(color: colors.divider, width: 0.8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (var index = 0; index < children.length; index++) ...[
                children[index],
                if (index != children.length - 1)
                  Divider(height: 1, indent: 56, color: colors.divider),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    final contentColor = enabled ? colors.primaryInk : colors.secondaryInk;

    return ListTile(
      enabled: enabled,
      onTap: enabled ? onTap : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Icon(icon, color: contentColor),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing: enabled
          ? Icon(Icons.chevron_right, color: colors.secondaryInk)
          : Text('Later', style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
