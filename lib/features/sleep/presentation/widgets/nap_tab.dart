import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/momentum_palette.dart';
import '../../../../shared/widgets/momentum_card.dart';
import '../../application/nap_form_controller.dart';
import '../../application/nap_form_state.dart';
import '../../application/nap_providers.dart';

class NapTab extends ConsumerWidget {
  const NapTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(napFormControllerProvider);

    return formState.when(
      loading: () => const Padding(
        padding: EdgeInsets.only(top: 80),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => _NapError(
        message: error.toString(),
        onRetry: () => ref.invalidate(napFormControllerProvider),
      ),
      data: (form) {
        final controller = ref.read(napFormControllerProvider.notifier);

        return Column(
          children: [
            _NapSummary(form: form),
            const SizedBox(height: 14),
            MomentumCard(
              child: _NapForm(form: form, controller: controller),
            ),
            if (form.naps.isNotEmpty) ...[
              const SizedBox(height: 14),
              MomentumCard(
                child: _NapList(form: form, controller: controller),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _NapSummary extends StatelessWidget {
  const _NapSummary({required this.form});

  final NapFormState form;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;

    return MomentumCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colors.accent.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.bedtime_outlined, color: colors.accentInk),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today\'s naps',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  form.naps.isEmpty
                      ? 'No naps logged yet'
                      : '${form.naps.length} ${form.naps.length == 1 ? 'nap' : 'naps'} logged',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: colors.secondaryInk),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatDuration(form.totalNapMinutes),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'total nap time',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: colors.secondaryInk),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NapForm extends StatefulWidget {
  const _NapForm({required this.form, required this.controller});

  final NapFormState form;
  final NapFormController controller;

  @override
  State<_NapForm> createState() => _NapFormState();
}

class _NapFormState extends State<_NapForm> {
  late final TextEditingController _notesController;

  NapFormState get form => widget.form;
  NapFormController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(text: form.notes);
  }

  @override
  void didUpdateWidget(covariant _NapForm oldWidget) {
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
            Expanded(
              child: Text(
                form.isEditing ? 'Edit nap' : 'Log a nap',
                style: textTheme.headlineMedium,
              ),
            ),
            Icon(Icons.hotel_outlined, size: 30, color: colors.secondaryInk),
          ],
        ),
        const SizedBox(height: 22),
        LayoutBuilder(
          builder: (context, constraints) {
            final time = _StartTimeField(form: form, controller: controller);
            final duration = _DurationField(form: form, controller: controller);

            if (constraints.maxWidth < 440) {
              return Column(
                children: [time, const SizedBox(height: 14), duration],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: time),
                const SizedBox(width: 14),
                Expanded(child: duration),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        _ChoiceQuestion(
          title: 'Did I sleep?',
          value: form.didSleep,
          options: const {'yes': 'Yes', 'no': 'No', 'unsure': 'Unsure'},
          enabled: !form.isBusy,
          onChanged: controller.setDidSleep,
        ),
        const SizedBox(height: 20),
        _NapTypeQuestion(
          value: form.napType,
          enabled: !form.isBusy,
          onChanged: controller.setNapType,
        ),
        const SizedBox(height: 20),
        _OptionalRatingField(
          value: form.wakeFeeling,
          enabled: !form.isBusy,
          onChanged: controller.setWakeFeeling,
        ),
        const SizedBox(height: 20),
        Text('Notes (optional)', style: textTheme.titleMedium),
        const SizedBox(height: 10),
        TextFormField(
          controller: _notesController,
          enabled: !form.isBusy,
          minLines: 2,
          maxLines: 4,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            hintText: 'How you felt before or after…',
          ),
          onChanged: controller.setNotes,
        ),
        if (form.message != null) ...[
          const SizedBox(height: 16),
          _NapMessage(
            message: form.message!,
            isSuccess: const {
              'Nap saved.',
              'Nap updated.',
              'Nap deleted.',
            }.contains(form.message),
            onDismiss: controller.clearMessage,
          ),
        ],
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 190,
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
                    : Icon(
                        form.isEditing
                            ? Icons.check_rounded
                            : Icons.add_rounded,
                      ),
                label: Text(
                  form.isSaving
                      ? 'Saving…'
                      : form.isEditing
                      ? 'Update nap'
                      : 'Save nap',
                ),
              ),
            ),
            if (form.isEditing)
              TextButton(
                onPressed: form.isBusy ? null : controller.cancelEditing,
                child: const Text('Cancel'),
              ),
          ],
        ),
      ],
    );
  }
}

class _StartTimeField extends StatelessWidget {
  const _StartTimeField({required this.form, required this.controller});

  final NapFormState form;
  final NapFormController controller;

  @override
  Widget build(BuildContext context) {
    final formatted = MaterialLocalizations.of(
      context,
    ).formatTimeOfDay(TimeOfDay.fromDateTime(form.startTime));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Start time', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        InkWell(
          onTap: form.isBusy
              ? null
              : () async {
                  final selected = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(form.startTime),
                  );
                  if (selected == null) return;
                  controller.setStartTime(
                    DateTime(
                      form.startTime.year,
                      form.startTime.month,
                      form.startTime.day,
                      selected.hour,
                      selected.minute,
                    ),
                  );
                },
          borderRadius: BorderRadius.circular(14),
          child: InputDecorator(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.schedule_outlined),
              suffixIcon: Icon(Icons.expand_more_rounded),
            ),
            child: Text(
              formatted,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ],
    );
  }
}

class _DurationField extends StatelessWidget {
  const _DurationField({required this.form, required this.controller});

  final NapFormState form;
  final NapFormController controller;

  static const _options = [15, 20, 30, 45, 60, 90, 120];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Duration', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          initialValue: _options.contains(form.durationMinutes)
              ? form.durationMinutes
              : null,
          isExpanded: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.hourglass_bottom_rounded),
          ),
          hint: Text('${form.durationMinutes} min'),
          items: _options
              .map(
                (minutes) => DropdownMenuItem(
                  value: minutes,
                  child: Text(_formatDuration(minutes)),
                ),
              )
              .toList(growable: false),
          onChanged: form.isBusy
              ? null
              : (value) {
                  if (value != null) controller.setDurationMinutes(value);
                },
        ),
      ],
    );
  }
}

class _OptionalRatingField extends StatelessWidget {
  const _OptionalRatingField({
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final int? value;
  final bool enabled;
  final ValueChanged<int?> onChanged;

  static const _labels = ['terrible', 'rough', 'okay', 'good', 'energised'];

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'How did I feel after I woke up?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.notebook.withValues(alpha: 0.62),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colors.divider),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: List.generate(5, (index) {
                final rating = index + 1;
                final selected = value == rating;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Semantics(
                      button: true,
                      selected: selected,
                      label: 'Wake-up feeling, $rating of 5, ${_labels[index]}',
                      child: InkWell(
                        onTap: enabled
                            ? () => onChanged(selected ? null : rating)
                            : null,
                        borderRadius: BorderRadius.circular(9),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 160),
                          height: 36,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selected
                                ? colors.accent
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(
                              color: selected ? colors.accent : colors.divider,
                            ),
                          ),
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
        ),
        if (value != null) ...[
          const SizedBox(height: 6),
          Text(
            _labels[value! - 1],
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colors.secondaryInk),
          ),
        ],
      ],
    );
  }
}

class _ChoiceQuestion extends StatelessWidget {
  const _ChoiceQuestion({
    required this.title,
    required this.value,
    required this.options,
    required this.enabled,
    required this.onChanged,
  });

  final String title;
  final String? value;
  final Map<String, String> options;
  final bool enabled;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.entries
              .map((option) {
                return ChoiceChip(
                  label: Text(option.value),
                  selected: value == option.key,
                  onSelected: enabled
                      ? (selected) => onChanged(selected ? option.key : null)
                      : null,
                );
              })
              .toList(growable: false),
        ),
      ],
    );
  }
}

class _NapTypeQuestion extends StatelessWidget {
  const _NapTypeQuestion({
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final String? value;
  final bool enabled;
  final ValueChanged<String?> onChanged;

  static const _options = <String, (String, String)>{
    'planned': (
      'Planned',
      'I pre-emptively napped to avoid further daytime sleepiness.',
    ),
    'unplanned': (
      'Unplanned',
      'I felt extremely tired and chose to nap before it became involuntary.',
    ),
    'involuntary': ('Involuntary', 'The nap was not controlled.'),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What type of nap?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        AbsorbPointer(
          absorbing: !enabled,
          child: RadioGroup<String>(
            groupValue: value,
            onChanged: onChanged,
            child: Column(
              children: [
                for (final option in _options.entries)
                  InkWell(
                    onTap: enabled ? () => onChanged(option.key) : null,
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Radio<String>(
                            value: option.key,
                            visualDensity: VisualDensity.compact,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  option.value.$1,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  option.value.$2,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color:
                                            context.momentumColors.secondaryInk,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

class _NapList extends StatelessWidget {
  const _NapList({required this.form, required this.controller});

  final NapFormState form;
  final NapFormController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Logged today', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        for (var index = 0; index < form.naps.length; index++) ...[
          if (index > 0) const Divider(height: 1),
          _NapListItem(
            nap: form.naps[index],
            isDeleting: form.deletingNapId == form.naps[index].id,
            enabled: !form.isBusy,
            onEdit: () => controller.startEditing(form.naps[index]),
            onDelete: () =>
                _confirmDelete(context, form.naps[index], controller),
          ),
        ],
      ],
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    NapLog nap,
    NapFormController controller,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        constraints: const BoxConstraints(
          minWidth: 320,
          maxWidth: 400,
        ),
        title: const Text('Delete nap?'),
        content: Text(
          'Remove the ${_formatDuration(nap.durationMinutes)} nap?',
        ),
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
      ),
    );

    if (shouldDelete == true) {
      await controller.deleteNap(nap.id);
    }
  }
}

class _NapListItem extends StatelessWidget {
  const _NapListItem({
    required this.nap,
    required this.isDeleting,
    required this.enabled,
    required this.onEdit,
    required this.onDelete,
  });

  final NapLog nap;
  final bool isDeleting;
  final bool enabled;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = context.momentumColors;
    final time = MaterialLocalizations.of(
      context,
    ).formatTimeOfDay(TimeOfDay.fromDateTime(nap.startTime));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$time · ${_formatDuration(nap.durationMinutes)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (nap.didSleep != null ||
                    nap.napType != null ||
                    nap.wakeFeeling != null ||
                    nap.notes != null) ...[
                  const SizedBox(height: 3),
                  Text(
                    [
                      if (nap.didSleep != null)
                        'Slept ${_displayDidSleep(nap.didSleep!)}',
                      if (nap.napType != null) _displayNapType(nap.napType!),
                      if (nap.wakeFeeling != null)
                        'After waking ${nap.wakeFeeling}/5',
                      if (nap.notes != null) nap.notes!,
                    ].join(' · '),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: colors.secondaryInk),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            tooltip: 'Edit nap',
            onPressed: enabled ? onEdit : null,
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Delete nap',
            onPressed: enabled ? onDelete : null,
            icon: isDeleting
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
    );
  }
}

class _NapMessage extends StatelessWidget {
  const _NapMessage({
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
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
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
          Expanded(child: Text(message)),
          IconButton(
            visualDensity: VisualDensity.compact,
            tooltip: 'Dismiss',
            onPressed: onDismiss,
            icon: const Icon(Icons.close_rounded, size: 19),
          ),
        ],
      ),
    );
  }
}

class _NapError extends StatelessWidget {
  const _NapError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return MomentumCard(
      child: Column(
        children: [
          const Icon(Icons.error_outline_rounded, size: 34),
          const SizedBox(height: 12),
          Text(
            'Nap data could not be loaded.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}

String _formatDuration(int minutes) {
  if (minutes < 60) return '$minutes min';
  final hours = minutes ~/ 60;
  final remainder = minutes % 60;
  if (remainder == 0) return '$hours ${hours == 1 ? 'hr' : 'hrs'}';
  return '$hours hr $remainder min';
}

String _displayDidSleep(String value) {
  return switch (value) {
    'yes' => 'yes',
    'no' => 'no',
    _ => 'unsure',
  };
}

String _displayNapType(String value) {
  return switch (value) {
    'planned' => 'Planned',
    'unplanned' => 'Unplanned',
    'involuntary' => 'Involuntary',
    _ => value,
  };
}
