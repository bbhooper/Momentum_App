import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/momentum_palette.dart';
import '../../../../shared/widgets/momentum_card.dart';
import '../../../../shared/widgets/textured_page.dart';
import '../../application/care_form_state.dart';
import '../../application/care_providers.dart';
import '../../domain/energy_level.dart';
import '../../domain/home_care_task.dart';

class CarePage extends ConsumerStatefulWidget {
  const CarePage({super.key});

  @override
  ConsumerState<CarePage> createState() => _CarePageState();
}

class _CarePageState extends ConsumerState<CarePage> {
  int _selectedTab = 0;
  final _notesController = TextEditingController();
  String? _loadedDate;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    final care = ref.watch(careFormControllerProvider);
    return Scaffold(
      body: TexturedPage(
        textureAsset: 'assets/images/notebook_paper03.jpg',
        child: care.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => Center(
            child: FilledButton(
              onPressed: () => ref.invalidate(careFormControllerProvider),
              child: const Text('Try again'),
            ),
          ),
          data: (form) {
            if (_loadedDate != form.date.dateKey) {
              _loadedDate = form.date.dateKey;
              _notesController.text = form.moodNotes;
            }
            return ListView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.paddingOf(context).bottom + 96,
              ),
              children: [
                _PageHeading(colors: colors),
                const SizedBox(height: 22),
                _CareTabSelector(
                  selectedIndex: _selectedTab,
                  onSelected: (index) => setState(() => _selectedTab = index),
                ),
                const SizedBox(height: 18),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  child: _selectedTab == 0
                      ? KeyedSubtree(
                          key: const ValueKey('self-care-tab'),
                          child: _SelfCareTab(
                            form: form,
                            notesController: _notesController,
                          ),
                        )
                      : KeyedSubtree(
                          key: const ValueKey('home-care-tab'),
                          child: _HomeCareTab(form: form),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PageHeading extends StatelessWidget {
  const _PageHeading({required this.colors});

  final MomentumPalette colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Care', style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 6),
        Text(
          'A gentle check-in for you and your space.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: colors.secondaryInk),
        ),
      ],
    );
  }
}

class _CareTabSelector extends StatelessWidget {
  const _CareTabSelector({
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.divider),
      ),
      child: Row(
        children: [
          Expanded(
            child: _CareTabButton(
              label: 'Self Care',
              icon: Icons.favorite_border_rounded,
              isSelected: selectedIndex == 0,
              onTap: () => onSelected(0),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _CareTabButton(
              label: 'Home Care',
              icon: Icons.home_outlined,
              isSelected: selectedIndex == 1,
              onTap: () => onSelected(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _CareTabButton extends StatelessWidget {
  const _CareTabButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    return Semantics(
      button: true,
      selected: isSelected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          height: 44,
          decoration: BoxDecoration(
            color: isSelected ? colors.accent : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 19,
                color: isSelected ? colors.accentInk : colors.secondaryInk,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isSelected ? colors.accentInk : colors.secondaryInk,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelfCareTab extends ConsumerWidget {
  const _SelfCareTab({required this.form, required this.notesController});

  final CareFormState form;
  final TextEditingController notesController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(careFormControllerProvider.notifier);
    return Column(
      children: [
        MomentumCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'How are you feeling?',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Icon(
                    Icons.favorite_outline_rounded,
                    size: 30,
                    color: context.momentumColors.secondaryInk,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Choose the closest fit — it does not need to be exact.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              _MoodScale(
                value: form.moodScore,
                enabled: !form.isBusy,
                onChanged: controller.setMoodScore,
              ),
              const SizedBox(height: 20),
              Text(
                'Notes (optional)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: notesController,
                enabled: !form.isBusy,
                minLines: 3,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
                onChanged: controller.setMoodNotes,
                decoration: const InputDecoration(
                  hintText: 'Anything affecting how you feel today?',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 190,
                child: FilledButton.icon(
                  onPressed: form.isBusy
                      ? null
                      : () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          await controller.saveMood();
                        },
                  icon: form.isSaving
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.bookmark_border_rounded),
                  label: Text(
                    form.isSaving
                        ? 'Saving…'
                        : form.hasSavedMood
                        ? 'Update mood'
                        : 'Save mood',
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        MomentumCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'How is your energy now?',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Icon(
                    Icons.bolt_rounded,
                    size: 30,
                    color: context.momentumColors.secondaryInk,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Check in whenever it is useful. Each response is saved automatically.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              _EnergyPicker(
                current: form.currentEnergy,
                enabled: !form.isBusy,
                onChanged: controller.addEnergy,
              ),
              if (form.energyLogs.isNotEmpty) ...[
                const SizedBox(height: 18),
                Text(
                  'Today’s check-ins',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                for (final log in form.energyLogs.reversed)
                  _EnergyHistoryTile(log: log),
              ],
            ],
          ),
        ),
        _Message(message: form.message),
      ],
    );
  }
}

class _EnergyHistoryTile extends ConsumerWidget {
  const _EnergyHistoryTile({required this.log});
  final EnergyLog log;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = EnergyLevel.fromStorage(log.energyLevel);
    final controller = ref.read(careFormControllerProvider.notifier);
    final isCareEntry = log.captureSource == 'care_page';
    final sourceLabel = switch (log.captureSource) {
      'sleep_form' => 'Wake-up check-in',
      'notification' => 'Notification check-in',
      _ => null,
    };
    final time = TimeOfDay.fromDateTime(log.recordedAt).format(context);

    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(level?.label ?? log.energyLevel),
      subtitle: Text('$time${sourceLabel == null ? '' : ' · $sourceLabel'}'),
      trailing: isCareEntry
          ? PopupMenuButton<String>(
              tooltip: 'Energy entry options',
              onSelected: (action) async {
                if (action == 'delete') {
                  await controller.deleteEnergy(log);
                  return;
                }
                final picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(log.recordedAt),
                );
                if (picked == null) return;
                await controller.updateEnergyTime(
                  log,
                  DateTime(
                    log.recordedAt.year,
                    log.recordedAt.month,
                    log.recordedAt.day,
                    picked.hour,
                    picked.minute,
                  ),
                );
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'time', child: Text('Edit time')),
                PopupMenuItem(value: 'delete', child: Text('Remove entry')),
              ],
            )
          : null,
    );
  }
}

class _HomeCareTab extends ConsumerWidget {
  const _HomeCareTab({required this.form});
  final CareFormState form;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(careFormControllerProvider.notifier);
    final current = form.currentEnergy;
    return Column(
      children: [
        MomentumCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Home Care',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Icon(
                    Icons.home_outlined,
                    size: 30,
                    color: context.momentumColors.secondaryInk,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              if (current == null)
                Text(
                  'Choose your current energy in Self Care to see a suitable task list.',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              else ...[
                Text(
                  '${current.label} energy · ${_demandLabel(current.homeCareDemand)}-demand tasks',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                Text(
                  '${form.completedVisibleTaskCount} of ${form.visibleTasks.length} recommended tasks complete',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 6),
                for (final task in form.visibleTasks)
                  CheckboxListTile(
                    value: form.completedTaskKeys.contains(task.key),
                    enabled: !form.isBusy,
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(task.title),
                    onChanged: (value) =>
                        controller.setTaskCompleted(task, value ?? false),
                  ),
              ],
            ],
          ),
        ),
        if (form.completions.isNotEmpty) ...[
          const SizedBox(height: 14),
          MomentumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Completed today',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  '${form.completions.length} task${form.completions.length == 1 ? '' : 's'} achieved across the day',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                for (final completion in form.completions)
                  _CompletedTaskTile(
                    completion: completion,
                    task: _findTask(completion.taskKey),
                  ),
              ],
            ),
          ),
        ],
        _Message(message: form.message),
      ],
    );
  }

  HomeCareTask? _findTask(String taskKey) {
    for (final task in form.tasks) {
      if (task.key == taskKey) return task;
    }
    return null;
  }

  String _demandLabel(String demand) =>
      '${demand[0].toUpperCase()}${demand.substring(1)}';
}

class _CompletedTaskTile extends ConsumerWidget {
  const _CompletedTaskTile({required this.completion, required this.task});

  final HomeCareCompletion completion;
  final HomeCareTask? task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final energy = EnergyLevel.fromStorage(completion.energyAtCompletion);

    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.check_circle_outline),
      title: Text(completion.taskTitle),
      subtitle: Text(
        '${TimeOfDay.fromDateTime(completion.completedAt).format(context)}'
        '${energy == null ? '' : ' · ${energy.label} energy'}',
      ),
      trailing: task == null
          ? null
          : IconButton(
              tooltip: 'Undo completion',
              icon: const Icon(Icons.undo),
              onPressed: () => ref
                  .read(careFormControllerProvider.notifier)
                  .setTaskCompleted(task!, false),
            ),
    );
  }
}

class _EnergyPicker extends StatelessWidget {
  const _EnergyPicker({
    required this.current,
    required this.enabled,
    required this.onChanged,
  });
  final EnergyLevel? current;
  final bool enabled;
  final ValueChanged<EnergyLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.notebook.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.divider),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            for (var index = 0; index < EnergyLevel.values.length; index++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: _EnergyButton(
                    level: EnergyLevel.values[index],
                    selected: current == EnergyLevel.values[index],
                    enabled: enabled,
                    onTap: () => onChanged(EnergyLevel.values[index]),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _EnergyButton extends StatelessWidget {
  const _EnergyButton({
    required this.level,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final EnergyLevel level;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    return Semantics(
      button: true,
      selected: selected,
      excludeSemantics: true,
      label: '${level.label} energy, ${level.description}',
      child: Tooltip(
        message: level.description,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(9),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            height: 48,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: selected ? colors.accent : Colors.transparent,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: selected ? colors.accent : colors.divider,
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                level.label,
                maxLines: 1,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: selected ? colors.accentInk : colors.secondaryInk,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MoodScale extends StatelessWidget {
  const _MoodScale({
    required this.value,
    required this.enabled,
    required this.onChanged,
  });
  final int? value;
  final bool enabled;
  final ValueChanged<int> onChanged;
  static const _items = [
    (1, Icons.sentiment_very_dissatisfied_outlined, 'Low'),
    (2, Icons.sentiment_dissatisfied_outlined, 'Flat'),
    (3, Icons.sentiment_neutral_outlined, 'Okay'),
    (4, Icons.sentiment_satisfied_outlined, 'Good'),
    (5, Icons.sentiment_very_satisfied_outlined, 'Great'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.notebook.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.divider),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            for (final item in _items)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Semantics(
                    button: true,
                    selected: value == item.$1,
                    excludeSemantics: true,
                    label: 'Mood, ${item.$1} of 5, ${item.$3}',
                    child: InkWell(
                      onTap: enabled ? () => onChanged(item.$1) : null,
                      borderRadius: BorderRadius.circular(9),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        height: 54,
                        decoration: BoxDecoration(
                          color: value == item.$1
                              ? colors.accent
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                            color: value == item.$1
                                ? colors.accent
                                : colors.divider,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              item.$2,
                              size: 22,
                              color: value == item.$1
                                  ? colors.accentInk
                                  : colors.secondaryInk,
                            ),
                            const SizedBox(height: 3),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                item.$3,
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: value == item.$1
                                          ? colors.accentInk
                                          : colors.secondaryInk,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({this.message});
  final String? message;
  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();
    final colors = context.momentumColors;
    final isSuccess = const {
      'Self care saved.',
      'Energy updated.',
      'Energy entry removed.',
      'Mood entry deleted.',
    }.contains(message);
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isSuccess
            ? colors.accent.withValues(alpha: 0.28)
            : Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle_outline : Icons.info_outline,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(message!)),
        ],
      ),
    );
  }
}
