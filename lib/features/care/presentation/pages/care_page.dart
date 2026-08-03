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

class _CarePageState extends ConsumerState<CarePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _notesController = TextEditingController();
  String? _loadedDate;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final care = ref.watch(careFormControllerProvider);
    return TexturedPage(
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Care', style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 4),
              Text(
                'A gentle check-in for you and your space.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: context.momentumColors.secondaryInk,
                ),
              ),
              const SizedBox(height: 16),
              TabBar(
                controller: _tabs,
                tabs: const [
                  Tab(text: 'Self Care'),
                  Tab(text: 'Home Care'),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: TabBarView(
                  controller: _tabs,
                  children: [
                    _SelfCareTab(form: form, notesController: _notesController),
                    _HomeCareTab(form: form),
                  ],
                ),
              ),
            ],
          );
        },
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
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        MomentumCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How are you feeling?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'Choose the closest fit — it does not need to be exact.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 14),
              _MoodScale(
                value: form.moodScore,
                enabled: !form.isBusy,
                onChanged: controller.setMoodScore,
              ),
              const SizedBox(height: 18),
              TextField(
                controller: notesController,
                enabled: !form.isBusy,
                minLines: 3,
                maxLines: 5,
                onChanged: controller.setMoodNotes,
                decoration: const InputDecoration(
                  labelText: 'Mood notes (optional)',
                  hintText: 'Anything affecting how you feel today?',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: form.isBusy ? null : controller.saveMood,
                  child: Text(
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
        const SizedBox(height: 12),
        MomentumCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How is your energy now?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'Update this whenever your energy changes. Each check-in is saved automatically.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 14),
              _EnergyPicker(
                current: form.currentEnergy,
                enabled: !form.isBusy,
                onChanged: controller.addEnergy,
              ),
              if (form.energyLogs.isNotEmpty) ...[
                const SizedBox(height: 18),
                Text(
                  'Today’s changes',
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
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(level?.label ?? log.energyLevel),
      subtitle: Text(TimeOfDay.fromDateTime(log.recordedAt).format(context)),
      trailing: PopupMenuButton<String>(
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
      ),
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
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        MomentumCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Home Care', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              if (current == null)
                Text(
                  'Choose your current energy in Self Care to see a suitable task list.',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              else ...[
                Text(
                  '${current.label} energy · ${_bandLabel(current.homeCareBand)} list',
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
          const SizedBox(height: 12),
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
                  _CompletedTaskTile(completion: completion),
              ],
            ),
          ),
        ],
        _Message(message: form.message),
      ],
    );
  }

  String _bandLabel(String band) =>
      '${band[0].toUpperCase()}${band.substring(1)}';
}

class _CompletedTaskTile extends ConsumerWidget {
  const _CompletedTaskTile({required this.completion});
  final HomeCareCompletion completion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final energy = EnergyLevel.fromStorage(completion.energyAtCompletion);
    HomeCareTask? task;
    for (final item in defaultHomeCareTasks) {
      if (item.key == completion.taskKey) {
        task = item;
        break;
      }
    }
    final matchedTask = task;

    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.check_circle_outline),
      title: Text(completion.taskTitle),
      subtitle: Text(
        '${TimeOfDay.fromDateTime(completion.completedAt).format(context)}'
        '${energy == null ? '' : ' · ${energy.label} energy'}',
      ),
      trailing: matchedTask == null
          ? null
          : IconButton(
              tooltip: 'Undo completion',
              icon: const Icon(Icons.undo),
              onPressed: () => ref
                  .read(careFormControllerProvider.notifier)
                  .setTaskCompleted(matchedTask, false),
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
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final level in EnergyLevel.values)
          ChoiceChip(
            label: Text(level.label),
            tooltip: level.description,
            selected: current == level,
            onSelected: enabled ? (_) => onChanged(level) : null,
          ),
      ],
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
    (1, '😞', 'Low'),
    (2, '🙁', 'Flat'),
    (3, '😐', 'Okay'),
    (4, '🙂', 'Good'),
    (5, '😊', 'Great'),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    return Row(
      children: [
        for (final item in _items)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: InkWell(
                onTap: enabled ? () => onChanged(item.$1) : null,
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(
                    color: value == item.$1
                        ? colors.accent
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.divider),
                  ),
                  child: Column(
                    children: [
                      Text(item.$2, style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 2),
                      Text(
                        item.$3,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({this.message});
  final String? message;
  @override
  Widget build(BuildContext context) => message == null
      ? const SizedBox.shrink()
      : Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(message!, textAlign: TextAlign.center),
        );
}
