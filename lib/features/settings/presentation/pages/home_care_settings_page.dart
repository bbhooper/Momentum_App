import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/momentum_palette.dart';
import '../../../../shared/widgets/textured_page.dart';

class HomeCareSettingsPage extends StatelessWidget {
  const HomeCareSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;

    return TexturedPage(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
            child: Row(
              children: [
                IconButton(
                  tooltip: 'Back',
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Home Care',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.card,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: colors.divider),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task customisation',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This is the home for your active tasks, Momentum’s '
                          'built-in task library, custom tasks, personal demand '
                          'levels, ordering and restore-defaults controls.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'We’ll build this next on top of the schema v8 Home '
                          'Care task model.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
