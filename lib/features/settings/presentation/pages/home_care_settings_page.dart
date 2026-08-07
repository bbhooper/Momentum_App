import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/momentum_palette.dart';
import '../../../../shared/widgets/momentum_card.dart';
import '../../../../shared/widgets/textured_page.dart';
import '../../../care/domain/home_care_task.dart';
import '../../application/home_care_settings_controller.dart';
import '../../application/home_care_settings_state.dart';

class HomeCareSettingsPage extends ConsumerWidget {
  const HomeCareSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(homeCareSettingsControllerProvider);
    final controller = ref.read(homeCareSettingsControllerProvider.notifier);

    return Material(
      color: Colors.transparent,
      child: TexturedPage(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            _PageHeader(onBack: () => context.pop()),
            Expanded(
              child: settings.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => _LoadError(
                  message: error.toString(),
                  onRetry: () =>
                      ref.invalidate(homeCareSettingsControllerProvider),
                ),
                data: (state) =>
                    _TaskSettings(state: state, controller: controller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.onBack});

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
              'Home Care',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskSettings extends StatelessWidget {
  const _TaskSettings({required this.state, required this.controller});

  final HomeCareSettingsState state;
  final HomeCareSettingsController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
      children: [
        Text(
          'Shape Home Care around your actual capacity. Demand is personal—'
          'choose what each task costs you.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                key: const ValueKey('add-home-care-task'),
                onPressed: () => _openTaskEditor(context, controller),
                icon: const Icon(Icons.add),
                label: const Text('Add task'),
              ),
            ),
            const SizedBox(width: 12),
            IconButton.outlined(
              tooltip: 'Restore built-in defaults',
              onPressed: () => _confirmRestore(context, controller),
              icon: const Icon(Icons.restore),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Material(
          color: Colors.transparent,
          child: SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: const Text('Show inactive tasks'),
            subtitle: const Text('Inactive tasks stay out of daily Home Care.'),
            value: state.showInactive,
            onChanged: controller.setShowInactive,
          ),
        ),
        const SizedBox(height: 12),
        for (final section in const [
          ('low', 'Low demand', 'For days with very little capacity'),
          ('medium', 'Medium demand', 'For steady, manageable effort'),
          ('high', 'High demand', 'For days with more capacity'),
        ]) ...[
          _DemandSection(
            demand: section.$1,
            title: section.$2,
            subtitle: section.$3,
            tasks: state.tasksFor(section.$1),
            controller: controller,
          ),
          const SizedBox(height: 18),
        ],
        TextButton.icon(
          onPressed: () => _confirmRestore(context, controller),
          icon: const Icon(Icons.restore),
          label: const Text('Restore built-in defaults'),
        ),
      ],
    );
  }
}

class _DemandSection extends StatelessWidget {
  const _DemandSection({
    required this.demand,
    required this.title,
    required this.subtitle,
    required this.tasks,
    required this.controller,
  });

  final String demand;
  final String title;
  final String subtitle;
  final List<HomeCareTask> tasks;
  final HomeCareSettingsController controller;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    return MomentumCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 9,
                  height: 9,
                  margin: const EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                    color: colors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: colors.divider),
          if (tasks.isEmpty)
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                'No tasks in this group.',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: colors.secondaryInk),
              ),
            )
          else
            ReorderableListView.builder(
              key: ValueKey('$demand-demand-list'),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              buildDefaultDragHandles: false,
              itemCount: tasks.length,
              onReorderItem: (oldIndex, newIndex) =>
                  controller.reorderWithinDemand(
                    demand: demand,
                    oldIndex: oldIndex,
                    newIndex: newIndex,
                  ),
              itemBuilder: (context, index) {
                final task = tasks[index];
                return _TaskRow(
                  key: ValueKey('home-care-task-${task.key}'),
                  task: task,
                  index: index,
                  controller: controller,
                  showDivider: index < tasks.length - 1,
                );
              },
            ),
        ],
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  const _TaskRow({
    super.key,
    required this.task,
    required this.index,
    required this.controller,
    required this.showDivider,
  });

  final HomeCareTask task;
  final int index;
  final HomeCareSettingsController controller;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 10, 4),
          child: Row(
            children: [
              ReorderableDragStartListener(
                index: index,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(Icons.drag_indicator, color: colors.secondaryInk),
                ),
              ),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _openTaskEditor(context, controller, task: task),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: task.isActive
                                    ? colors.primaryInk
                                    : colors.secondaryInk,
                              ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          task.isDefault ? 'Built in' : 'Custom',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Switch.adaptive(
                value: task.isActive,
                onChanged: (value) => controller.setTaskActive(task, value),
              ),
            ],
          ),
        ),
        if (showDivider) Divider(height: 1, indent: 54, color: colors.divider),
      ],
    );
  }
}

Future<void> _openTaskEditor(
  BuildContext context,
  HomeCareSettingsController controller, {
  HomeCareTask? task,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (sheetContext) =>
        _TaskEditorSheet(controller: controller, task: task),
  );
}

class _TaskEditorSheet extends StatefulWidget {
  const _TaskEditorSheet({required this.controller, this.task});

  final HomeCareSettingsController controller;
  final HomeCareTask? task;

  @override
  State<_TaskEditorSheet> createState() => _TaskEditorSheetState();
}

class _TaskEditorSheetState extends State<_TaskEditorSheet> {
  late final TextEditingController _titleController;
  late String _demand;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _demand = widget.task?.userDemandLevel ?? 'low';
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    final task = widget.task;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        20 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task == null ? 'Add Home Care task' : 'Edit Home Care task',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            TextField(
              key: const ValueKey('home-care-task-name'),
              controller: _titleController,
              autofocus: true,
              maxLength: 80,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: 'Task name',
                errorText: _errorText,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Personal demand',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'low', label: Text('Low')),
                ButtonSegment(value: 'medium', label: Text('Medium')),
                ButtonSegment(value: 'high', label: Text('High')),
              ],
              selected: {_demand},
              onSelectionChanged: (selection) =>
                  setState(() => _demand = selection.single),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                if (task != null && !task.isDefault)
                  TextButton.icon(
                    onPressed: () async {
                      await widget.controller.archiveTask(task);
                      if (mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: Icon(Icons.delete_outline, color: colors.error),
                    label: Text(
                      'Delete',
                      style: TextStyle(color: colors.error),
                    ),
                  ),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  key: const ValueKey('save-home-care-task'),
                  style: FilledButton.styleFrom(minimumSize: const Size(0, 52)),
                  onPressed: () async {
                    if (_titleController.text.trim().isEmpty) {
                      setState(() => _errorText = 'Enter a task name.');
                      return;
                    }
                    if (task == null) {
                      await widget.controller.createTask(
                        title: _titleController.text,
                        demand: _demand,
                      );
                    } else {
                      await widget.controller.updateTask(
                        task: task,
                        title: _titleController.text,
                        demand: _demand,
                      );
                    }
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _confirmRestore(
  BuildContext context,
  HomeCareSettingsController controller,
) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Restore built-in tasks?'),
      content: const Text(
        'This restores the original names, demand levels, order and active '
        'state of built-in tasks. Your custom tasks will not be changed.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text('Restore'),
        ),
      ],
    ),
  );
  if (confirmed == true) await controller.restoreDefaults();
}

class _LoadError extends StatelessWidget {
  const _LoadError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 36),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
