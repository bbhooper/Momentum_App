// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DailyRecordsTable extends DailyRecords
    with TableInfo<$DailyRecordsTable, DailyRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateKeyMeta = const VerificationMeta(
    'dateKey',
  );
  @override
  late final GeneratedColumn<String> dateKey = GeneratedColumn<String>(
    'date_key',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 10,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  static const VerificationMeta _endDayCompletedMeta = const VerificationMeta(
    'endDayCompleted',
  );
  @override
  late final GeneratedColumn<bool> endDayCompleted = GeneratedColumn<bool>(
    'end_day_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("end_day_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _endDayCompletedAtMeta = const VerificationMeta(
    'endDayCompletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endDayCompletedAt =
      GeneratedColumn<DateTime>(
        'end_day_completed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dateKey,
    createdAt,
    updatedAt,
    endDayCompleted,
    endDayCompletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date_key')) {
      context.handle(
        _dateKeyMeta,
        dateKey.isAcceptableOrUnknown(data['date_key']!, _dateKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dateKeyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('end_day_completed')) {
      context.handle(
        _endDayCompletedMeta,
        endDayCompleted.isAcceptableOrUnknown(
          data['end_day_completed']!,
          _endDayCompletedMeta,
        ),
      );
    }
    if (data.containsKey('end_day_completed_at')) {
      context.handle(
        _endDayCompletedAtMeta,
        endDayCompletedAt.isAcceptableOrUnknown(
          data['end_day_completed_at']!,
          _endDayCompletedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dateKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_key'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      endDayCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}end_day_completed'],
      )!,
      endDayCompletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_day_completed_at'],
      ),
    );
  }

  @override
  $DailyRecordsTable createAlias(String alias) {
    return $DailyRecordsTable(attachedDatabase, alias);
  }
}

class DailyRecord extends DataClass implements Insertable<DailyRecord> {
  final int id;
  final String dateKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool endDayCompleted;
  final DateTime? endDayCompletedAt;
  const DailyRecord({
    required this.id,
    required this.dateKey,
    required this.createdAt,
    required this.updatedAt,
    required this.endDayCompleted,
    this.endDayCompletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date_key'] = Variable<String>(dateKey);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['end_day_completed'] = Variable<bool>(endDayCompleted);
    if (!nullToAbsent || endDayCompletedAt != null) {
      map['end_day_completed_at'] = Variable<DateTime>(endDayCompletedAt);
    }
    return map;
  }

  DailyRecordsCompanion toCompanion(bool nullToAbsent) {
    return DailyRecordsCompanion(
      id: Value(id),
      dateKey: Value(dateKey),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      endDayCompleted: Value(endDayCompleted),
      endDayCompletedAt: endDayCompletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endDayCompletedAt),
    );
  }

  factory DailyRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyRecord(
      id: serializer.fromJson<int>(json['id']),
      dateKey: serializer.fromJson<String>(json['dateKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      endDayCompleted: serializer.fromJson<bool>(json['endDayCompleted']),
      endDayCompletedAt: serializer.fromJson<DateTime?>(
        json['endDayCompletedAt'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dateKey': serializer.toJson<String>(dateKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'endDayCompleted': serializer.toJson<bool>(endDayCompleted),
      'endDayCompletedAt': serializer.toJson<DateTime?>(endDayCompletedAt),
    };
  }

  DailyRecord copyWith({
    int? id,
    String? dateKey,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? endDayCompleted,
    Value<DateTime?> endDayCompletedAt = const Value.absent(),
  }) => DailyRecord(
    id: id ?? this.id,
    dateKey: dateKey ?? this.dateKey,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    endDayCompleted: endDayCompleted ?? this.endDayCompleted,
    endDayCompletedAt: endDayCompletedAt.present
        ? endDayCompletedAt.value
        : this.endDayCompletedAt,
  );
  DailyRecord copyWithCompanion(DailyRecordsCompanion data) {
    return DailyRecord(
      id: data.id.present ? data.id.value : this.id,
      dateKey: data.dateKey.present ? data.dateKey.value : this.dateKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      endDayCompleted: data.endDayCompleted.present
          ? data.endDayCompleted.value
          : this.endDayCompleted,
      endDayCompletedAt: data.endDayCompletedAt.present
          ? data.endDayCompletedAt.value
          : this.endDayCompletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyRecord(')
          ..write('id: $id, ')
          ..write('dateKey: $dateKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('endDayCompleted: $endDayCompleted, ')
          ..write('endDayCompletedAt: $endDayCompletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    dateKey,
    createdAt,
    updatedAt,
    endDayCompleted,
    endDayCompletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyRecord &&
          other.id == this.id &&
          other.dateKey == this.dateKey &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.endDayCompleted == this.endDayCompleted &&
          other.endDayCompletedAt == this.endDayCompletedAt);
}

class DailyRecordsCompanion extends UpdateCompanion<DailyRecord> {
  final Value<int> id;
  final Value<String> dateKey;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> endDayCompleted;
  final Value<DateTime?> endDayCompletedAt;
  const DailyRecordsCompanion({
    this.id = const Value.absent(),
    this.dateKey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.endDayCompleted = const Value.absent(),
    this.endDayCompletedAt = const Value.absent(),
  });
  DailyRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String dateKey,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.endDayCompleted = const Value.absent(),
    this.endDayCompletedAt = const Value.absent(),
  }) : dateKey = Value(dateKey);
  static Insertable<DailyRecord> custom({
    Expression<int>? id,
    Expression<String>? dateKey,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? endDayCompleted,
    Expression<DateTime>? endDayCompletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dateKey != null) 'date_key': dateKey,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (endDayCompleted != null) 'end_day_completed': endDayCompleted,
      if (endDayCompletedAt != null) 'end_day_completed_at': endDayCompletedAt,
    });
  }

  DailyRecordsCompanion copyWith({
    Value<int>? id,
    Value<String>? dateKey,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? endDayCompleted,
    Value<DateTime?>? endDayCompletedAt,
  }) {
    return DailyRecordsCompanion(
      id: id ?? this.id,
      dateKey: dateKey ?? this.dateKey,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      endDayCompleted: endDayCompleted ?? this.endDayCompleted,
      endDayCompletedAt: endDayCompletedAt ?? this.endDayCompletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dateKey.present) {
      map['date_key'] = Variable<String>(dateKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (endDayCompleted.present) {
      map['end_day_completed'] = Variable<bool>(endDayCompleted.value);
    }
    if (endDayCompletedAt.present) {
      map['end_day_completed_at'] = Variable<DateTime>(endDayCompletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyRecordsCompanion(')
          ..write('id: $id, ')
          ..write('dateKey: $dateKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('endDayCompleted: $endDayCompleted, ')
          ..write('endDayCompletedAt: $endDayCompletedAt')
          ..write(')'))
        .toString();
  }
}

class $SleepLogsTable extends SleepLogs
    with TableInfo<$SleepLogsTable, SleepLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dailyRecordIdMeta = const VerificationMeta(
    'dailyRecordId',
  );
  @override
  late final GeneratedColumn<int> dailyRecordId = GeneratedColumn<int>(
    'daily_record_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES daily_records (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _bedtimeMeta = const VerificationMeta(
    'bedtime',
  );
  @override
  late final GeneratedColumn<DateTime> bedtime = GeneratedColumn<DateTime>(
    'bedtime',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wakeTimeMeta = const VerificationMeta(
    'wakeTime',
  );
  @override
  late final GeneratedColumn<DateTime> wakeTime = GeneratedColumn<DateTime>(
    'wake_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sleepOnsetAdjustmentMinutesMeta =
      const VerificationMeta('sleepOnsetAdjustmentMinutes');
  @override
  late final GeneratedColumn<int> sleepOnsetAdjustmentMinutes =
      GeneratedColumn<int>(
        'sleep_onset_adjustment_minutes',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _sleepLatencySourceMeta =
      const VerificationMeta('sleepLatencySource');
  @override
  late final GeneratedColumn<String> sleepLatencySource =
      GeneratedColumn<String>(
        'sleep_latency_source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('scientificEstimate'),
      );
  static const VerificationMeta _awakeningCountMeta = const VerificationMeta(
    'awakeningCount',
  );
  @override
  late final GeneratedColumn<int> awakeningCount = GeneratedColumn<int>(
    'awakening_count',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('awakening_count >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _awakeDuringNightMinutesMeta =
      const VerificationMeta('awakeDuringNightMinutes');
  @override
  late final GeneratedColumn<int> awakeDuringNightMinutes =
      GeneratedColumn<int>(
        'awake_during_night_minutes',
        aliasedName,
        false,
        check: () =>
            const CustomExpression<bool>('awake_during_night_minutes >= 0'),
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _calculatedDurationMinutesMeta =
      const VerificationMeta('calculatedDurationMinutes');
  @override
  late final GeneratedColumn<int> calculatedDurationMinutes =
      GeneratedColumn<int>(
        'calculated_duration_minutes',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _manualDurationMinutesMeta =
      const VerificationMeta('manualDurationMinutes');
  @override
  late final GeneratedColumn<int> manualDurationMinutes = GeneratedColumn<int>(
    'manual_duration_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sleepQualityMeta = const VerificationMeta(
    'sleepQuality',
  );
  @override
  late final GeneratedColumn<int> sleepQuality = GeneratedColumn<int>(
    'sleep_quality',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('sleep_quality BETWEEN 1 AND 5'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _energyMeta = const VerificationMeta('energy');
  @override
  late final GeneratedColumn<int> energy = GeneratedColumn<int>(
    'energy',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('energy BETWEEN 1 AND 5'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dailyRecordId,
    bedtime,
    wakeTime,
    sleepOnsetAdjustmentMinutes,
    sleepLatencySource,
    awakeningCount,
    awakeDuringNightMinutes,
    calculatedDurationMinutes,
    manualDurationMinutes,
    sleepQuality,
    energy,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('daily_record_id')) {
      context.handle(
        _dailyRecordIdMeta,
        dailyRecordId.isAcceptableOrUnknown(
          data['daily_record_id']!,
          _dailyRecordIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyRecordIdMeta);
    }
    if (data.containsKey('bedtime')) {
      context.handle(
        _bedtimeMeta,
        bedtime.isAcceptableOrUnknown(data['bedtime']!, _bedtimeMeta),
      );
    } else if (isInserting) {
      context.missing(_bedtimeMeta);
    }
    if (data.containsKey('wake_time')) {
      context.handle(
        _wakeTimeMeta,
        wakeTime.isAcceptableOrUnknown(data['wake_time']!, _wakeTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_wakeTimeMeta);
    }
    if (data.containsKey('sleep_onset_adjustment_minutes')) {
      context.handle(
        _sleepOnsetAdjustmentMinutesMeta,
        sleepOnsetAdjustmentMinutes.isAcceptableOrUnknown(
          data['sleep_onset_adjustment_minutes']!,
          _sleepOnsetAdjustmentMinutesMeta,
        ),
      );
    }
    if (data.containsKey('sleep_latency_source')) {
      context.handle(
        _sleepLatencySourceMeta,
        sleepLatencySource.isAcceptableOrUnknown(
          data['sleep_latency_source']!,
          _sleepLatencySourceMeta,
        ),
      );
    }
    if (data.containsKey('awakening_count')) {
      context.handle(
        _awakeningCountMeta,
        awakeningCount.isAcceptableOrUnknown(
          data['awakening_count']!,
          _awakeningCountMeta,
        ),
      );
    }
    if (data.containsKey('awake_during_night_minutes')) {
      context.handle(
        _awakeDuringNightMinutesMeta,
        awakeDuringNightMinutes.isAcceptableOrUnknown(
          data['awake_during_night_minutes']!,
          _awakeDuringNightMinutesMeta,
        ),
      );
    }
    if (data.containsKey('calculated_duration_minutes')) {
      context.handle(
        _calculatedDurationMinutesMeta,
        calculatedDurationMinutes.isAcceptableOrUnknown(
          data['calculated_duration_minutes']!,
          _calculatedDurationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_calculatedDurationMinutesMeta);
    }
    if (data.containsKey('manual_duration_minutes')) {
      context.handle(
        _manualDurationMinutesMeta,
        manualDurationMinutes.isAcceptableOrUnknown(
          data['manual_duration_minutes']!,
          _manualDurationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('sleep_quality')) {
      context.handle(
        _sleepQualityMeta,
        sleepQuality.isAcceptableOrUnknown(
          data['sleep_quality']!,
          _sleepQualityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sleepQualityMeta);
    }
    if (data.containsKey('energy')) {
      context.handle(
        _energyMeta,
        energy.isAcceptableOrUnknown(data['energy']!, _energyMeta),
      );
    } else if (isInserting) {
      context.missing(_energyMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dailyRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_record_id'],
      )!,
      bedtime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}bedtime'],
      )!,
      wakeTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}wake_time'],
      )!,
      sleepOnsetAdjustmentMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sleep_onset_adjustment_minutes'],
      )!,
      sleepLatencySource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sleep_latency_source'],
      )!,
      awakeningCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}awakening_count'],
      )!,
      awakeDuringNightMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}awake_during_night_minutes'],
      )!,
      calculatedDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calculated_duration_minutes'],
      )!,
      manualDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}manual_duration_minutes'],
      ),
      sleepQuality: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sleep_quality'],
      )!,
      energy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}energy'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SleepLogsTable createAlias(String alias) {
    return $SleepLogsTable(attachedDatabase, alias);
  }
}

class SleepLog extends DataClass implements Insertable<SleepLog> {
  final int id;
  final int dailyRecordId;
  final DateTime bedtime;
  final DateTime wakeTime;

  /// Estimated minutes between going to bed and falling asleep.
  ///
  /// Momentum currently applies a 15-minute scientific fallback. A future
  /// health-device value can replace it for an individual night.
  final int sleepOnsetAdjustmentMinutes;

  /// Identifies where the sleep-onset estimate came from.
  ///
  /// Initial value: scientificEstimate
  /// Future values: healthDevice or manual
  final String sleepLatencySource;

  /// Number of remembered awakenings during the night.
  final int awakeningCount;

  /// Total estimated minutes spent awake after initially falling asleep.
  final int awakeDuringNightMinutes;

  /// Bed-to-wake duration minus sleep latency and awake time.
  final int calculatedDurationMinutes;

  /// Optional future correction entered manually by the user.
  final int? manualDurationMinutes;
  final int sleepQuality;
  final int energy;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SleepLog({
    required this.id,
    required this.dailyRecordId,
    required this.bedtime,
    required this.wakeTime,
    required this.sleepOnsetAdjustmentMinutes,
    required this.sleepLatencySource,
    required this.awakeningCount,
    required this.awakeDuringNightMinutes,
    required this.calculatedDurationMinutes,
    this.manualDurationMinutes,
    required this.sleepQuality,
    required this.energy,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['daily_record_id'] = Variable<int>(dailyRecordId);
    map['bedtime'] = Variable<DateTime>(bedtime);
    map['wake_time'] = Variable<DateTime>(wakeTime);
    map['sleep_onset_adjustment_minutes'] = Variable<int>(
      sleepOnsetAdjustmentMinutes,
    );
    map['sleep_latency_source'] = Variable<String>(sleepLatencySource);
    map['awakening_count'] = Variable<int>(awakeningCount);
    map['awake_during_night_minutes'] = Variable<int>(awakeDuringNightMinutes);
    map['calculated_duration_minutes'] = Variable<int>(
      calculatedDurationMinutes,
    );
    if (!nullToAbsent || manualDurationMinutes != null) {
      map['manual_duration_minutes'] = Variable<int>(manualDurationMinutes);
    }
    map['sleep_quality'] = Variable<int>(sleepQuality);
    map['energy'] = Variable<int>(energy);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SleepLogsCompanion toCompanion(bool nullToAbsent) {
    return SleepLogsCompanion(
      id: Value(id),
      dailyRecordId: Value(dailyRecordId),
      bedtime: Value(bedtime),
      wakeTime: Value(wakeTime),
      sleepOnsetAdjustmentMinutes: Value(sleepOnsetAdjustmentMinutes),
      sleepLatencySource: Value(sleepLatencySource),
      awakeningCount: Value(awakeningCount),
      awakeDuringNightMinutes: Value(awakeDuringNightMinutes),
      calculatedDurationMinutes: Value(calculatedDurationMinutes),
      manualDurationMinutes: manualDurationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(manualDurationMinutes),
      sleepQuality: Value(sleepQuality),
      energy: Value(energy),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SleepLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepLog(
      id: serializer.fromJson<int>(json['id']),
      dailyRecordId: serializer.fromJson<int>(json['dailyRecordId']),
      bedtime: serializer.fromJson<DateTime>(json['bedtime']),
      wakeTime: serializer.fromJson<DateTime>(json['wakeTime']),
      sleepOnsetAdjustmentMinutes: serializer.fromJson<int>(
        json['sleepOnsetAdjustmentMinutes'],
      ),
      sleepLatencySource: serializer.fromJson<String>(
        json['sleepLatencySource'],
      ),
      awakeningCount: serializer.fromJson<int>(json['awakeningCount']),
      awakeDuringNightMinutes: serializer.fromJson<int>(
        json['awakeDuringNightMinutes'],
      ),
      calculatedDurationMinutes: serializer.fromJson<int>(
        json['calculatedDurationMinutes'],
      ),
      manualDurationMinutes: serializer.fromJson<int?>(
        json['manualDurationMinutes'],
      ),
      sleepQuality: serializer.fromJson<int>(json['sleepQuality']),
      energy: serializer.fromJson<int>(json['energy']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dailyRecordId': serializer.toJson<int>(dailyRecordId),
      'bedtime': serializer.toJson<DateTime>(bedtime),
      'wakeTime': serializer.toJson<DateTime>(wakeTime),
      'sleepOnsetAdjustmentMinutes': serializer.toJson<int>(
        sleepOnsetAdjustmentMinutes,
      ),
      'sleepLatencySource': serializer.toJson<String>(sleepLatencySource),
      'awakeningCount': serializer.toJson<int>(awakeningCount),
      'awakeDuringNightMinutes': serializer.toJson<int>(
        awakeDuringNightMinutes,
      ),
      'calculatedDurationMinutes': serializer.toJson<int>(
        calculatedDurationMinutes,
      ),
      'manualDurationMinutes': serializer.toJson<int?>(manualDurationMinutes),
      'sleepQuality': serializer.toJson<int>(sleepQuality),
      'energy': serializer.toJson<int>(energy),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SleepLog copyWith({
    int? id,
    int? dailyRecordId,
    DateTime? bedtime,
    DateTime? wakeTime,
    int? sleepOnsetAdjustmentMinutes,
    String? sleepLatencySource,
    int? awakeningCount,
    int? awakeDuringNightMinutes,
    int? calculatedDurationMinutes,
    Value<int?> manualDurationMinutes = const Value.absent(),
    int? sleepQuality,
    int? energy,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SleepLog(
    id: id ?? this.id,
    dailyRecordId: dailyRecordId ?? this.dailyRecordId,
    bedtime: bedtime ?? this.bedtime,
    wakeTime: wakeTime ?? this.wakeTime,
    sleepOnsetAdjustmentMinutes:
        sleepOnsetAdjustmentMinutes ?? this.sleepOnsetAdjustmentMinutes,
    sleepLatencySource: sleepLatencySource ?? this.sleepLatencySource,
    awakeningCount: awakeningCount ?? this.awakeningCount,
    awakeDuringNightMinutes:
        awakeDuringNightMinutes ?? this.awakeDuringNightMinutes,
    calculatedDurationMinutes:
        calculatedDurationMinutes ?? this.calculatedDurationMinutes,
    manualDurationMinutes: manualDurationMinutes.present
        ? manualDurationMinutes.value
        : this.manualDurationMinutes,
    sleepQuality: sleepQuality ?? this.sleepQuality,
    energy: energy ?? this.energy,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SleepLog copyWithCompanion(SleepLogsCompanion data) {
    return SleepLog(
      id: data.id.present ? data.id.value : this.id,
      dailyRecordId: data.dailyRecordId.present
          ? data.dailyRecordId.value
          : this.dailyRecordId,
      bedtime: data.bedtime.present ? data.bedtime.value : this.bedtime,
      wakeTime: data.wakeTime.present ? data.wakeTime.value : this.wakeTime,
      sleepOnsetAdjustmentMinutes: data.sleepOnsetAdjustmentMinutes.present
          ? data.sleepOnsetAdjustmentMinutes.value
          : this.sleepOnsetAdjustmentMinutes,
      sleepLatencySource: data.sleepLatencySource.present
          ? data.sleepLatencySource.value
          : this.sleepLatencySource,
      awakeningCount: data.awakeningCount.present
          ? data.awakeningCount.value
          : this.awakeningCount,
      awakeDuringNightMinutes: data.awakeDuringNightMinutes.present
          ? data.awakeDuringNightMinutes.value
          : this.awakeDuringNightMinutes,
      calculatedDurationMinutes: data.calculatedDurationMinutes.present
          ? data.calculatedDurationMinutes.value
          : this.calculatedDurationMinutes,
      manualDurationMinutes: data.manualDurationMinutes.present
          ? data.manualDurationMinutes.value
          : this.manualDurationMinutes,
      sleepQuality: data.sleepQuality.present
          ? data.sleepQuality.value
          : this.sleepQuality,
      energy: data.energy.present ? data.energy.value : this.energy,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepLog(')
          ..write('id: $id, ')
          ..write('dailyRecordId: $dailyRecordId, ')
          ..write('bedtime: $bedtime, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('sleepOnsetAdjustmentMinutes: $sleepOnsetAdjustmentMinutes, ')
          ..write('sleepLatencySource: $sleepLatencySource, ')
          ..write('awakeningCount: $awakeningCount, ')
          ..write('awakeDuringNightMinutes: $awakeDuringNightMinutes, ')
          ..write('calculatedDurationMinutes: $calculatedDurationMinutes, ')
          ..write('manualDurationMinutes: $manualDurationMinutes, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('energy: $energy, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    dailyRecordId,
    bedtime,
    wakeTime,
    sleepOnsetAdjustmentMinutes,
    sleepLatencySource,
    awakeningCount,
    awakeDuringNightMinutes,
    calculatedDurationMinutes,
    manualDurationMinutes,
    sleepQuality,
    energy,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepLog &&
          other.id == this.id &&
          other.dailyRecordId == this.dailyRecordId &&
          other.bedtime == this.bedtime &&
          other.wakeTime == this.wakeTime &&
          other.sleepOnsetAdjustmentMinutes ==
              this.sleepOnsetAdjustmentMinutes &&
          other.sleepLatencySource == this.sleepLatencySource &&
          other.awakeningCount == this.awakeningCount &&
          other.awakeDuringNightMinutes == this.awakeDuringNightMinutes &&
          other.calculatedDurationMinutes == this.calculatedDurationMinutes &&
          other.manualDurationMinutes == this.manualDurationMinutes &&
          other.sleepQuality == this.sleepQuality &&
          other.energy == this.energy &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SleepLogsCompanion extends UpdateCompanion<SleepLog> {
  final Value<int> id;
  final Value<int> dailyRecordId;
  final Value<DateTime> bedtime;
  final Value<DateTime> wakeTime;
  final Value<int> sleepOnsetAdjustmentMinutes;
  final Value<String> sleepLatencySource;
  final Value<int> awakeningCount;
  final Value<int> awakeDuringNightMinutes;
  final Value<int> calculatedDurationMinutes;
  final Value<int?> manualDurationMinutes;
  final Value<int> sleepQuality;
  final Value<int> energy;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SleepLogsCompanion({
    this.id = const Value.absent(),
    this.dailyRecordId = const Value.absent(),
    this.bedtime = const Value.absent(),
    this.wakeTime = const Value.absent(),
    this.sleepOnsetAdjustmentMinutes = const Value.absent(),
    this.sleepLatencySource = const Value.absent(),
    this.awakeningCount = const Value.absent(),
    this.awakeDuringNightMinutes = const Value.absent(),
    this.calculatedDurationMinutes = const Value.absent(),
    this.manualDurationMinutes = const Value.absent(),
    this.sleepQuality = const Value.absent(),
    this.energy = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SleepLogsCompanion.insert({
    this.id = const Value.absent(),
    required int dailyRecordId,
    required DateTime bedtime,
    required DateTime wakeTime,
    this.sleepOnsetAdjustmentMinutes = const Value.absent(),
    this.sleepLatencySource = const Value.absent(),
    this.awakeningCount = const Value.absent(),
    this.awakeDuringNightMinutes = const Value.absent(),
    required int calculatedDurationMinutes,
    this.manualDurationMinutes = const Value.absent(),
    required int sleepQuality,
    required int energy,
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : dailyRecordId = Value(dailyRecordId),
       bedtime = Value(bedtime),
       wakeTime = Value(wakeTime),
       calculatedDurationMinutes = Value(calculatedDurationMinutes),
       sleepQuality = Value(sleepQuality),
       energy = Value(energy);
  static Insertable<SleepLog> custom({
    Expression<int>? id,
    Expression<int>? dailyRecordId,
    Expression<DateTime>? bedtime,
    Expression<DateTime>? wakeTime,
    Expression<int>? sleepOnsetAdjustmentMinutes,
    Expression<String>? sleepLatencySource,
    Expression<int>? awakeningCount,
    Expression<int>? awakeDuringNightMinutes,
    Expression<int>? calculatedDurationMinutes,
    Expression<int>? manualDurationMinutes,
    Expression<int>? sleepQuality,
    Expression<int>? energy,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dailyRecordId != null) 'daily_record_id': dailyRecordId,
      if (bedtime != null) 'bedtime': bedtime,
      if (wakeTime != null) 'wake_time': wakeTime,
      if (sleepOnsetAdjustmentMinutes != null)
        'sleep_onset_adjustment_minutes': sleepOnsetAdjustmentMinutes,
      if (sleepLatencySource != null)
        'sleep_latency_source': sleepLatencySource,
      if (awakeningCount != null) 'awakening_count': awakeningCount,
      if (awakeDuringNightMinutes != null)
        'awake_during_night_minutes': awakeDuringNightMinutes,
      if (calculatedDurationMinutes != null)
        'calculated_duration_minutes': calculatedDurationMinutes,
      if (manualDurationMinutes != null)
        'manual_duration_minutes': manualDurationMinutes,
      if (sleepQuality != null) 'sleep_quality': sleepQuality,
      if (energy != null) 'energy': energy,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SleepLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? dailyRecordId,
    Value<DateTime>? bedtime,
    Value<DateTime>? wakeTime,
    Value<int>? sleepOnsetAdjustmentMinutes,
    Value<String>? sleepLatencySource,
    Value<int>? awakeningCount,
    Value<int>? awakeDuringNightMinutes,
    Value<int>? calculatedDurationMinutes,
    Value<int?>? manualDurationMinutes,
    Value<int>? sleepQuality,
    Value<int>? energy,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SleepLogsCompanion(
      id: id ?? this.id,
      dailyRecordId: dailyRecordId ?? this.dailyRecordId,
      bedtime: bedtime ?? this.bedtime,
      wakeTime: wakeTime ?? this.wakeTime,
      sleepOnsetAdjustmentMinutes:
          sleepOnsetAdjustmentMinutes ?? this.sleepOnsetAdjustmentMinutes,
      sleepLatencySource: sleepLatencySource ?? this.sleepLatencySource,
      awakeningCount: awakeningCount ?? this.awakeningCount,
      awakeDuringNightMinutes:
          awakeDuringNightMinutes ?? this.awakeDuringNightMinutes,
      calculatedDurationMinutes:
          calculatedDurationMinutes ?? this.calculatedDurationMinutes,
      manualDurationMinutes:
          manualDurationMinutes ?? this.manualDurationMinutes,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      energy: energy ?? this.energy,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dailyRecordId.present) {
      map['daily_record_id'] = Variable<int>(dailyRecordId.value);
    }
    if (bedtime.present) {
      map['bedtime'] = Variable<DateTime>(bedtime.value);
    }
    if (wakeTime.present) {
      map['wake_time'] = Variable<DateTime>(wakeTime.value);
    }
    if (sleepOnsetAdjustmentMinutes.present) {
      map['sleep_onset_adjustment_minutes'] = Variable<int>(
        sleepOnsetAdjustmentMinutes.value,
      );
    }
    if (sleepLatencySource.present) {
      map['sleep_latency_source'] = Variable<String>(sleepLatencySource.value);
    }
    if (awakeningCount.present) {
      map['awakening_count'] = Variable<int>(awakeningCount.value);
    }
    if (awakeDuringNightMinutes.present) {
      map['awake_during_night_minutes'] = Variable<int>(
        awakeDuringNightMinutes.value,
      );
    }
    if (calculatedDurationMinutes.present) {
      map['calculated_duration_minutes'] = Variable<int>(
        calculatedDurationMinutes.value,
      );
    }
    if (manualDurationMinutes.present) {
      map['manual_duration_minutes'] = Variable<int>(
        manualDurationMinutes.value,
      );
    }
    if (sleepQuality.present) {
      map['sleep_quality'] = Variable<int>(sleepQuality.value);
    }
    if (energy.present) {
      map['energy'] = Variable<int>(energy.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepLogsCompanion(')
          ..write('id: $id, ')
          ..write('dailyRecordId: $dailyRecordId, ')
          ..write('bedtime: $bedtime, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('sleepOnsetAdjustmentMinutes: $sleepOnsetAdjustmentMinutes, ')
          ..write('sleepLatencySource: $sleepLatencySource, ')
          ..write('awakeningCount: $awakeningCount, ')
          ..write('awakeDuringNightMinutes: $awakeDuringNightMinutes, ')
          ..write('calculatedDurationMinutes: $calculatedDurationMinutes, ')
          ..write('manualDurationMinutes: $manualDurationMinutes, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('energy: $energy, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $NapLogsTable extends NapLogs with TableInfo<$NapLogsTable, NapLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NapLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dailyRecordIdMeta = const VerificationMeta(
    'dailyRecordId',
  );
  @override
  late final GeneratedColumn<int> dailyRecordId = GeneratedColumn<int>(
    'daily_record_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES daily_records (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('duration_minutes > 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _didSleepMeta = const VerificationMeta(
    'didSleep',
  );
  @override
  late final GeneratedColumn<String> didSleep = GeneratedColumn<String>(
    'did_sleep',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _napTypeMeta = const VerificationMeta(
    'napType',
  );
  @override
  late final GeneratedColumn<String> napType = GeneratedColumn<String>(
    'nap_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wakeFeelingMeta = const VerificationMeta(
    'wakeFeeling',
  );
  @override
  late final GeneratedColumn<int> wakeFeeling = GeneratedColumn<int>(
    'wake_feeling',
    aliasedName,
    true,
    check: () => const CustomExpression<bool>(
      'wake_feeling IS NULL OR wake_feeling BETWEEN 1 AND 5',
    ),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _qualityMeta = const VerificationMeta(
    'quality',
  );
  @override
  late final GeneratedColumn<int> quality = GeneratedColumn<int>(
    'quality',
    aliasedName,
    true,
    check: () => const CustomExpression<bool>(
      'quality IS NULL OR quality BETWEEN 1 AND 5',
    ),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dailyRecordId,
    startTime,
    durationMinutes,
    didSleep,
    napType,
    wakeFeeling,
    quality,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nap_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<NapLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('daily_record_id')) {
      context.handle(
        _dailyRecordIdMeta,
        dailyRecordId.isAcceptableOrUnknown(
          data['daily_record_id']!,
          _dailyRecordIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyRecordIdMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('did_sleep')) {
      context.handle(
        _didSleepMeta,
        didSleep.isAcceptableOrUnknown(data['did_sleep']!, _didSleepMeta),
      );
    }
    if (data.containsKey('nap_type')) {
      context.handle(
        _napTypeMeta,
        napType.isAcceptableOrUnknown(data['nap_type']!, _napTypeMeta),
      );
    }
    if (data.containsKey('wake_feeling')) {
      context.handle(
        _wakeFeelingMeta,
        wakeFeeling.isAcceptableOrUnknown(
          data['wake_feeling']!,
          _wakeFeelingMeta,
        ),
      );
    }
    if (data.containsKey('quality')) {
      context.handle(
        _qualityMeta,
        quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NapLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NapLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dailyRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_record_id'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      didSleep: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}did_sleep'],
      ),
      napType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nap_type'],
      ),
      wakeFeeling: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wake_feeling'],
      ),
      quality: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quality'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NapLogsTable createAlias(String alias) {
    return $NapLogsTable(attachedDatabase, alias);
  }
}

class NapLog extends DataClass implements Insertable<NapLog> {
  final int id;
  final int dailyRecordId;
  final DateTime startTime;
  final int durationMinutes;

  /// Whether the user believes they actually slept: yes, no, or unsure.
  final String? didSleep;

  /// planned, unplanned, or involuntary.
  final String? napType;

  /// How the user felt after waking, from 1 (terrible) to 5 (energised).
  final int? wakeFeeling;

  /// Legacy nap-quality value retained for schema compatibility.
  final int? quality;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const NapLog({
    required this.id,
    required this.dailyRecordId,
    required this.startTime,
    required this.durationMinutes,
    this.didSleep,
    this.napType,
    this.wakeFeeling,
    this.quality,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['daily_record_id'] = Variable<int>(dailyRecordId);
    map['start_time'] = Variable<DateTime>(startTime);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    if (!nullToAbsent || didSleep != null) {
      map['did_sleep'] = Variable<String>(didSleep);
    }
    if (!nullToAbsent || napType != null) {
      map['nap_type'] = Variable<String>(napType);
    }
    if (!nullToAbsent || wakeFeeling != null) {
      map['wake_feeling'] = Variable<int>(wakeFeeling);
    }
    if (!nullToAbsent || quality != null) {
      map['quality'] = Variable<int>(quality);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NapLogsCompanion toCompanion(bool nullToAbsent) {
    return NapLogsCompanion(
      id: Value(id),
      dailyRecordId: Value(dailyRecordId),
      startTime: Value(startTime),
      durationMinutes: Value(durationMinutes),
      didSleep: didSleep == null && nullToAbsent
          ? const Value.absent()
          : Value(didSleep),
      napType: napType == null && nullToAbsent
          ? const Value.absent()
          : Value(napType),
      wakeFeeling: wakeFeeling == null && nullToAbsent
          ? const Value.absent()
          : Value(wakeFeeling),
      quality: quality == null && nullToAbsent
          ? const Value.absent()
          : Value(quality),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory NapLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NapLog(
      id: serializer.fromJson<int>(json['id']),
      dailyRecordId: serializer.fromJson<int>(json['dailyRecordId']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      didSleep: serializer.fromJson<String?>(json['didSleep']),
      napType: serializer.fromJson<String?>(json['napType']),
      wakeFeeling: serializer.fromJson<int?>(json['wakeFeeling']),
      quality: serializer.fromJson<int?>(json['quality']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dailyRecordId': serializer.toJson<int>(dailyRecordId),
      'startTime': serializer.toJson<DateTime>(startTime),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'didSleep': serializer.toJson<String?>(didSleep),
      'napType': serializer.toJson<String?>(napType),
      'wakeFeeling': serializer.toJson<int?>(wakeFeeling),
      'quality': serializer.toJson<int?>(quality),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NapLog copyWith({
    int? id,
    int? dailyRecordId,
    DateTime? startTime,
    int? durationMinutes,
    Value<String?> didSleep = const Value.absent(),
    Value<String?> napType = const Value.absent(),
    Value<int?> wakeFeeling = const Value.absent(),
    Value<int?> quality = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => NapLog(
    id: id ?? this.id,
    dailyRecordId: dailyRecordId ?? this.dailyRecordId,
    startTime: startTime ?? this.startTime,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    didSleep: didSleep.present ? didSleep.value : this.didSleep,
    napType: napType.present ? napType.value : this.napType,
    wakeFeeling: wakeFeeling.present ? wakeFeeling.value : this.wakeFeeling,
    quality: quality.present ? quality.value : this.quality,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NapLog copyWithCompanion(NapLogsCompanion data) {
    return NapLog(
      id: data.id.present ? data.id.value : this.id,
      dailyRecordId: data.dailyRecordId.present
          ? data.dailyRecordId.value
          : this.dailyRecordId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      didSleep: data.didSleep.present ? data.didSleep.value : this.didSleep,
      napType: data.napType.present ? data.napType.value : this.napType,
      wakeFeeling: data.wakeFeeling.present
          ? data.wakeFeeling.value
          : this.wakeFeeling,
      quality: data.quality.present ? data.quality.value : this.quality,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NapLog(')
          ..write('id: $id, ')
          ..write('dailyRecordId: $dailyRecordId, ')
          ..write('startTime: $startTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('didSleep: $didSleep, ')
          ..write('napType: $napType, ')
          ..write('wakeFeeling: $wakeFeeling, ')
          ..write('quality: $quality, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    dailyRecordId,
    startTime,
    durationMinutes,
    didSleep,
    napType,
    wakeFeeling,
    quality,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NapLog &&
          other.id == this.id &&
          other.dailyRecordId == this.dailyRecordId &&
          other.startTime == this.startTime &&
          other.durationMinutes == this.durationMinutes &&
          other.didSleep == this.didSleep &&
          other.napType == this.napType &&
          other.wakeFeeling == this.wakeFeeling &&
          other.quality == this.quality &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NapLogsCompanion extends UpdateCompanion<NapLog> {
  final Value<int> id;
  final Value<int> dailyRecordId;
  final Value<DateTime> startTime;
  final Value<int> durationMinutes;
  final Value<String?> didSleep;
  final Value<String?> napType;
  final Value<int?> wakeFeeling;
  final Value<int?> quality;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const NapLogsCompanion({
    this.id = const Value.absent(),
    this.dailyRecordId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.didSleep = const Value.absent(),
    this.napType = const Value.absent(),
    this.wakeFeeling = const Value.absent(),
    this.quality = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NapLogsCompanion.insert({
    this.id = const Value.absent(),
    required int dailyRecordId,
    required DateTime startTime,
    required int durationMinutes,
    this.didSleep = const Value.absent(),
    this.napType = const Value.absent(),
    this.wakeFeeling = const Value.absent(),
    this.quality = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : dailyRecordId = Value(dailyRecordId),
       startTime = Value(startTime),
       durationMinutes = Value(durationMinutes);
  static Insertable<NapLog> custom({
    Expression<int>? id,
    Expression<int>? dailyRecordId,
    Expression<DateTime>? startTime,
    Expression<int>? durationMinutes,
    Expression<String>? didSleep,
    Expression<String>? napType,
    Expression<int>? wakeFeeling,
    Expression<int>? quality,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dailyRecordId != null) 'daily_record_id': dailyRecordId,
      if (startTime != null) 'start_time': startTime,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (didSleep != null) 'did_sleep': didSleep,
      if (napType != null) 'nap_type': napType,
      if (wakeFeeling != null) 'wake_feeling': wakeFeeling,
      if (quality != null) 'quality': quality,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NapLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? dailyRecordId,
    Value<DateTime>? startTime,
    Value<int>? durationMinutes,
    Value<String?>? didSleep,
    Value<String?>? napType,
    Value<int?>? wakeFeeling,
    Value<int?>? quality,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return NapLogsCompanion(
      id: id ?? this.id,
      dailyRecordId: dailyRecordId ?? this.dailyRecordId,
      startTime: startTime ?? this.startTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      didSleep: didSleep ?? this.didSleep,
      napType: napType ?? this.napType,
      wakeFeeling: wakeFeeling ?? this.wakeFeeling,
      quality: quality ?? this.quality,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dailyRecordId.present) {
      map['daily_record_id'] = Variable<int>(dailyRecordId.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (didSleep.present) {
      map['did_sleep'] = Variable<String>(didSleep.value);
    }
    if (napType.present) {
      map['nap_type'] = Variable<String>(napType.value);
    }
    if (wakeFeeling.present) {
      map['wake_feeling'] = Variable<int>(wakeFeeling.value);
    }
    if (quality.present) {
      map['quality'] = Variable<int>(quality.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NapLogsCompanion(')
          ..write('id: $id, ')
          ..write('dailyRecordId: $dailyRecordId, ')
          ..write('startTime: $startTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('didSleep: $didSleep, ')
          ..write('napType: $napType, ')
          ..write('wakeFeeling: $wakeFeeling, ')
          ..write('quality: $quality, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CareLogsTable extends CareLogs with TableInfo<$CareLogsTable, CareLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CareLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dailyRecordIdMeta = const VerificationMeta(
    'dailyRecordId',
  );
  @override
  late final GeneratedColumn<int> dailyRecordId = GeneratedColumn<int>(
    'daily_record_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES daily_records (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _moodScoreMeta = const VerificationMeta(
    'moodScore',
  );
  @override
  late final GeneratedColumn<int> moodScore = GeneratedColumn<int>(
    'mood_score',
    aliasedName,
    true,
    check: () => const CustomExpression<bool>(
      'mood_score IS NULL OR mood_score BETWEEN 1 AND 5',
    ),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _moodNotesMeta = const VerificationMeta(
    'moodNotes',
  );
  @override
  late final GeneratedColumn<String> moodNotes = GeneratedColumn<String>(
    'mood_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _energyLevelMeta = const VerificationMeta(
    'energyLevel',
  );
  @override
  late final GeneratedColumn<String> energyLevel = GeneratedColumn<String>(
    'energy_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dailyRecordId,
    moodScore,
    moodNotes,
    energyLevel,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'care_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<CareLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('daily_record_id')) {
      context.handle(
        _dailyRecordIdMeta,
        dailyRecordId.isAcceptableOrUnknown(
          data['daily_record_id']!,
          _dailyRecordIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyRecordIdMeta);
    }
    if (data.containsKey('mood_score')) {
      context.handle(
        _moodScoreMeta,
        moodScore.isAcceptableOrUnknown(data['mood_score']!, _moodScoreMeta),
      );
    }
    if (data.containsKey('mood_notes')) {
      context.handle(
        _moodNotesMeta,
        moodNotes.isAcceptableOrUnknown(data['mood_notes']!, _moodNotesMeta),
      );
    }
    if (data.containsKey('energy_level')) {
      context.handle(
        _energyLevelMeta,
        energyLevel.isAcceptableOrUnknown(
          data['energy_level']!,
          _energyLevelMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CareLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CareLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dailyRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_record_id'],
      )!,
      moodScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mood_score'],
      ),
      moodNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood_notes'],
      ),
      energyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}energy_level'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CareLogsTable createAlias(String alias) {
    return $CareLogsTable(attachedDatabase, alias);
  }
}

class CareLog extends DataClass implements Insertable<CareLog> {
  final int id;
  final int dailyRecordId;
  final int? moodScore;
  final String? moodNotes;

  /// Retained temporarily for migration compatibility. New energy entries live
  /// in EnergyLogs and this value is no longer written by the Care feature.
  final String? energyLevel;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CareLog({
    required this.id,
    required this.dailyRecordId,
    this.moodScore,
    this.moodNotes,
    this.energyLevel,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['daily_record_id'] = Variable<int>(dailyRecordId);
    if (!nullToAbsent || moodScore != null) {
      map['mood_score'] = Variable<int>(moodScore);
    }
    if (!nullToAbsent || moodNotes != null) {
      map['mood_notes'] = Variable<String>(moodNotes);
    }
    if (!nullToAbsent || energyLevel != null) {
      map['energy_level'] = Variable<String>(energyLevel);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CareLogsCompanion toCompanion(bool nullToAbsent) {
    return CareLogsCompanion(
      id: Value(id),
      dailyRecordId: Value(dailyRecordId),
      moodScore: moodScore == null && nullToAbsent
          ? const Value.absent()
          : Value(moodScore),
      moodNotes: moodNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(moodNotes),
      energyLevel: energyLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(energyLevel),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CareLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CareLog(
      id: serializer.fromJson<int>(json['id']),
      dailyRecordId: serializer.fromJson<int>(json['dailyRecordId']),
      moodScore: serializer.fromJson<int?>(json['moodScore']),
      moodNotes: serializer.fromJson<String?>(json['moodNotes']),
      energyLevel: serializer.fromJson<String?>(json['energyLevel']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dailyRecordId': serializer.toJson<int>(dailyRecordId),
      'moodScore': serializer.toJson<int?>(moodScore),
      'moodNotes': serializer.toJson<String?>(moodNotes),
      'energyLevel': serializer.toJson<String?>(energyLevel),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CareLog copyWith({
    int? id,
    int? dailyRecordId,
    Value<int?> moodScore = const Value.absent(),
    Value<String?> moodNotes = const Value.absent(),
    Value<String?> energyLevel = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CareLog(
    id: id ?? this.id,
    dailyRecordId: dailyRecordId ?? this.dailyRecordId,
    moodScore: moodScore.present ? moodScore.value : this.moodScore,
    moodNotes: moodNotes.present ? moodNotes.value : this.moodNotes,
    energyLevel: energyLevel.present ? energyLevel.value : this.energyLevel,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CareLog copyWithCompanion(CareLogsCompanion data) {
    return CareLog(
      id: data.id.present ? data.id.value : this.id,
      dailyRecordId: data.dailyRecordId.present
          ? data.dailyRecordId.value
          : this.dailyRecordId,
      moodScore: data.moodScore.present ? data.moodScore.value : this.moodScore,
      moodNotes: data.moodNotes.present ? data.moodNotes.value : this.moodNotes,
      energyLevel: data.energyLevel.present
          ? data.energyLevel.value
          : this.energyLevel,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CareLog(')
          ..write('id: $id, ')
          ..write('dailyRecordId: $dailyRecordId, ')
          ..write('moodScore: $moodScore, ')
          ..write('moodNotes: $moodNotes, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    dailyRecordId,
    moodScore,
    moodNotes,
    energyLevel,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CareLog &&
          other.id == this.id &&
          other.dailyRecordId == this.dailyRecordId &&
          other.moodScore == this.moodScore &&
          other.moodNotes == this.moodNotes &&
          other.energyLevel == this.energyLevel &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CareLogsCompanion extends UpdateCompanion<CareLog> {
  final Value<int> id;
  final Value<int> dailyRecordId;
  final Value<int?> moodScore;
  final Value<String?> moodNotes;
  final Value<String?> energyLevel;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CareLogsCompanion({
    this.id = const Value.absent(),
    this.dailyRecordId = const Value.absent(),
    this.moodScore = const Value.absent(),
    this.moodNotes = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CareLogsCompanion.insert({
    this.id = const Value.absent(),
    required int dailyRecordId,
    this.moodScore = const Value.absent(),
    this.moodNotes = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : dailyRecordId = Value(dailyRecordId);
  static Insertable<CareLog> custom({
    Expression<int>? id,
    Expression<int>? dailyRecordId,
    Expression<int>? moodScore,
    Expression<String>? moodNotes,
    Expression<String>? energyLevel,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dailyRecordId != null) 'daily_record_id': dailyRecordId,
      if (moodScore != null) 'mood_score': moodScore,
      if (moodNotes != null) 'mood_notes': moodNotes,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CareLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? dailyRecordId,
    Value<int?>? moodScore,
    Value<String?>? moodNotes,
    Value<String?>? energyLevel,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CareLogsCompanion(
      id: id ?? this.id,
      dailyRecordId: dailyRecordId ?? this.dailyRecordId,
      moodScore: moodScore ?? this.moodScore,
      moodNotes: moodNotes ?? this.moodNotes,
      energyLevel: energyLevel ?? this.energyLevel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dailyRecordId.present) {
      map['daily_record_id'] = Variable<int>(dailyRecordId.value);
    }
    if (moodScore.present) {
      map['mood_score'] = Variable<int>(moodScore.value);
    }
    if (moodNotes.present) {
      map['mood_notes'] = Variable<String>(moodNotes.value);
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<String>(energyLevel.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CareLogsCompanion(')
          ..write('id: $id, ')
          ..write('dailyRecordId: $dailyRecordId, ')
          ..write('moodScore: $moodScore, ')
          ..write('moodNotes: $moodNotes, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $EnergyLogsTable extends EnergyLogs
    with TableInfo<$EnergyLogsTable, EnergyLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EnergyLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dailyRecordIdMeta = const VerificationMeta(
    'dailyRecordId',
  );
  @override
  late final GeneratedColumn<int> dailyRecordId = GeneratedColumn<int>(
    'daily_record_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES daily_records (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _energyLevelMeta = const VerificationMeta(
    'energyLevel',
  );
  @override
  late final GeneratedColumn<String> energyLevel = GeneratedColumn<String>(
    'energy_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dailyRecordId,
    energyLevel,
    recordedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'energy_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<EnergyLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('daily_record_id')) {
      context.handle(
        _dailyRecordIdMeta,
        dailyRecordId.isAcceptableOrUnknown(
          data['daily_record_id']!,
          _dailyRecordIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyRecordIdMeta);
    }
    if (data.containsKey('energy_level')) {
      context.handle(
        _energyLevelMeta,
        energyLevel.isAcceptableOrUnknown(
          data['energy_level']!,
          _energyLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_energyLevelMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EnergyLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EnergyLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dailyRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_record_id'],
      )!,
      energyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}energy_level'],
      )!,
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $EnergyLogsTable createAlias(String alias) {
    return $EnergyLogsTable(attachedDatabase, alias);
  }
}

class EnergyLog extends DataClass implements Insertable<EnergyLog> {
  final int id;
  final int dailyRecordId;

  /// drained, flat, okay, good, or energised.
  final String energyLevel;
  final DateTime recordedAt;
  final DateTime createdAt;
  const EnergyLog({
    required this.id,
    required this.dailyRecordId,
    required this.energyLevel,
    required this.recordedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['daily_record_id'] = Variable<int>(dailyRecordId);
    map['energy_level'] = Variable<String>(energyLevel);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EnergyLogsCompanion toCompanion(bool nullToAbsent) {
    return EnergyLogsCompanion(
      id: Value(id),
      dailyRecordId: Value(dailyRecordId),
      energyLevel: Value(energyLevel),
      recordedAt: Value(recordedAt),
      createdAt: Value(createdAt),
    );
  }

  factory EnergyLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EnergyLog(
      id: serializer.fromJson<int>(json['id']),
      dailyRecordId: serializer.fromJson<int>(json['dailyRecordId']),
      energyLevel: serializer.fromJson<String>(json['energyLevel']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dailyRecordId': serializer.toJson<int>(dailyRecordId),
      'energyLevel': serializer.toJson<String>(energyLevel),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  EnergyLog copyWith({
    int? id,
    int? dailyRecordId,
    String? energyLevel,
    DateTime? recordedAt,
    DateTime? createdAt,
  }) => EnergyLog(
    id: id ?? this.id,
    dailyRecordId: dailyRecordId ?? this.dailyRecordId,
    energyLevel: energyLevel ?? this.energyLevel,
    recordedAt: recordedAt ?? this.recordedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  EnergyLog copyWithCompanion(EnergyLogsCompanion data) {
    return EnergyLog(
      id: data.id.present ? data.id.value : this.id,
      dailyRecordId: data.dailyRecordId.present
          ? data.dailyRecordId.value
          : this.dailyRecordId,
      energyLevel: data.energyLevel.present
          ? data.energyLevel.value
          : this.energyLevel,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EnergyLog(')
          ..write('id: $id, ')
          ..write('dailyRecordId: $dailyRecordId, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, dailyRecordId, energyLevel, recordedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EnergyLog &&
          other.id == this.id &&
          other.dailyRecordId == this.dailyRecordId &&
          other.energyLevel == this.energyLevel &&
          other.recordedAt == this.recordedAt &&
          other.createdAt == this.createdAt);
}

class EnergyLogsCompanion extends UpdateCompanion<EnergyLog> {
  final Value<int> id;
  final Value<int> dailyRecordId;
  final Value<String> energyLevel;
  final Value<DateTime> recordedAt;
  final Value<DateTime> createdAt;
  const EnergyLogsCompanion({
    this.id = const Value.absent(),
    this.dailyRecordId = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  EnergyLogsCompanion.insert({
    this.id = const Value.absent(),
    required int dailyRecordId,
    required String energyLevel,
    required DateTime recordedAt,
    this.createdAt = const Value.absent(),
  }) : dailyRecordId = Value(dailyRecordId),
       energyLevel = Value(energyLevel),
       recordedAt = Value(recordedAt);
  static Insertable<EnergyLog> custom({
    Expression<int>? id,
    Expression<int>? dailyRecordId,
    Expression<String>? energyLevel,
    Expression<DateTime>? recordedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dailyRecordId != null) 'daily_record_id': dailyRecordId,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  EnergyLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? dailyRecordId,
    Value<String>? energyLevel,
    Value<DateTime>? recordedAt,
    Value<DateTime>? createdAt,
  }) {
    return EnergyLogsCompanion(
      id: id ?? this.id,
      dailyRecordId: dailyRecordId ?? this.dailyRecordId,
      energyLevel: energyLevel ?? this.energyLevel,
      recordedAt: recordedAt ?? this.recordedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dailyRecordId.present) {
      map['daily_record_id'] = Variable<int>(dailyRecordId.value);
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<String>(energyLevel.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EnergyLogsCompanion(')
          ..write('id: $id, ')
          ..write('dailyRecordId: $dailyRecordId, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $HomeCareCompletionsTable extends HomeCareCompletions
    with TableInfo<$HomeCareCompletionsTable, HomeCareCompletion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HomeCareCompletionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dailyRecordIdMeta = const VerificationMeta(
    'dailyRecordId',
  );
  @override
  late final GeneratedColumn<int> dailyRecordId = GeneratedColumn<int>(
    'daily_record_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES daily_records (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _taskKeyMeta = const VerificationMeta(
    'taskKey',
  );
  @override
  late final GeneratedColumn<String> taskKey = GeneratedColumn<String>(
    'task_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskTitleMeta = const VerificationMeta(
    'taskTitle',
  );
  @override
  late final GeneratedColumn<String> taskTitle = GeneratedColumn<String>(
    'task_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _energyLevelMeta = const VerificationMeta(
    'energyLevel',
  );
  @override
  late final GeneratedColumn<String> energyLevel = GeneratedColumn<String>(
    'energy_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _energyAtCompletionMeta =
      const VerificationMeta('energyAtCompletion');
  @override
  late final GeneratedColumn<String> energyAtCompletion =
      GeneratedColumn<String>(
        'energy_at_completion',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dailyRecordId,
    taskKey,
    taskTitle,
    energyLevel,
    energyAtCompletion,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'home_care_completions';
  @override
  VerificationContext validateIntegrity(
    Insertable<HomeCareCompletion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('daily_record_id')) {
      context.handle(
        _dailyRecordIdMeta,
        dailyRecordId.isAcceptableOrUnknown(
          data['daily_record_id']!,
          _dailyRecordIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyRecordIdMeta);
    }
    if (data.containsKey('task_key')) {
      context.handle(
        _taskKeyMeta,
        taskKey.isAcceptableOrUnknown(data['task_key']!, _taskKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_taskKeyMeta);
    }
    if (data.containsKey('task_title')) {
      context.handle(
        _taskTitleMeta,
        taskTitle.isAcceptableOrUnknown(data['task_title']!, _taskTitleMeta),
      );
    } else if (isInserting) {
      context.missing(_taskTitleMeta);
    }
    if (data.containsKey('energy_level')) {
      context.handle(
        _energyLevelMeta,
        energyLevel.isAcceptableOrUnknown(
          data['energy_level']!,
          _energyLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_energyLevelMeta);
    }
    if (data.containsKey('energy_at_completion')) {
      context.handle(
        _energyAtCompletionMeta,
        energyAtCompletion.isAcceptableOrUnknown(
          data['energy_at_completion']!,
          _energyAtCompletionMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {dailyRecordId, taskKey},
  ];
  @override
  HomeCareCompletion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HomeCareCompletion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dailyRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_record_id'],
      )!,
      taskKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_key'],
      )!,
      taskTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_title'],
      )!,
      energyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}energy_level'],
      )!,
      energyAtCompletion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}energy_at_completion'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
    );
  }

  @override
  $HomeCareCompletionsTable createAlias(String alias) {
    return $HomeCareCompletionsTable(attachedDatabase, alias);
  }
}

class HomeCareCompletion extends DataClass
    implements Insertable<HomeCareCompletion> {
  final int id;
  final int dailyRecordId;
  final String taskKey;
  final String taskTitle;

  /// The Red/Yellow/Green recommendation list this task belongs to.
  final String energyLevel;

  /// The user's current five-level energy when the task was completed.
  final String? energyAtCompletion;
  final DateTime completedAt;
  const HomeCareCompletion({
    required this.id,
    required this.dailyRecordId,
    required this.taskKey,
    required this.taskTitle,
    required this.energyLevel,
    this.energyAtCompletion,
    required this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['daily_record_id'] = Variable<int>(dailyRecordId);
    map['task_key'] = Variable<String>(taskKey);
    map['task_title'] = Variable<String>(taskTitle);
    map['energy_level'] = Variable<String>(energyLevel);
    if (!nullToAbsent || energyAtCompletion != null) {
      map['energy_at_completion'] = Variable<String>(energyAtCompletion);
    }
    map['completed_at'] = Variable<DateTime>(completedAt);
    return map;
  }

  HomeCareCompletionsCompanion toCompanion(bool nullToAbsent) {
    return HomeCareCompletionsCompanion(
      id: Value(id),
      dailyRecordId: Value(dailyRecordId),
      taskKey: Value(taskKey),
      taskTitle: Value(taskTitle),
      energyLevel: Value(energyLevel),
      energyAtCompletion: energyAtCompletion == null && nullToAbsent
          ? const Value.absent()
          : Value(energyAtCompletion),
      completedAt: Value(completedAt),
    );
  }

  factory HomeCareCompletion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HomeCareCompletion(
      id: serializer.fromJson<int>(json['id']),
      dailyRecordId: serializer.fromJson<int>(json['dailyRecordId']),
      taskKey: serializer.fromJson<String>(json['taskKey']),
      taskTitle: serializer.fromJson<String>(json['taskTitle']),
      energyLevel: serializer.fromJson<String>(json['energyLevel']),
      energyAtCompletion: serializer.fromJson<String?>(
        json['energyAtCompletion'],
      ),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dailyRecordId': serializer.toJson<int>(dailyRecordId),
      'taskKey': serializer.toJson<String>(taskKey),
      'taskTitle': serializer.toJson<String>(taskTitle),
      'energyLevel': serializer.toJson<String>(energyLevel),
      'energyAtCompletion': serializer.toJson<String?>(energyAtCompletion),
      'completedAt': serializer.toJson<DateTime>(completedAt),
    };
  }

  HomeCareCompletion copyWith({
    int? id,
    int? dailyRecordId,
    String? taskKey,
    String? taskTitle,
    String? energyLevel,
    Value<String?> energyAtCompletion = const Value.absent(),
    DateTime? completedAt,
  }) => HomeCareCompletion(
    id: id ?? this.id,
    dailyRecordId: dailyRecordId ?? this.dailyRecordId,
    taskKey: taskKey ?? this.taskKey,
    taskTitle: taskTitle ?? this.taskTitle,
    energyLevel: energyLevel ?? this.energyLevel,
    energyAtCompletion: energyAtCompletion.present
        ? energyAtCompletion.value
        : this.energyAtCompletion,
    completedAt: completedAt ?? this.completedAt,
  );
  HomeCareCompletion copyWithCompanion(HomeCareCompletionsCompanion data) {
    return HomeCareCompletion(
      id: data.id.present ? data.id.value : this.id,
      dailyRecordId: data.dailyRecordId.present
          ? data.dailyRecordId.value
          : this.dailyRecordId,
      taskKey: data.taskKey.present ? data.taskKey.value : this.taskKey,
      taskTitle: data.taskTitle.present ? data.taskTitle.value : this.taskTitle,
      energyLevel: data.energyLevel.present
          ? data.energyLevel.value
          : this.energyLevel,
      energyAtCompletion: data.energyAtCompletion.present
          ? data.energyAtCompletion.value
          : this.energyAtCompletion,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HomeCareCompletion(')
          ..write('id: $id, ')
          ..write('dailyRecordId: $dailyRecordId, ')
          ..write('taskKey: $taskKey, ')
          ..write('taskTitle: $taskTitle, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('energyAtCompletion: $energyAtCompletion, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    dailyRecordId,
    taskKey,
    taskTitle,
    energyLevel,
    energyAtCompletion,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HomeCareCompletion &&
          other.id == this.id &&
          other.dailyRecordId == this.dailyRecordId &&
          other.taskKey == this.taskKey &&
          other.taskTitle == this.taskTitle &&
          other.energyLevel == this.energyLevel &&
          other.energyAtCompletion == this.energyAtCompletion &&
          other.completedAt == this.completedAt);
}

class HomeCareCompletionsCompanion extends UpdateCompanion<HomeCareCompletion> {
  final Value<int> id;
  final Value<int> dailyRecordId;
  final Value<String> taskKey;
  final Value<String> taskTitle;
  final Value<String> energyLevel;
  final Value<String?> energyAtCompletion;
  final Value<DateTime> completedAt;
  const HomeCareCompletionsCompanion({
    this.id = const Value.absent(),
    this.dailyRecordId = const Value.absent(),
    this.taskKey = const Value.absent(),
    this.taskTitle = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.energyAtCompletion = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  HomeCareCompletionsCompanion.insert({
    this.id = const Value.absent(),
    required int dailyRecordId,
    required String taskKey,
    required String taskTitle,
    required String energyLevel,
    this.energyAtCompletion = const Value.absent(),
    this.completedAt = const Value.absent(),
  }) : dailyRecordId = Value(dailyRecordId),
       taskKey = Value(taskKey),
       taskTitle = Value(taskTitle),
       energyLevel = Value(energyLevel);
  static Insertable<HomeCareCompletion> custom({
    Expression<int>? id,
    Expression<int>? dailyRecordId,
    Expression<String>? taskKey,
    Expression<String>? taskTitle,
    Expression<String>? energyLevel,
    Expression<String>? energyAtCompletion,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dailyRecordId != null) 'daily_record_id': dailyRecordId,
      if (taskKey != null) 'task_key': taskKey,
      if (taskTitle != null) 'task_title': taskTitle,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (energyAtCompletion != null)
        'energy_at_completion': energyAtCompletion,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  HomeCareCompletionsCompanion copyWith({
    Value<int>? id,
    Value<int>? dailyRecordId,
    Value<String>? taskKey,
    Value<String>? taskTitle,
    Value<String>? energyLevel,
    Value<String?>? energyAtCompletion,
    Value<DateTime>? completedAt,
  }) {
    return HomeCareCompletionsCompanion(
      id: id ?? this.id,
      dailyRecordId: dailyRecordId ?? this.dailyRecordId,
      taskKey: taskKey ?? this.taskKey,
      taskTitle: taskTitle ?? this.taskTitle,
      energyLevel: energyLevel ?? this.energyLevel,
      energyAtCompletion: energyAtCompletion ?? this.energyAtCompletion,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dailyRecordId.present) {
      map['daily_record_id'] = Variable<int>(dailyRecordId.value);
    }
    if (taskKey.present) {
      map['task_key'] = Variable<String>(taskKey.value);
    }
    if (taskTitle.present) {
      map['task_title'] = Variable<String>(taskTitle.value);
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<String>(energyLevel.value);
    }
    if (energyAtCompletion.present) {
      map['energy_at_completion'] = Variable<String>(energyAtCompletion.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HomeCareCompletionsCompanion(')
          ..write('id: $id, ')
          ..write('dailyRecordId: $dailyRecordId, ')
          ..write('taskKey: $taskKey, ')
          ..write('taskTitle: $taskTitle, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('energyAtCompletion: $energyAtCompletion, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DailyRecordsTable dailyRecords = $DailyRecordsTable(this);
  late final $SleepLogsTable sleepLogs = $SleepLogsTable(this);
  late final $NapLogsTable napLogs = $NapLogsTable(this);
  late final $CareLogsTable careLogs = $CareLogsTable(this);
  late final $EnergyLogsTable energyLogs = $EnergyLogsTable(this);
  late final $HomeCareCompletionsTable homeCareCompletions =
      $HomeCareCompletionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    dailyRecords,
    sleepLogs,
    napLogs,
    careLogs,
    energyLogs,
    homeCareCompletions,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'daily_records',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sleep_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'daily_records',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('nap_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'daily_records',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('care_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'daily_records',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('energy_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'daily_records',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('home_care_completions', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$DailyRecordsTableCreateCompanionBuilder =
    DailyRecordsCompanion Function({
      Value<int> id,
      required String dateKey,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> endDayCompleted,
      Value<DateTime?> endDayCompletedAt,
    });
typedef $$DailyRecordsTableUpdateCompanionBuilder =
    DailyRecordsCompanion Function({
      Value<int> id,
      Value<String> dateKey,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> endDayCompleted,
      Value<DateTime?> endDayCompletedAt,
    });

final class $$DailyRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $DailyRecordsTable, DailyRecord> {
  $$DailyRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SleepLogsTable, List<SleepLog>>
  _sleepLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sleepLogs,
    aliasName: 'daily_records__id__sleep_logs__daily_record_id',
  );

  $$SleepLogsTableProcessedTableManager get sleepLogsRefs {
    final manager = $$SleepLogsTableTableManager(
      $_db,
      $_db.sleepLogs,
    ).filter((f) => f.dailyRecordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sleepLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$NapLogsTable, List<NapLog>> _napLogsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.napLogs,
    aliasName: 'daily_records__id__nap_logs__daily_record_id',
  );

  $$NapLogsTableProcessedTableManager get napLogsRefs {
    final manager = $$NapLogsTableTableManager(
      $_db,
      $_db.napLogs,
    ).filter((f) => f.dailyRecordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_napLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CareLogsTable, List<CareLog>> _careLogsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.careLogs,
    aliasName: 'daily_records__id__care_logs__daily_record_id',
  );

  $$CareLogsTableProcessedTableManager get careLogsRefs {
    final manager = $$CareLogsTableTableManager(
      $_db,
      $_db.careLogs,
    ).filter((f) => f.dailyRecordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_careLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EnergyLogsTable, List<EnergyLog>>
  _energyLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.energyLogs,
    aliasName: 'daily_records__id__energy_logs__daily_record_id',
  );

  $$EnergyLogsTableProcessedTableManager get energyLogsRefs {
    final manager = $$EnergyLogsTableTableManager(
      $_db,
      $_db.energyLogs,
    ).filter((f) => f.dailyRecordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_energyLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $HomeCareCompletionsTable,
    List<HomeCareCompletion>
  >
  _homeCareCompletionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.homeCareCompletions,
        aliasName: 'daily_records__id__home_care_completions__daily_record_id',
      );

  $$HomeCareCompletionsTableProcessedTableManager get homeCareCompletionsRefs {
    final manager = $$HomeCareCompletionsTableTableManager(
      $_db,
      $_db.homeCareCompletions,
    ).filter((f) => f.dailyRecordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _homeCareCompletionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DailyRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyRecordsTable> {
  $$DailyRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateKey => $composableBuilder(
    column: $table.dateKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get endDayCompleted => $composableBuilder(
    column: $table.endDayCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDayCompletedAt => $composableBuilder(
    column: $table.endDayCompletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sleepLogsRefs(
    Expression<bool> Function($$SleepLogsTableFilterComposer f) f,
  ) {
    final $$SleepLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sleepLogs,
      getReferencedColumn: (t) => t.dailyRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepLogsTableFilterComposer(
            $db: $db,
            $table: $db.sleepLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> napLogsRefs(
    Expression<bool> Function($$NapLogsTableFilterComposer f) f,
  ) {
    final $$NapLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.napLogs,
      getReferencedColumn: (t) => t.dailyRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NapLogsTableFilterComposer(
            $db: $db,
            $table: $db.napLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> careLogsRefs(
    Expression<bool> Function($$CareLogsTableFilterComposer f) f,
  ) {
    final $$CareLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careLogs,
      getReferencedColumn: (t) => t.dailyRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareLogsTableFilterComposer(
            $db: $db,
            $table: $db.careLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> energyLogsRefs(
    Expression<bool> Function($$EnergyLogsTableFilterComposer f) f,
  ) {
    final $$EnergyLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.energyLogs,
      getReferencedColumn: (t) => t.dailyRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EnergyLogsTableFilterComposer(
            $db: $db,
            $table: $db.energyLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> homeCareCompletionsRefs(
    Expression<bool> Function($$HomeCareCompletionsTableFilterComposer f) f,
  ) {
    final $$HomeCareCompletionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.homeCareCompletions,
      getReferencedColumn: (t) => t.dailyRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HomeCareCompletionsTableFilterComposer(
            $db: $db,
            $table: $db.homeCareCompletions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DailyRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyRecordsTable> {
  $$DailyRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateKey => $composableBuilder(
    column: $table.dateKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get endDayCompleted => $composableBuilder(
    column: $table.endDayCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDayCompletedAt => $composableBuilder(
    column: $table.endDayCompletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyRecordsTable> {
  $$DailyRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dateKey =>
      $composableBuilder(column: $table.dateKey, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get endDayCompleted => $composableBuilder(
    column: $table.endDayCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get endDayCompletedAt => $composableBuilder(
    column: $table.endDayCompletedAt,
    builder: (column) => column,
  );

  Expression<T> sleepLogsRefs<T extends Object>(
    Expression<T> Function($$SleepLogsTableAnnotationComposer a) f,
  ) {
    final $$SleepLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sleepLogs,
      getReferencedColumn: (t) => t.dailyRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.sleepLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> napLogsRefs<T extends Object>(
    Expression<T> Function($$NapLogsTableAnnotationComposer a) f,
  ) {
    final $$NapLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.napLogs,
      getReferencedColumn: (t) => t.dailyRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NapLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.napLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> careLogsRefs<T extends Object>(
    Expression<T> Function($$CareLogsTableAnnotationComposer a) f,
  ) {
    final $$CareLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careLogs,
      getReferencedColumn: (t) => t.dailyRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.careLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> energyLogsRefs<T extends Object>(
    Expression<T> Function($$EnergyLogsTableAnnotationComposer a) f,
  ) {
    final $$EnergyLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.energyLogs,
      getReferencedColumn: (t) => t.dailyRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EnergyLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.energyLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> homeCareCompletionsRefs<T extends Object>(
    Expression<T> Function($$HomeCareCompletionsTableAnnotationComposer a) f,
  ) {
    final $$HomeCareCompletionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.homeCareCompletions,
          getReferencedColumn: (t) => t.dailyRecordId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$HomeCareCompletionsTableAnnotationComposer(
                $db: $db,
                $table: $db.homeCareCompletions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DailyRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyRecordsTable,
          DailyRecord,
          $$DailyRecordsTableFilterComposer,
          $$DailyRecordsTableOrderingComposer,
          $$DailyRecordsTableAnnotationComposer,
          $$DailyRecordsTableCreateCompanionBuilder,
          $$DailyRecordsTableUpdateCompanionBuilder,
          (DailyRecord, $$DailyRecordsTableReferences),
          DailyRecord,
          PrefetchHooks Function({
            bool sleepLogsRefs,
            bool napLogsRefs,
            bool careLogsRefs,
            bool energyLogsRefs,
            bool homeCareCompletionsRefs,
          })
        > {
  $$DailyRecordsTableTableManager(_$AppDatabase db, $DailyRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> dateKey = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> endDayCompleted = const Value.absent(),
                Value<DateTime?> endDayCompletedAt = const Value.absent(),
              }) => DailyRecordsCompanion(
                id: id,
                dateKey: dateKey,
                createdAt: createdAt,
                updatedAt: updatedAt,
                endDayCompleted: endDayCompleted,
                endDayCompletedAt: endDayCompletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String dateKey,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> endDayCompleted = const Value.absent(),
                Value<DateTime?> endDayCompletedAt = const Value.absent(),
              }) => DailyRecordsCompanion.insert(
                id: id,
                dateKey: dateKey,
                createdAt: createdAt,
                updatedAt: updatedAt,
                endDayCompleted: endDayCompleted,
                endDayCompletedAt: endDayCompletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DailyRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sleepLogsRefs = false,
                napLogsRefs = false,
                careLogsRefs = false,
                energyLogsRefs = false,
                homeCareCompletionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sleepLogsRefs) db.sleepLogs,
                    if (napLogsRefs) db.napLogs,
                    if (careLogsRefs) db.careLogs,
                    if (energyLogsRefs) db.energyLogs,
                    if (homeCareCompletionsRefs) db.homeCareCompletions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sleepLogsRefs)
                        await $_getPrefetchedData<
                          DailyRecord,
                          $DailyRecordsTable,
                          SleepLog
                        >(
                          currentTable: table,
                          referencedTable: $$DailyRecordsTableReferences
                              ._sleepLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DailyRecordsTableReferences(
                                db,
                                table,
                                p0,
                              ).sleepLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dailyRecordId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (napLogsRefs)
                        await $_getPrefetchedData<
                          DailyRecord,
                          $DailyRecordsTable,
                          NapLog
                        >(
                          currentTable: table,
                          referencedTable: $$DailyRecordsTableReferences
                              ._napLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DailyRecordsTableReferences(
                                db,
                                table,
                                p0,
                              ).napLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dailyRecordId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (careLogsRefs)
                        await $_getPrefetchedData<
                          DailyRecord,
                          $DailyRecordsTable,
                          CareLog
                        >(
                          currentTable: table,
                          referencedTable: $$DailyRecordsTableReferences
                              ._careLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DailyRecordsTableReferences(
                                db,
                                table,
                                p0,
                              ).careLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dailyRecordId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (energyLogsRefs)
                        await $_getPrefetchedData<
                          DailyRecord,
                          $DailyRecordsTable,
                          EnergyLog
                        >(
                          currentTable: table,
                          referencedTable: $$DailyRecordsTableReferences
                              ._energyLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DailyRecordsTableReferences(
                                db,
                                table,
                                p0,
                              ).energyLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dailyRecordId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (homeCareCompletionsRefs)
                        await $_getPrefetchedData<
                          DailyRecord,
                          $DailyRecordsTable,
                          HomeCareCompletion
                        >(
                          currentTable: table,
                          referencedTable: $$DailyRecordsTableReferences
                              ._homeCareCompletionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DailyRecordsTableReferences(
                                db,
                                table,
                                p0,
                              ).homeCareCompletionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dailyRecordId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DailyRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyRecordsTable,
      DailyRecord,
      $$DailyRecordsTableFilterComposer,
      $$DailyRecordsTableOrderingComposer,
      $$DailyRecordsTableAnnotationComposer,
      $$DailyRecordsTableCreateCompanionBuilder,
      $$DailyRecordsTableUpdateCompanionBuilder,
      (DailyRecord, $$DailyRecordsTableReferences),
      DailyRecord,
      PrefetchHooks Function({
        bool sleepLogsRefs,
        bool napLogsRefs,
        bool careLogsRefs,
        bool energyLogsRefs,
        bool homeCareCompletionsRefs,
      })
    >;
typedef $$SleepLogsTableCreateCompanionBuilder =
    SleepLogsCompanion Function({
      Value<int> id,
      required int dailyRecordId,
      required DateTime bedtime,
      required DateTime wakeTime,
      Value<int> sleepOnsetAdjustmentMinutes,
      Value<String> sleepLatencySource,
      Value<int> awakeningCount,
      Value<int> awakeDuringNightMinutes,
      required int calculatedDurationMinutes,
      Value<int?> manualDurationMinutes,
      required int sleepQuality,
      required int energy,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$SleepLogsTableUpdateCompanionBuilder =
    SleepLogsCompanion Function({
      Value<int> id,
      Value<int> dailyRecordId,
      Value<DateTime> bedtime,
      Value<DateTime> wakeTime,
      Value<int> sleepOnsetAdjustmentMinutes,
      Value<String> sleepLatencySource,
      Value<int> awakeningCount,
      Value<int> awakeDuringNightMinutes,
      Value<int> calculatedDurationMinutes,
      Value<int?> manualDurationMinutes,
      Value<int> sleepQuality,
      Value<int> energy,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$SleepLogsTableReferences
    extends BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog> {
  $$SleepLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DailyRecordsTable _dailyRecordIdTable(_$AppDatabase db) => db
      .dailyRecords
      .createAlias('sleep_logs__daily_record_id__daily_records__id');

  $$DailyRecordsTableProcessedTableManager get dailyRecordId {
    final $_column = $_itemColumn<int>('daily_record_id')!;

    final manager = $$DailyRecordsTableTableManager(
      $_db,
      $_db.dailyRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dailyRecordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SleepLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get bedtime => $composableBuilder(
    column: $table.bedtime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get wakeTime => $composableBuilder(
    column: $table.wakeTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sleepOnsetAdjustmentMinutes => $composableBuilder(
    column: $table.sleepOnsetAdjustmentMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sleepLatencySource => $composableBuilder(
    column: $table.sleepLatencySource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get awakeningCount => $composableBuilder(
    column: $table.awakeningCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get awakeDuringNightMinutes => $composableBuilder(
    column: $table.awakeDuringNightMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get calculatedDurationMinutes => $composableBuilder(
    column: $table.calculatedDurationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get manualDurationMinutes => $composableBuilder(
    column: $table.manualDurationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get energy => $composableBuilder(
    column: $table.energy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DailyRecordsTableFilterComposer get dailyRecordId {
    final $$DailyRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyRecordId,
      referencedTable: $db.dailyRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyRecordsTableFilterComposer(
            $db: $db,
            $table: $db.dailyRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SleepLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get bedtime => $composableBuilder(
    column: $table.bedtime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get wakeTime => $composableBuilder(
    column: $table.wakeTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sleepOnsetAdjustmentMinutes => $composableBuilder(
    column: $table.sleepOnsetAdjustmentMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sleepLatencySource => $composableBuilder(
    column: $table.sleepLatencySource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get awakeningCount => $composableBuilder(
    column: $table.awakeningCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get awakeDuringNightMinutes => $composableBuilder(
    column: $table.awakeDuringNightMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calculatedDurationMinutes => $composableBuilder(
    column: $table.calculatedDurationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get manualDurationMinutes => $composableBuilder(
    column: $table.manualDurationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get energy => $composableBuilder(
    column: $table.energy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DailyRecordsTableOrderingComposer get dailyRecordId {
    final $$DailyRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyRecordId,
      referencedTable: $db.dailyRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.dailyRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SleepLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get bedtime =>
      $composableBuilder(column: $table.bedtime, builder: (column) => column);

  GeneratedColumn<DateTime> get wakeTime =>
      $composableBuilder(column: $table.wakeTime, builder: (column) => column);

  GeneratedColumn<int> get sleepOnsetAdjustmentMinutes => $composableBuilder(
    column: $table.sleepOnsetAdjustmentMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sleepLatencySource => $composableBuilder(
    column: $table.sleepLatencySource,
    builder: (column) => column,
  );

  GeneratedColumn<int> get awakeningCount => $composableBuilder(
    column: $table.awakeningCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get awakeDuringNightMinutes => $composableBuilder(
    column: $table.awakeDuringNightMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get calculatedDurationMinutes => $composableBuilder(
    column: $table.calculatedDurationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get manualDurationMinutes => $composableBuilder(
    column: $table.manualDurationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => column,
  );

  GeneratedColumn<int> get energy =>
      $composableBuilder(column: $table.energy, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$DailyRecordsTableAnnotationComposer get dailyRecordId {
    final $$DailyRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyRecordId,
      referencedTable: $db.dailyRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SleepLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SleepLogsTable,
          SleepLog,
          $$SleepLogsTableFilterComposer,
          $$SleepLogsTableOrderingComposer,
          $$SleepLogsTableAnnotationComposer,
          $$SleepLogsTableCreateCompanionBuilder,
          $$SleepLogsTableUpdateCompanionBuilder,
          (SleepLog, $$SleepLogsTableReferences),
          SleepLog,
          PrefetchHooks Function({bool dailyRecordId})
        > {
  $$SleepLogsTableTableManager(_$AppDatabase db, $SleepLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> dailyRecordId = const Value.absent(),
                Value<DateTime> bedtime = const Value.absent(),
                Value<DateTime> wakeTime = const Value.absent(),
                Value<int> sleepOnsetAdjustmentMinutes = const Value.absent(),
                Value<String> sleepLatencySource = const Value.absent(),
                Value<int> awakeningCount = const Value.absent(),
                Value<int> awakeDuringNightMinutes = const Value.absent(),
                Value<int> calculatedDurationMinutes = const Value.absent(),
                Value<int?> manualDurationMinutes = const Value.absent(),
                Value<int> sleepQuality = const Value.absent(),
                Value<int> energy = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SleepLogsCompanion(
                id: id,
                dailyRecordId: dailyRecordId,
                bedtime: bedtime,
                wakeTime: wakeTime,
                sleepOnsetAdjustmentMinutes: sleepOnsetAdjustmentMinutes,
                sleepLatencySource: sleepLatencySource,
                awakeningCount: awakeningCount,
                awakeDuringNightMinutes: awakeDuringNightMinutes,
                calculatedDurationMinutes: calculatedDurationMinutes,
                manualDurationMinutes: manualDurationMinutes,
                sleepQuality: sleepQuality,
                energy: energy,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int dailyRecordId,
                required DateTime bedtime,
                required DateTime wakeTime,
                Value<int> sleepOnsetAdjustmentMinutes = const Value.absent(),
                Value<String> sleepLatencySource = const Value.absent(),
                Value<int> awakeningCount = const Value.absent(),
                Value<int> awakeDuringNightMinutes = const Value.absent(),
                required int calculatedDurationMinutes,
                Value<int?> manualDurationMinutes = const Value.absent(),
                required int sleepQuality,
                required int energy,
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SleepLogsCompanion.insert(
                id: id,
                dailyRecordId: dailyRecordId,
                bedtime: bedtime,
                wakeTime: wakeTime,
                sleepOnsetAdjustmentMinutes: sleepOnsetAdjustmentMinutes,
                sleepLatencySource: sleepLatencySource,
                awakeningCount: awakeningCount,
                awakeDuringNightMinutes: awakeDuringNightMinutes,
                calculatedDurationMinutes: calculatedDurationMinutes,
                manualDurationMinutes: manualDurationMinutes,
                sleepQuality: sleepQuality,
                energy: energy,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SleepLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dailyRecordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (dailyRecordId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.dailyRecordId,
                                referencedTable: $$SleepLogsTableReferences
                                    ._dailyRecordIdTable(db),
                                referencedColumn: $$SleepLogsTableReferences
                                    ._dailyRecordIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SleepLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SleepLogsTable,
      SleepLog,
      $$SleepLogsTableFilterComposer,
      $$SleepLogsTableOrderingComposer,
      $$SleepLogsTableAnnotationComposer,
      $$SleepLogsTableCreateCompanionBuilder,
      $$SleepLogsTableUpdateCompanionBuilder,
      (SleepLog, $$SleepLogsTableReferences),
      SleepLog,
      PrefetchHooks Function({bool dailyRecordId})
    >;
typedef $$NapLogsTableCreateCompanionBuilder =
    NapLogsCompanion Function({
      Value<int> id,
      required int dailyRecordId,
      required DateTime startTime,
      required int durationMinutes,
      Value<String?> didSleep,
      Value<String?> napType,
      Value<int?> wakeFeeling,
      Value<int?> quality,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$NapLogsTableUpdateCompanionBuilder =
    NapLogsCompanion Function({
      Value<int> id,
      Value<int> dailyRecordId,
      Value<DateTime> startTime,
      Value<int> durationMinutes,
      Value<String?> didSleep,
      Value<String?> napType,
      Value<int?> wakeFeeling,
      Value<int?> quality,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$NapLogsTableReferences
    extends BaseReferences<_$AppDatabase, $NapLogsTable, NapLog> {
  $$NapLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DailyRecordsTable _dailyRecordIdTable(_$AppDatabase db) => db
      .dailyRecords
      .createAlias('nap_logs__daily_record_id__daily_records__id');

  $$DailyRecordsTableProcessedTableManager get dailyRecordId {
    final $_column = $_itemColumn<int>('daily_record_id')!;

    final manager = $$DailyRecordsTableTableManager(
      $_db,
      $_db.dailyRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dailyRecordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NapLogsTableFilterComposer
    extends Composer<_$AppDatabase, $NapLogsTable> {
  $$NapLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get didSleep => $composableBuilder(
    column: $table.didSleep,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get napType => $composableBuilder(
    column: $table.napType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wakeFeeling => $composableBuilder(
    column: $table.wakeFeeling,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DailyRecordsTableFilterComposer get dailyRecordId {
    final $$DailyRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyRecordId,
      referencedTable: $db.dailyRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyRecordsTableFilterComposer(
            $db: $db,
            $table: $db.dailyRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NapLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $NapLogsTable> {
  $$NapLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get didSleep => $composableBuilder(
    column: $table.didSleep,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get napType => $composableBuilder(
    column: $table.napType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wakeFeeling => $composableBuilder(
    column: $table.wakeFeeling,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DailyRecordsTableOrderingComposer get dailyRecordId {
    final $$DailyRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyRecordId,
      referencedTable: $db.dailyRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.dailyRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NapLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NapLogsTable> {
  $$NapLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get didSleep =>
      $composableBuilder(column: $table.didSleep, builder: (column) => column);

  GeneratedColumn<String> get napType =>
      $composableBuilder(column: $table.napType, builder: (column) => column);

  GeneratedColumn<int> get wakeFeeling => $composableBuilder(
    column: $table.wakeFeeling,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quality =>
      $composableBuilder(column: $table.quality, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$DailyRecordsTableAnnotationComposer get dailyRecordId {
    final $$DailyRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyRecordId,
      referencedTable: $db.dailyRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NapLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NapLogsTable,
          NapLog,
          $$NapLogsTableFilterComposer,
          $$NapLogsTableOrderingComposer,
          $$NapLogsTableAnnotationComposer,
          $$NapLogsTableCreateCompanionBuilder,
          $$NapLogsTableUpdateCompanionBuilder,
          (NapLog, $$NapLogsTableReferences),
          NapLog,
          PrefetchHooks Function({bool dailyRecordId})
        > {
  $$NapLogsTableTableManager(_$AppDatabase db, $NapLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NapLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NapLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NapLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> dailyRecordId = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<String?> didSleep = const Value.absent(),
                Value<String?> napType = const Value.absent(),
                Value<int?> wakeFeeling = const Value.absent(),
                Value<int?> quality = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => NapLogsCompanion(
                id: id,
                dailyRecordId: dailyRecordId,
                startTime: startTime,
                durationMinutes: durationMinutes,
                didSleep: didSleep,
                napType: napType,
                wakeFeeling: wakeFeeling,
                quality: quality,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int dailyRecordId,
                required DateTime startTime,
                required int durationMinutes,
                Value<String?> didSleep = const Value.absent(),
                Value<String?> napType = const Value.absent(),
                Value<int?> wakeFeeling = const Value.absent(),
                Value<int?> quality = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => NapLogsCompanion.insert(
                id: id,
                dailyRecordId: dailyRecordId,
                startTime: startTime,
                durationMinutes: durationMinutes,
                didSleep: didSleep,
                napType: napType,
                wakeFeeling: wakeFeeling,
                quality: quality,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NapLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dailyRecordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (dailyRecordId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.dailyRecordId,
                                referencedTable: $$NapLogsTableReferences
                                    ._dailyRecordIdTable(db),
                                referencedColumn: $$NapLogsTableReferences
                                    ._dailyRecordIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NapLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NapLogsTable,
      NapLog,
      $$NapLogsTableFilterComposer,
      $$NapLogsTableOrderingComposer,
      $$NapLogsTableAnnotationComposer,
      $$NapLogsTableCreateCompanionBuilder,
      $$NapLogsTableUpdateCompanionBuilder,
      (NapLog, $$NapLogsTableReferences),
      NapLog,
      PrefetchHooks Function({bool dailyRecordId})
    >;
typedef $$CareLogsTableCreateCompanionBuilder =
    CareLogsCompanion Function({
      Value<int> id,
      required int dailyRecordId,
      Value<int?> moodScore,
      Value<String?> moodNotes,
      Value<String?> energyLevel,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CareLogsTableUpdateCompanionBuilder =
    CareLogsCompanion Function({
      Value<int> id,
      Value<int> dailyRecordId,
      Value<int?> moodScore,
      Value<String?> moodNotes,
      Value<String?> energyLevel,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$CareLogsTableReferences
    extends BaseReferences<_$AppDatabase, $CareLogsTable, CareLog> {
  $$CareLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DailyRecordsTable _dailyRecordIdTable(_$AppDatabase db) => db
      .dailyRecords
      .createAlias('care_logs__daily_record_id__daily_records__id');

  $$DailyRecordsTableProcessedTableManager get dailyRecordId {
    final $_column = $_itemColumn<int>('daily_record_id')!;

    final manager = $$DailyRecordsTableTableManager(
      $_db,
      $_db.dailyRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dailyRecordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CareLogsTableFilterComposer
    extends Composer<_$AppDatabase, $CareLogsTable> {
  $$CareLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get moodScore => $composableBuilder(
    column: $table.moodScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get moodNotes => $composableBuilder(
    column: $table.moodNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DailyRecordsTableFilterComposer get dailyRecordId {
    final $$DailyRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyRecordId,
      referencedTable: $db.dailyRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyRecordsTableFilterComposer(
            $db: $db,
            $table: $db.dailyRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $CareLogsTable> {
  $$CareLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get moodScore => $composableBuilder(
    column: $table.moodScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moodNotes => $composableBuilder(
    column: $table.moodNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DailyRecordsTableOrderingComposer get dailyRecordId {
    final $$DailyRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyRecordId,
      referencedTable: $db.dailyRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.dailyRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CareLogsTable> {
  $$CareLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get moodScore =>
      $composableBuilder(column: $table.moodScore, builder: (column) => column);

  GeneratedColumn<String> get moodNotes =>
      $composableBuilder(column: $table.moodNotes, builder: (column) => column);

  GeneratedColumn<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$DailyRecordsTableAnnotationComposer get dailyRecordId {
    final $$DailyRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyRecordId,
      referencedTable: $db.dailyRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CareLogsTable,
          CareLog,
          $$CareLogsTableFilterComposer,
          $$CareLogsTableOrderingComposer,
          $$CareLogsTableAnnotationComposer,
          $$CareLogsTableCreateCompanionBuilder,
          $$CareLogsTableUpdateCompanionBuilder,
          (CareLog, $$CareLogsTableReferences),
          CareLog,
          PrefetchHooks Function({bool dailyRecordId})
        > {
  $$CareLogsTableTableManager(_$AppDatabase db, $CareLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CareLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CareLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CareLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> dailyRecordId = const Value.absent(),
                Value<int?> moodScore = const Value.absent(),
                Value<String?> moodNotes = const Value.absent(),
                Value<String?> energyLevel = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CareLogsCompanion(
                id: id,
                dailyRecordId: dailyRecordId,
                moodScore: moodScore,
                moodNotes: moodNotes,
                energyLevel: energyLevel,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int dailyRecordId,
                Value<int?> moodScore = const Value.absent(),
                Value<String?> moodNotes = const Value.absent(),
                Value<String?> energyLevel = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CareLogsCompanion.insert(
                id: id,
                dailyRecordId: dailyRecordId,
                moodScore: moodScore,
                moodNotes: moodNotes,
                energyLevel: energyLevel,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CareLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dailyRecordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (dailyRecordId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.dailyRecordId,
                                referencedTable: $$CareLogsTableReferences
                                    ._dailyRecordIdTable(db),
                                referencedColumn: $$CareLogsTableReferences
                                    ._dailyRecordIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CareLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CareLogsTable,
      CareLog,
      $$CareLogsTableFilterComposer,
      $$CareLogsTableOrderingComposer,
      $$CareLogsTableAnnotationComposer,
      $$CareLogsTableCreateCompanionBuilder,
      $$CareLogsTableUpdateCompanionBuilder,
      (CareLog, $$CareLogsTableReferences),
      CareLog,
      PrefetchHooks Function({bool dailyRecordId})
    >;
typedef $$EnergyLogsTableCreateCompanionBuilder =
    EnergyLogsCompanion Function({
      Value<int> id,
      required int dailyRecordId,
      required String energyLevel,
      required DateTime recordedAt,
      Value<DateTime> createdAt,
    });
typedef $$EnergyLogsTableUpdateCompanionBuilder =
    EnergyLogsCompanion Function({
      Value<int> id,
      Value<int> dailyRecordId,
      Value<String> energyLevel,
      Value<DateTime> recordedAt,
      Value<DateTime> createdAt,
    });

final class $$EnergyLogsTableReferences
    extends BaseReferences<_$AppDatabase, $EnergyLogsTable, EnergyLog> {
  $$EnergyLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DailyRecordsTable _dailyRecordIdTable(_$AppDatabase db) => db
      .dailyRecords
      .createAlias('energy_logs__daily_record_id__daily_records__id');

  $$DailyRecordsTableProcessedTableManager get dailyRecordId {
    final $_column = $_itemColumn<int>('daily_record_id')!;

    final manager = $$DailyRecordsTableTableManager(
      $_db,
      $_db.dailyRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dailyRecordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EnergyLogsTableFilterComposer
    extends Composer<_$AppDatabase, $EnergyLogsTable> {
  $$EnergyLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DailyRecordsTableFilterComposer get dailyRecordId {
    final $$DailyRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyRecordId,
      referencedTable: $db.dailyRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyRecordsTableFilterComposer(
            $db: $db,
            $table: $db.dailyRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EnergyLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $EnergyLogsTable> {
  $$EnergyLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DailyRecordsTableOrderingComposer get dailyRecordId {
    final $$DailyRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyRecordId,
      referencedTable: $db.dailyRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.dailyRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EnergyLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EnergyLogsTable> {
  $$EnergyLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$DailyRecordsTableAnnotationComposer get dailyRecordId {
    final $$DailyRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyRecordId,
      referencedTable: $db.dailyRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EnergyLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EnergyLogsTable,
          EnergyLog,
          $$EnergyLogsTableFilterComposer,
          $$EnergyLogsTableOrderingComposer,
          $$EnergyLogsTableAnnotationComposer,
          $$EnergyLogsTableCreateCompanionBuilder,
          $$EnergyLogsTableUpdateCompanionBuilder,
          (EnergyLog, $$EnergyLogsTableReferences),
          EnergyLog,
          PrefetchHooks Function({bool dailyRecordId})
        > {
  $$EnergyLogsTableTableManager(_$AppDatabase db, $EnergyLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EnergyLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EnergyLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EnergyLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> dailyRecordId = const Value.absent(),
                Value<String> energyLevel = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EnergyLogsCompanion(
                id: id,
                dailyRecordId: dailyRecordId,
                energyLevel: energyLevel,
                recordedAt: recordedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int dailyRecordId,
                required String energyLevel,
                required DateTime recordedAt,
                Value<DateTime> createdAt = const Value.absent(),
              }) => EnergyLogsCompanion.insert(
                id: id,
                dailyRecordId: dailyRecordId,
                energyLevel: energyLevel,
                recordedAt: recordedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EnergyLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dailyRecordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (dailyRecordId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.dailyRecordId,
                                referencedTable: $$EnergyLogsTableReferences
                                    ._dailyRecordIdTable(db),
                                referencedColumn: $$EnergyLogsTableReferences
                                    ._dailyRecordIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EnergyLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EnergyLogsTable,
      EnergyLog,
      $$EnergyLogsTableFilterComposer,
      $$EnergyLogsTableOrderingComposer,
      $$EnergyLogsTableAnnotationComposer,
      $$EnergyLogsTableCreateCompanionBuilder,
      $$EnergyLogsTableUpdateCompanionBuilder,
      (EnergyLog, $$EnergyLogsTableReferences),
      EnergyLog,
      PrefetchHooks Function({bool dailyRecordId})
    >;
typedef $$HomeCareCompletionsTableCreateCompanionBuilder =
    HomeCareCompletionsCompanion Function({
      Value<int> id,
      required int dailyRecordId,
      required String taskKey,
      required String taskTitle,
      required String energyLevel,
      Value<String?> energyAtCompletion,
      Value<DateTime> completedAt,
    });
typedef $$HomeCareCompletionsTableUpdateCompanionBuilder =
    HomeCareCompletionsCompanion Function({
      Value<int> id,
      Value<int> dailyRecordId,
      Value<String> taskKey,
      Value<String> taskTitle,
      Value<String> energyLevel,
      Value<String?> energyAtCompletion,
      Value<DateTime> completedAt,
    });

final class $$HomeCareCompletionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $HomeCareCompletionsTable,
          HomeCareCompletion
        > {
  $$HomeCareCompletionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DailyRecordsTable _dailyRecordIdTable(_$AppDatabase db) => db
      .dailyRecords
      .createAlias('home_care_completions__daily_record_id__daily_records__id');

  $$DailyRecordsTableProcessedTableManager get dailyRecordId {
    final $_column = $_itemColumn<int>('daily_record_id')!;

    final manager = $$DailyRecordsTableTableManager(
      $_db,
      $_db.dailyRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dailyRecordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HomeCareCompletionsTableFilterComposer
    extends Composer<_$AppDatabase, $HomeCareCompletionsTable> {
  $$HomeCareCompletionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskKey => $composableBuilder(
    column: $table.taskKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskTitle => $composableBuilder(
    column: $table.taskTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get energyAtCompletion => $composableBuilder(
    column: $table.energyAtCompletion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DailyRecordsTableFilterComposer get dailyRecordId {
    final $$DailyRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyRecordId,
      referencedTable: $db.dailyRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyRecordsTableFilterComposer(
            $db: $db,
            $table: $db.dailyRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HomeCareCompletionsTableOrderingComposer
    extends Composer<_$AppDatabase, $HomeCareCompletionsTable> {
  $$HomeCareCompletionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskKey => $composableBuilder(
    column: $table.taskKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskTitle => $composableBuilder(
    column: $table.taskTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get energyAtCompletion => $composableBuilder(
    column: $table.energyAtCompletion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DailyRecordsTableOrderingComposer get dailyRecordId {
    final $$DailyRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyRecordId,
      referencedTable: $db.dailyRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.dailyRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HomeCareCompletionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HomeCareCompletionsTable> {
  $$HomeCareCompletionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get taskKey =>
      $composableBuilder(column: $table.taskKey, builder: (column) => column);

  GeneratedColumn<String> get taskTitle =>
      $composableBuilder(column: $table.taskTitle, builder: (column) => column);

  GeneratedColumn<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get energyAtCompletion => $composableBuilder(
    column: $table.energyAtCompletion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$DailyRecordsTableAnnotationComposer get dailyRecordId {
    final $$DailyRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyRecordId,
      referencedTable: $db.dailyRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HomeCareCompletionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HomeCareCompletionsTable,
          HomeCareCompletion,
          $$HomeCareCompletionsTableFilterComposer,
          $$HomeCareCompletionsTableOrderingComposer,
          $$HomeCareCompletionsTableAnnotationComposer,
          $$HomeCareCompletionsTableCreateCompanionBuilder,
          $$HomeCareCompletionsTableUpdateCompanionBuilder,
          (HomeCareCompletion, $$HomeCareCompletionsTableReferences),
          HomeCareCompletion,
          PrefetchHooks Function({bool dailyRecordId})
        > {
  $$HomeCareCompletionsTableTableManager(
    _$AppDatabase db,
    $HomeCareCompletionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HomeCareCompletionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HomeCareCompletionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$HomeCareCompletionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> dailyRecordId = const Value.absent(),
                Value<String> taskKey = const Value.absent(),
                Value<String> taskTitle = const Value.absent(),
                Value<String> energyLevel = const Value.absent(),
                Value<String?> energyAtCompletion = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
              }) => HomeCareCompletionsCompanion(
                id: id,
                dailyRecordId: dailyRecordId,
                taskKey: taskKey,
                taskTitle: taskTitle,
                energyLevel: energyLevel,
                energyAtCompletion: energyAtCompletion,
                completedAt: completedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int dailyRecordId,
                required String taskKey,
                required String taskTitle,
                required String energyLevel,
                Value<String?> energyAtCompletion = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
              }) => HomeCareCompletionsCompanion.insert(
                id: id,
                dailyRecordId: dailyRecordId,
                taskKey: taskKey,
                taskTitle: taskTitle,
                energyLevel: energyLevel,
                energyAtCompletion: energyAtCompletion,
                completedAt: completedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HomeCareCompletionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dailyRecordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (dailyRecordId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.dailyRecordId,
                                referencedTable:
                                    $$HomeCareCompletionsTableReferences
                                        ._dailyRecordIdTable(db),
                                referencedColumn:
                                    $$HomeCareCompletionsTableReferences
                                        ._dailyRecordIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HomeCareCompletionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HomeCareCompletionsTable,
      HomeCareCompletion,
      $$HomeCareCompletionsTableFilterComposer,
      $$HomeCareCompletionsTableOrderingComposer,
      $$HomeCareCompletionsTableAnnotationComposer,
      $$HomeCareCompletionsTableCreateCompanionBuilder,
      $$HomeCareCompletionsTableUpdateCompanionBuilder,
      (HomeCareCompletion, $$HomeCareCompletionsTableReferences),
      HomeCareCompletion,
      PrefetchHooks Function({bool dailyRecordId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DailyRecordsTableTableManager get dailyRecords =>
      $$DailyRecordsTableTableManager(_db, _db.dailyRecords);
  $$SleepLogsTableTableManager get sleepLogs =>
      $$SleepLogsTableTableManager(_db, _db.sleepLogs);
  $$NapLogsTableTableManager get napLogs =>
      $$NapLogsTableTableManager(_db, _db.napLogs);
  $$CareLogsTableTableManager get careLogs =>
      $$CareLogsTableTableManager(_db, _db.careLogs);
  $$EnergyLogsTableTableManager get energyLogs =>
      $$EnergyLogsTableTableManager(_db, _db.energyLogs);
  $$HomeCareCompletionsTableTableManager get homeCareCompletions =>
      $$HomeCareCompletionsTableTableManager(_db, _db.homeCareCompletions);
}
