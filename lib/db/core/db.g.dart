// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $PatientsTableTable extends PatientsTable
    with TableInfo<$PatientsTableTable, PatientRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatientsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
      'number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
      'date_of_birth', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, number, name, lastName, dateOfBirth, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patients_table';
  @override
  VerificationContext validateIntegrity(Insertable<PatientRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PatientRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PatientRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}number'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      dateOfBirth: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_of_birth']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $PatientsTableTable createAlias(String alias) {
    return $PatientsTableTable(attachedDatabase, alias);
  }
}

class PatientRecord extends DataClass implements Insertable<PatientRecord> {
  final int id;
  final int number;
  final String name;
  final String lastName;
  final DateTime? dateOfBirth;
  final String? notes;
  const PatientRecord(
      {required this.id,
      required this.number,
      required this.name,
      required this.lastName,
      this.dateOfBirth,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['number'] = Variable<int>(number);
    map['name'] = Variable<String>(name);
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PatientsTableCompanion toCompanion(bool nullToAbsent) {
    return PatientsTableCompanion(
      id: Value(id),
      number: Value(number),
      name: Value(name),
      lastName: Value(lastName),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory PatientRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PatientRecord(
      id: serializer.fromJson<int>(json['id']),
      number: serializer.fromJson<int>(json['number']),
      name: serializer.fromJson<String>(json['name']),
      lastName: serializer.fromJson<String>(json['lastName']),
      dateOfBirth: serializer.fromJson<DateTime?>(json['dateOfBirth']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'number': serializer.toJson<int>(number),
      'name': serializer.toJson<String>(name),
      'lastName': serializer.toJson<String>(lastName),
      'dateOfBirth': serializer.toJson<DateTime?>(dateOfBirth),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PatientRecord copyWith(
          {int? id,
          int? number,
          String? name,
          String? lastName,
          Value<DateTime?> dateOfBirth = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      PatientRecord(
        id: id ?? this.id,
        number: number ?? this.number,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
        notes: notes.present ? notes.value : this.notes,
      );
  PatientRecord copyWithCompanion(PatientsTableCompanion data) {
    return PatientRecord(
      id: data.id.present ? data.id.value : this.id,
      number: data.number.present ? data.number.value : this.number,
      name: data.name.present ? data.name.value : this.name,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      dateOfBirth:
          data.dateOfBirth.present ? data.dateOfBirth.value : this.dateOfBirth,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PatientRecord(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('name: $name, ')
          ..write('lastName: $lastName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, number, name, lastName, dateOfBirth, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PatientRecord &&
          other.id == this.id &&
          other.number == this.number &&
          other.name == this.name &&
          other.lastName == this.lastName &&
          other.dateOfBirth == this.dateOfBirth &&
          other.notes == this.notes);
}

class PatientsTableCompanion extends UpdateCompanion<PatientRecord> {
  final Value<int> id;
  final Value<int> number;
  final Value<String> name;
  final Value<String> lastName;
  final Value<DateTime?> dateOfBirth;
  final Value<String?> notes;
  const PatientsTableCompanion({
    this.id = const Value.absent(),
    this.number = const Value.absent(),
    this.name = const Value.absent(),
    this.lastName = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PatientsTableCompanion.insert({
    this.id = const Value.absent(),
    required int number,
    required String name,
    required String lastName,
    this.dateOfBirth = const Value.absent(),
    this.notes = const Value.absent(),
  })  : number = Value(number),
        name = Value(name),
        lastName = Value(lastName);
  static Insertable<PatientRecord> custom({
    Expression<int>? id,
    Expression<int>? number,
    Expression<String>? name,
    Expression<String>? lastName,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (number != null) 'number': number,
      if (name != null) 'name': name,
      if (lastName != null) 'last_name': lastName,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (notes != null) 'notes': notes,
    });
  }

  PatientsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? number,
      Value<String>? name,
      Value<String>? lastName,
      Value<DateTime?>? dateOfBirth,
      Value<String?>? notes}) {
    return PatientsTableCompanion(
      id: id ?? this.id,
      number: number ?? this.number,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientsTableCompanion(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('name: $name, ')
          ..write('lastName: $lastName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PatientHealthMetricsTableTable extends PatientHealthMetricsTable
    with TableInfo<$PatientHealthMetricsTableTable, PatientHealthMetricRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatientHealthMetricsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<int> patientId = GeneratedColumn<int>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES patients_table (id)'));
  static const VerificationMeta _metricTypeMeta =
      const VerificationMeta('metricType');
  @override
  late final GeneratedColumn<String> metricType = GeneratedColumn<String>(
      'metric_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _recordedAtMeta =
      const VerificationMeta('recordedAt');
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
      'recorded_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, patientId, metricType, value, recordedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patient_health_metrics_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<PatientHealthMetricRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('metric_type')) {
      context.handle(
          _metricTypeMeta,
          metricType.isAcceptableOrUnknown(
              data['metric_type']!, _metricTypeMeta));
    } else if (isInserting) {
      context.missing(_metricTypeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
          _recordedAtMeta,
          recordedAt.isAcceptableOrUnknown(
              data['recorded_at']!, _recordedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PatientHealthMetricRecord map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PatientHealthMetricRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}patient_id'])!,
      metricType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metric_type'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value'])!,
      recordedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}recorded_at'])!,
    );
  }

  @override
  $PatientHealthMetricsTableTable createAlias(String alias) {
    return $PatientHealthMetricsTableTable(attachedDatabase, alias);
  }
}

class PatientHealthMetricRecord extends DataClass
    implements Insertable<PatientHealthMetricRecord> {
  final int id;
  final int patientId;
  final String metricType;
  final double value;
  final DateTime recordedAt;
  const PatientHealthMetricRecord(
      {required this.id,
      required this.patientId,
      required this.metricType,
      required this.value,
      required this.recordedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patient_id'] = Variable<int>(patientId);
    map['metric_type'] = Variable<String>(metricType);
    map['value'] = Variable<double>(value);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    return map;
  }

  PatientHealthMetricsTableCompanion toCompanion(bool nullToAbsent) {
    return PatientHealthMetricsTableCompanion(
      id: Value(id),
      patientId: Value(patientId),
      metricType: Value(metricType),
      value: Value(value),
      recordedAt: Value(recordedAt),
    );
  }

  factory PatientHealthMetricRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PatientHealthMetricRecord(
      id: serializer.fromJson<int>(json['id']),
      patientId: serializer.fromJson<int>(json['patientId']),
      metricType: serializer.fromJson<String>(json['metricType']),
      value: serializer.fromJson<double>(json['value']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patientId': serializer.toJson<int>(patientId),
      'metricType': serializer.toJson<String>(metricType),
      'value': serializer.toJson<double>(value),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
    };
  }

  PatientHealthMetricRecord copyWith(
          {int? id,
          int? patientId,
          String? metricType,
          double? value,
          DateTime? recordedAt}) =>
      PatientHealthMetricRecord(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        metricType: metricType ?? this.metricType,
        value: value ?? this.value,
        recordedAt: recordedAt ?? this.recordedAt,
      );
  PatientHealthMetricRecord copyWithCompanion(
      PatientHealthMetricsTableCompanion data) {
    return PatientHealthMetricRecord(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      metricType:
          data.metricType.present ? data.metricType.value : this.metricType,
      value: data.value.present ? data.value.value : this.value,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PatientHealthMetricRecord(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('metricType: $metricType, ')
          ..write('value: $value, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, patientId, metricType, value, recordedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PatientHealthMetricRecord &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.metricType == this.metricType &&
          other.value == this.value &&
          other.recordedAt == this.recordedAt);
}

class PatientHealthMetricsTableCompanion
    extends UpdateCompanion<PatientHealthMetricRecord> {
  final Value<int> id;
  final Value<int> patientId;
  final Value<String> metricType;
  final Value<double> value;
  final Value<DateTime> recordedAt;
  const PatientHealthMetricsTableCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.metricType = const Value.absent(),
    this.value = const Value.absent(),
    this.recordedAt = const Value.absent(),
  });
  PatientHealthMetricsTableCompanion.insert({
    this.id = const Value.absent(),
    required int patientId,
    required String metricType,
    this.value = const Value.absent(),
    this.recordedAt = const Value.absent(),
  })  : patientId = Value(patientId),
        metricType = Value(metricType);
  static Insertable<PatientHealthMetricRecord> custom({
    Expression<int>? id,
    Expression<int>? patientId,
    Expression<String>? metricType,
    Expression<double>? value,
    Expression<DateTime>? recordedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (metricType != null) 'metric_type': metricType,
      if (value != null) 'value': value,
      if (recordedAt != null) 'recorded_at': recordedAt,
    });
  }

  PatientHealthMetricsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? patientId,
      Value<String>? metricType,
      Value<double>? value,
      Value<DateTime>? recordedAt}) {
    return PatientHealthMetricsTableCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      metricType: metricType ?? this.metricType,
      value: value ?? this.value,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<int>(patientId.value);
    }
    if (metricType.present) {
      map['metric_type'] = Variable<String>(metricType.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientHealthMetricsTableCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('metricType: $metricType, ')
          ..write('value: $value, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PatientsTableTable patientsTable = $PatientsTableTable(this);
  late final $PatientHealthMetricsTableTable patientHealthMetricsTable =
      $PatientHealthMetricsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [patientsTable, patientHealthMetricsTable];
}

typedef $$PatientsTableTableCreateCompanionBuilder = PatientsTableCompanion
    Function({
  Value<int> id,
  required int number,
  required String name,
  required String lastName,
  Value<DateTime?> dateOfBirth,
  Value<String?> notes,
});
typedef $$PatientsTableTableUpdateCompanionBuilder = PatientsTableCompanion
    Function({
  Value<int> id,
  Value<int> number,
  Value<String> name,
  Value<String> lastName,
  Value<DateTime?> dateOfBirth,
  Value<String?> notes,
});

final class $$PatientsTableTableReferences
    extends BaseReferences<_$AppDatabase, $PatientsTableTable, PatientRecord> {
  $$PatientsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PatientHealthMetricsTableTable,
      List<PatientHealthMetricRecord>> _patientHealthMetricsTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.patientHealthMetricsTable,
          aliasName: $_aliasNameGenerator(
              db.patientsTable.id, db.patientHealthMetricsTable.patientId));

  $$PatientHealthMetricsTableTableProcessedTableManager
      get patientHealthMetricsTableRefs {
    final manager = $$PatientHealthMetricsTableTableTableManager(
            $_db, $_db.patientHealthMetricsTable)
        .filter((f) => f.patientId.id($_item.id));

    final cache = $_typedResult
        .readTableOrNull(_patientHealthMetricsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PatientsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PatientsTableTable> {
  $$PatientsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get number => $composableBuilder(
      column: $table.number, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  Expression<bool> patientHealthMetricsTableRefs(
      Expression<bool> Function(
              $$PatientHealthMetricsTableTableFilterComposer f)
          f) {
    final $$PatientHealthMetricsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.patientHealthMetricsTable,
            getReferencedColumn: (t) => t.patientId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PatientHealthMetricsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.patientHealthMetricsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PatientsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PatientsTableTable> {
  $$PatientsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get number => $composableBuilder(
      column: $table.number, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$PatientsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PatientsTableTable> {
  $$PatientsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  Expression<T> patientHealthMetricsTableRefs<T extends Object>(
      Expression<T> Function(
              $$PatientHealthMetricsTableTableAnnotationComposer a)
          f) {
    final $$PatientHealthMetricsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.patientHealthMetricsTable,
            getReferencedColumn: (t) => t.patientId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PatientHealthMetricsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.patientHealthMetricsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PatientsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PatientsTableTable,
    PatientRecord,
    $$PatientsTableTableFilterComposer,
    $$PatientsTableTableOrderingComposer,
    $$PatientsTableTableAnnotationComposer,
    $$PatientsTableTableCreateCompanionBuilder,
    $$PatientsTableTableUpdateCompanionBuilder,
    (PatientRecord, $$PatientsTableTableReferences),
    PatientRecord,
    PrefetchHooks Function({bool patientHealthMetricsTableRefs})> {
  $$PatientsTableTableTableManager(_$AppDatabase db, $PatientsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PatientsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PatientsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PatientsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> number = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> lastName = const Value.absent(),
            Value<DateTime?> dateOfBirth = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              PatientsTableCompanion(
            id: id,
            number: number,
            name: name,
            lastName: lastName,
            dateOfBirth: dateOfBirth,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int number,
            required String name,
            required String lastName,
            Value<DateTime?> dateOfBirth = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              PatientsTableCompanion.insert(
            id: id,
            number: number,
            name: name,
            lastName: lastName,
            dateOfBirth: dateOfBirth,
            notes: notes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PatientsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({patientHealthMetricsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (patientHealthMetricsTableRefs) db.patientHealthMetricsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (patientHealthMetricsTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PatientsTableTableReferences
                            ._patientHealthMetricsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PatientsTableTableReferences(db, table, p0)
                                .patientHealthMetricsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.patientId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PatientsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PatientsTableTable,
    PatientRecord,
    $$PatientsTableTableFilterComposer,
    $$PatientsTableTableOrderingComposer,
    $$PatientsTableTableAnnotationComposer,
    $$PatientsTableTableCreateCompanionBuilder,
    $$PatientsTableTableUpdateCompanionBuilder,
    (PatientRecord, $$PatientsTableTableReferences),
    PatientRecord,
    PrefetchHooks Function({bool patientHealthMetricsTableRefs})>;
typedef $$PatientHealthMetricsTableTableCreateCompanionBuilder
    = PatientHealthMetricsTableCompanion Function({
  Value<int> id,
  required int patientId,
  required String metricType,
  Value<double> value,
  Value<DateTime> recordedAt,
});
typedef $$PatientHealthMetricsTableTableUpdateCompanionBuilder
    = PatientHealthMetricsTableCompanion Function({
  Value<int> id,
  Value<int> patientId,
  Value<String> metricType,
  Value<double> value,
  Value<DateTime> recordedAt,
});

final class $$PatientHealthMetricsTableTableReferences extends BaseReferences<
    _$AppDatabase, $PatientHealthMetricsTableTable, PatientHealthMetricRecord> {
  $$PatientHealthMetricsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PatientsTableTable _patientIdTable(_$AppDatabase db) =>
      db.patientsTable.createAlias($_aliasNameGenerator(
          db.patientHealthMetricsTable.patientId, db.patientsTable.id));

  $$PatientsTableTableProcessedTableManager? get patientId {
    if ($_item.patientId == null) return null;
    final manager = $$PatientsTableTableTableManager($_db, $_db.patientsTable)
        .filter((f) => f.id($_item.patientId!));
    final item = $_typedResult.readTableOrNull(_patientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PatientHealthMetricsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PatientHealthMetricsTableTable> {
  $$PatientHealthMetricsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metricType => $composableBuilder(
      column: $table.metricType, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnFilters(column));

  $$PatientsTableTableFilterComposer get patientId {
    final $$PatientsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patientId,
        referencedTable: $db.patientsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatientsTableTableFilterComposer(
              $db: $db,
              $table: $db.patientsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PatientHealthMetricsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PatientHealthMetricsTableTable> {
  $$PatientHealthMetricsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metricType => $composableBuilder(
      column: $table.metricType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnOrderings(column));

  $$PatientsTableTableOrderingComposer get patientId {
    final $$PatientsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patientId,
        referencedTable: $db.patientsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatientsTableTableOrderingComposer(
              $db: $db,
              $table: $db.patientsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PatientHealthMetricsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PatientHealthMetricsTableTable> {
  $$PatientHealthMetricsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get metricType => $composableBuilder(
      column: $table.metricType, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => column);

  $$PatientsTableTableAnnotationComposer get patientId {
    final $$PatientsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patientId,
        referencedTable: $db.patientsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatientsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.patientsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PatientHealthMetricsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PatientHealthMetricsTableTable,
    PatientHealthMetricRecord,
    $$PatientHealthMetricsTableTableFilterComposer,
    $$PatientHealthMetricsTableTableOrderingComposer,
    $$PatientHealthMetricsTableTableAnnotationComposer,
    $$PatientHealthMetricsTableTableCreateCompanionBuilder,
    $$PatientHealthMetricsTableTableUpdateCompanionBuilder,
    (PatientHealthMetricRecord, $$PatientHealthMetricsTableTableReferences),
    PatientHealthMetricRecord,
    PrefetchHooks Function({bool patientId})> {
  $$PatientHealthMetricsTableTableTableManager(
      _$AppDatabase db, $PatientHealthMetricsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PatientHealthMetricsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$PatientHealthMetricsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PatientHealthMetricsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> patientId = const Value.absent(),
            Value<String> metricType = const Value.absent(),
            Value<double> value = const Value.absent(),
            Value<DateTime> recordedAt = const Value.absent(),
          }) =>
              PatientHealthMetricsTableCompanion(
            id: id,
            patientId: patientId,
            metricType: metricType,
            value: value,
            recordedAt: recordedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int patientId,
            required String metricType,
            Value<double> value = const Value.absent(),
            Value<DateTime> recordedAt = const Value.absent(),
          }) =>
              PatientHealthMetricsTableCompanion.insert(
            id: id,
            patientId: patientId,
            metricType: metricType,
            value: value,
            recordedAt: recordedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PatientHealthMetricsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({patientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (patientId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.patientId,
                    referencedTable: $$PatientHealthMetricsTableTableReferences
                        ._patientIdTable(db),
                    referencedColumn: $$PatientHealthMetricsTableTableReferences
                        ._patientIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PatientHealthMetricsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $PatientHealthMetricsTableTable,
        PatientHealthMetricRecord,
        $$PatientHealthMetricsTableTableFilterComposer,
        $$PatientHealthMetricsTableTableOrderingComposer,
        $$PatientHealthMetricsTableTableAnnotationComposer,
        $$PatientHealthMetricsTableTableCreateCompanionBuilder,
        $$PatientHealthMetricsTableTableUpdateCompanionBuilder,
        (PatientHealthMetricRecord, $$PatientHealthMetricsTableTableReferences),
        PatientHealthMetricRecord,
        PrefetchHooks Function({bool patientId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PatientsTableTableTableManager get patientsTable =>
      $$PatientsTableTableTableManager(_db, _db.patientsTable);
  $$PatientHealthMetricsTableTableTableManager get patientHealthMetricsTable =>
      $$PatientHealthMetricsTableTableTableManager(
          _db, _db.patientHealthMetricsTable);
}
