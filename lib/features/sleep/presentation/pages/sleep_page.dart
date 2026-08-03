import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/momentum_palette.dart';
import '../../../../shared/widgets/momentum_card.dart';
import '../../../../shared/widgets/textured_page.dart';
import '../../application/sleep_form_controller.dart';
import '../../application/sleep_form_state.dart';
import '../../application/sleep_providers.dart';
import '../widgets/nap_tab.dart';

class SleepPage extends ConsumerStatefulWidget {
  const SleepPage({super.key});

  @override
  ConsumerState<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends ConsumerState<SleepPage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    final formState = ref.watch(sleepFormControllerProvider);

    return Scaffold(
      body: TexturedPage(
        textureAsset: 'assets/images/notebook_paper03.jpg',
        child: ListView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom + 96,
          ),
          children: [
            _PageHeading(colors: colors),
            const SizedBox(height: 22),
            _SleepTabSelector(
              selectedIndex: _selectedTab,
              onSelected: (index) {
                setState(() => _selectedTab = index);
              },
            ),
            const SizedBox(height: 18),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              child: _selectedTab == 0
                  ? KeyedSubtree(
                      key: const ValueKey('sleep-tab'),
                      child: formState.when(
                        loading: () => const Padding(
                          padding: EdgeInsets.only(top: 80),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        error: (error, _) => _SleepError(
                          message: error.toString(),
                          onRetry: () =>
                              ref.invalidate(sleepFormControllerProvider),
                        ),
                        data: (form) {
                          final controller = ref.read(
                            sleepFormControllerProvider.notifier,
                          );

                          return MomentumCard(
                            child: _SleepLogForm(
                              form: form,
                              controller: controller,
                              onDelete: () =>
                                  _confirmDelete(context, controller),
                            ),
                          );
                        },
                      ),
                    )
                  : const KeyedSubtree(
                      key: ValueKey('nap-tab'),
                      child: NapTab(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    SleepFormController controller,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          constraints: const BoxConstraints(minWidth: 320, maxWidth: 400),
          title: const Text('Delete sleep log?'),
          content: const Text('This will remove the sleep entry for this day.'),
          actions: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 120,
                  child: FilledButton(
                    onPressed: () => Navigator.pop(dialogContext, true),
                    child: const Text('Delete'),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 120,
                  child: TextButton(
                    onPressed: () => Navigator.pop(dialogContext, false),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      await controller.delete();
    }
  }
}

class _SleepTabSelector extends StatelessWidget {
  const _SleepTabSelector({
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
            child: _SleepTabButton(
              label: 'Sleep',
              icon: Icons.dark_mode_outlined,
              isSelected: selectedIndex == 0,
              onTap: () => onSelected(0),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _SleepTabButton(
              label: 'Nap',
              icon: Icons.bedtime_outlined,
              isSelected: selectedIndex == 1,
              onTap: () => onSelected(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _SleepTabButton extends StatelessWidget {
  const _SleepTabButton({
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

class _PageHeading extends StatelessWidget {
  const _PageHeading({required this.colors});

  final MomentumPalette colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sleep', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 6),
              Text(
                'Record last night and begin today gently.',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: colors.secondaryInk),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Icon(Icons.dark_mode_outlined, size: 34, color: colors.secondaryInk),
      ],
    );
  }
}

class _SleepLogForm extends StatefulWidget {
  const _SleepLogForm({
    required this.form,
    required this.controller,
    required this.onDelete,
  });

  final SleepFormState form;
  final SleepFormController controller;
  final VoidCallback onDelete;

  @override
  State<_SleepLogForm> createState() => _SleepLogFormState();
}

class _SleepLogFormState extends State<_SleepLogForm> {
  late final TextEditingController _notesController;

  SleepFormState get form => widget.form;
  SleepFormController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(text: form.notes);
  }

  @override
  void didUpdateWidget(covariant _SleepLogForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (form.notes != _notesController.text) {
      _notesController.value = TextEditingValue(
        text: form.notes,
        selection: TextSelection.collapsed(offset: form.notes.length),
      );
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text('Sleep log', style: textTheme.headlineMedium)),
            Icon(Icons.nightlight_round, size: 30, color: colors.secondaryInk),
          ],
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final stackFields = constraints.maxWidth < 440;

            if (stackFields) {
              return Column(
                children: [
                  _TimeField(
                    label: 'Bedtime',
                    time: form.bedtime,
                    icon: Icons.bedtime_outlined,
                    enabled: !form.isBusy,
                    onTap: () => _selectTime(
                      context: context,
                      current: form.bedtime,
                      onSelected: controller.setBedtime,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _TimeField(
                    label: 'Wake time',
                    time: form.wakeTime,
                    icon: Icons.wb_sunny_outlined,
                    enabled: !form.isBusy,
                    onTap: () => _selectTime(
                      context: context,
                      current: form.wakeTime,
                      onSelected: controller.setWakeTime,
                    ),
                  ),
                ],
              );
            }

            return Row(
              children: [
                Expanded(
                  child: _TimeField(
                    label: 'Bedtime',
                    time: form.bedtime,
                    icon: Icons.bedtime_outlined,
                    enabled: !form.isBusy,
                    onTap: () => _selectTime(
                      context: context,
                      current: form.bedtime,
                      onSelected: controller.setBedtime,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _TimeField(
                    label: 'Wake time',
                    time: form.wakeTime,
                    icon: Icons.wb_sunny_outlined,
                    enabled: !form.isBusy,
                    onTap: () => _selectTime(
                      context: context,
                      current: form.wakeTime,
                      onSelected: controller.setWakeTime,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 18),
        _DurationSummary(form: form),
        const SizedBox(height: 22),
        _CompactRatingField(
          title: 'Sleep quality',
          icon: Icons.nights_stay_outlined,
          value: form.sleepQuality,
          labels: const ['poor', 'rough', 'okay', 'good', 'restful'],
          enabled: !form.isBusy,
          onChanged: controller.setSleepQuality,
        ),
        const SizedBox(height: 18),
        _CompactRatingField(
          title: 'Energy today',
          icon: Icons.bolt_rounded,
          value: form.energy,
          labels: const ['drained', 'low', 'functional', 'good', 'energised'],
          enabled: !form.isBusy,
          onChanged: controller.setEnergy,
        ),
        const SizedBox(height: 20),
        Divider(height: 1, color: colors.divider),
        _OptionalDetails(form: form, controller: controller),
        Divider(height: 1, color: colors.divider),
        const SizedBox(height: 20),
        Text('Notes (optional)', style: textTheme.titleMedium),
        const SizedBox(height: 10),
        TextFormField(
          controller: _notesController,
          enabled: !form.isBusy,
          minLines: 3,
          maxLines: 5,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            hintText: 'Waking, dreams, symptoms, medication…',
          ),
          onChanged: controller.setNotes,
        ),
        if (form.message != null) ...[
          const SizedBox(height: 16),
          _FormMessage(
            message: form.message!,
            isSuccess:
                form.message == 'Sleep saved.' ||
                form.message == 'Sleep log deleted.',
            onDismiss: controller.clearMessage,
          ),
        ],
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 210,
              child: FilledButton.icon(
                onPressed: form.isBusy
                    ? null
                    : () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        await controller.save();
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
                      : form.hasSavedLog
                      ? 'Update sleep'
                      : 'Save sleep',
                ),
              ),
            ),
            if (form.hasSavedLog)
              TextButton.icon(
                onPressed: form.isBusy ? null : widget.onDelete,
                icon: form.isDeleting
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.delete_outline_rounded),
                label: Text(form.isDeleting ? 'Deleting…' : 'Delete'),
              ),
          ],
        ),
      ],
    );
  }

  Future<void> _selectTime({
    required BuildContext context,
    required DateTime current,
    required ValueChanged<DateTime> onSelected,
  }) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(current),
    );

    if (selected == null) {
      return;
    }

    onSelected(
      DateTime(
        current.year,
        current.month,
        current.day,
        selected.hour,
        selected.minute,
      ),
    );
  }
}

class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.label,
    required this.time,
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final DateTime time;
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final formattedTime = MaterialLocalizations.of(
      context,
    ).formatTimeOfDay(TimeOfDay.fromDateTime(time));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(14),
          child: InputDecorator(
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              suffixIcon: const Icon(Icons.schedule_rounded),
              enabled: enabled,
            ),
            child: Text(
              formattedTime,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ],
    );
  }
}

class _DurationSummary extends StatelessWidget {
  const _DurationSummary({required this.form});

  final SleepFormState form;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    final isManual = form.manualDurationMinutes != null;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.notebook.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.divider),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(Icons.schedule_outlined, color: colors.secondaryInk),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hours slept',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatDuration(form.effectiveDurationMinutes),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            Text(
              isManual ? 'Adjusted' : 'Calculated',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: colors.secondaryInk),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompactRatingField extends StatelessWidget {
  const _CompactRatingField({
    required this.title,
    required this.icon,
    required this.value,
    required this.labels,
    required this.enabled,
    required this.onChanged,
  });

  final String title;
  final IconData icon;
  final int value;
  final List<String> labels;
  final bool enabled;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    final safeValue = value < 1
        ? 1
        : value > 5
        ? 5
        : value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.notebook.withValues(alpha: 0.62),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colors.divider),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            child: Row(
              children: [
                Icon(icon, color: colors.secondaryInk),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    children: List.generate(5, (index) {
                      final rating = index + 1;
                      final selected = safeValue == rating;

                      return Expanded(
                        child: Semantics(
                          button: true,
                          selected: selected,
                          label: '$title, $rating of 5, ${labels[index]}',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: InkWell(
                              onTap: enabled ? () => onChanged(rating) : null,
                              borderRadius: BorderRadius.circular(9),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 160),
                                height: 36,
                                decoration: BoxDecoration(
                                  color: selected
                                      ? colors.accent
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(9),
                                  border: Border.all(
                                    color: selected
                                        ? colors.accent
                                        : colors.divider,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '$rating',
                                  style: Theme.of(context).textTheme.labelLarge
                                      ?.copyWith(
                                        color: selected
                                            ? colors.accentInk
                                            : colors.secondaryInk,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 76,
                  child: Text(
                    labels[safeValue - 1],
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: colors.secondaryInk),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OptionalDetails extends StatelessWidget {
  const _OptionalDetails({required this.form, required this.controller});

  final SleepFormState form;
  final SleepFormController controller;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;

    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: 20),
        iconColor: colors.secondaryInk,
        collapsedIconColor: colors.secondaryInk,
        title: Text(
          'Sleep details',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          'Optional adjustments',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: colors.secondaryInk),
        ),
        children: [
          _NumberField(
            label: 'Time taken to fall asleep',
            value: form.sleepOnsetAdjustmentMinutes,
            suffix: 'min',
            enabled: !form.isBusy,
            onChanged: controller.setSleepOnsetAdjustmentMinutes,
          ),
          if (form.sleepLatencySource == 'scientificEstimate')
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Using the default 15-minute estimate.',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: colors.secondaryInk),
              ),
            )
          else
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: form.isBusy
                    ? null
                    : controller.useEstimatedSleepLatency,
                child: const Text('Restore 15-minute estimate'),
              ),
            ),
          const SizedBox(height: 8),
          _NumberField(
            label: 'Number of awakenings',
            value: form.awakeningCount,
            suffix: '',
            enabled: !form.isBusy,
            onChanged: controller.setAwakeningCount,
          ),
          const SizedBox(height: 8),
          _NumberField(
            label: 'Time awake overnight',
            value: form.awakeDuringNightMinutes,
            suffix: 'min',
            enabled: !form.isBusy,
            onChanged: controller.setAwakeDuringNightMinutes,
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Manual sleep duration',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Only use this if the calculated duration is inaccurate.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: colors.secondaryInk),
            ),
          ),
          const SizedBox(height: 12),
          _OptionalNumberField(
            value: form.manualDurationMinutes,
            enabled: !form.isBusy,
            onChanged: controller.setManualDurationMinutes,
          ),
        ],
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.label,
    required this.value,
    required this.suffix,
    required this.enabled,
    required this.onChanged,
  });

  final String label;
  final int value;
  final String suffix;
  final bool enabled;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          _StepButton(
            icon: Icons.remove_rounded,
            tooltip: 'Decrease $label',
            onPressed: enabled && value > 0 ? () => onChanged(value - 1) : null,
          ),
          SizedBox(
            width: 70,
            child: Text(
              suffix.isEmpty ? '$value' : '$value $suffix',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          _StepButton(
            icon: Icons.add_rounded,
            tooltip: 'Increase $label',
            onPressed: enabled ? () => onChanged(value + 1) : null,
          ),
          const SizedBox(width: 2),
          Container(width: 1, height: 22, color: colors.divider),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints.tightFor(width: 38, height: 38),
      padding: EdgeInsets.zero,
      iconSize: 20,
      icon: Icon(icon),
    );
  }
}

class _OptionalNumberField extends StatelessWidget {
  const _OptionalNumberField({
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final int? value;
  final bool enabled;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            key: ValueKey(value),
            initialValue: value?.toString() ?? '',
            enabled: enabled,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              hintText: 'Optional',
              suffixText: 'minutes',
            ),
            onChanged: (text) {
              final trimmed = text.trim();

              if (trimmed.isEmpty) {
                onChanged(null);
                return;
              }

              final parsedValue = int.tryParse(trimmed);
              if (parsedValue != null) {
                onChanged(parsedValue);
              }
            },
          ),
        ),
        if (value != null) ...[
          const SizedBox(width: 8),
          IconButton(
            onPressed: enabled ? () => onChanged(null) : null,
            tooltip: 'Clear manual duration',
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ],
    );
  }
}

class _FormMessage extends StatelessWidget {
  const _FormMessage({
    required this.message,
    required this.isSuccess,
    required this.onDismiss,
  });

  final String message;
  final bool isSuccess;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    final foregroundColor = isSuccess ? colors.success : colors.error;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: foregroundColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: foregroundColor.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 8, 4, 8),
        child: Row(
          children: [
            Icon(
              isSuccess
                  ? Icons.check_circle_outline_rounded
                  : Icons.error_outline_rounded,
              color: foregroundColor,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: foregroundColor),
              ),
            ),
            IconButton(
              onPressed: onDismiss,
              tooltip: 'Dismiss',
              icon: Icon(Icons.close_rounded, color: foregroundColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _SleepError extends StatelessWidget {
  const _SleepError({required this.message, required this.onRetry});

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
            const Icon(Icons.error_outline_rounded, size: 40),
            const SizedBox(height: 12),
            Text(
              'Sleep could not be loaded.',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatDuration(int totalMinutes) {
  final safeMinutes = totalMinutes < 0 ? 0 : totalMinutes;
  final hours = safeMinutes ~/ 60;
  final minutes = safeMinutes % 60;

  if (hours == 0) {
    return '$minutes minutes';
  }

  if (minutes == 0) {
    return hours == 1 ? '1 hour' : '$hours hours';
  }

  final hourLabel = hours == 1 ? 'hour' : 'hours';
  final minuteLabel = minutes == 1 ? 'minute' : 'minutes';

  return '$hours $hourLabel $minutes $minuteLabel';
}
