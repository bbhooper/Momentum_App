import 'package:flutter/material.dart';

import '../../../../core/theme/momentum_palette.dart';
import '../../../../shared/widgets/momentum_card.dart';
import '../../../../shared/widgets/textured_page.dart';

class SleepPage extends StatelessWidget {
  const SleepPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;

    return Scaffold(
      body: TexturedPage(
        textureAsset: 'assets/images/notebook_paper03.jpg',
        child: ListView(
          children: [
            Text(
              'Sleep',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 6),
            Text(
              'Record last night and begin today gently.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.secondaryInk,
                  ),
            ),
            const SizedBox(height: 28),
            MomentumCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last night',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bedtime, wake time and sleep quality will appear here.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  Divider(
                    height: 1,
                    color: colors.divider,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '8 hours 12 minutes',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Calculated sleep duration',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            MomentumCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How do you feel?',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) {
                      final selected = index == 3;

                      return SizedBox.square(
                        dimension: 48,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color:
                                selected ? colors.accent : colors.notebook,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  selected ? colors.accent : colors.divider,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: selected
                                        ? colors.accentInk
                                        : colors.secondaryInk,
                                  ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}