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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DailyRecordsTable dailyRecords = $DailyRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dailyRecords];
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
          (
            DailyRecord,
            BaseReferences<_$AppDatabase, $DailyRecordsTable, DailyRecord>,
          ),
          DailyRecord,
          PrefetchHooks Function()
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
      (
        DailyRecord,
        BaseReferences<_$AppDatabase, $DailyRecordsTable, DailyRecord>,
      ),
      DailyRecord,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DailyRecordsTableTableManager get dailyRecords =>
      $$DailyRecordsTableTableManager(_db, _db.dailyRecords);
}
