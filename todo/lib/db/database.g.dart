// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PlansTable extends Plans with TableInfo<$PlansTable, Plan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<String> startTime = GeneratedColumn<String>(
      'start_time', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weekdaysMeta =
      const VerificationMeta('weekdays');
  @override
  late final GeneratedColumn<String> weekdays = GeneratedColumn<String>(
      'weekdays', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
      'end_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdOnMeta =
      const VerificationMeta('createdOn');
  @override
  late final GeneratedColumn<DateTime> createdOn = GeneratedColumn<DateTime>(
      'created_on', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _modifiedOnMeta =
      const VerificationMeta('modifiedOn');
  @override
  late final GeneratedColumn<DateTime> modifiedOn = GeneratedColumn<DateTime>(
      'modified_on', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        startDate,
        startTime,
        weekdays,
        endDate,
        createdOn,
        modifiedOn,
        id,
        title
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plans';
  @override
  VerificationContext validateIntegrity(Insertable<Plan> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('weekdays')) {
      context.handle(_weekdaysMeta,
          weekdays.isAcceptableOrUnknown(data['weekdays']!, _weekdaysMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('created_on')) {
      context.handle(_createdOnMeta,
          createdOn.isAcceptableOrUnknown(data['created_on']!, _createdOnMeta));
    } else if (isInserting) {
      context.missing(_createdOnMeta);
    }
    if (data.containsKey('modified_on')) {
      context.handle(
          _modifiedOnMeta,
          modifiedOn.isAcceptableOrUnknown(
              data['modified_on']!, _modifiedOnMeta));
    } else if (isInserting) {
      context.missing(_modifiedOnMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Plan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Plan(
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_time'])!,
      weekdays: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}weekdays']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_date']),
      createdOn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_on'])!,
      modifiedOn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}modified_on'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
    );
  }

  @override
  $PlansTable createAlias(String alias) {
    return $PlansTable(attachedDatabase, alias);
  }
}

class Plan extends DataClass implements Insertable<Plan> {
  final String startDate;
  final String startTime;
  final String? weekdays;
  final String? endDate;
  final DateTime createdOn;
  final DateTime modifiedOn;
  final int id;
  final String title;
  const Plan(
      {required this.startDate,
      required this.startTime,
      this.weekdays,
      this.endDate,
      required this.createdOn,
      required this.modifiedOn,
      required this.id,
      required this.title});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['start_date'] = Variable<String>(startDate);
    map['start_time'] = Variable<String>(startTime);
    if (!nullToAbsent || weekdays != null) {
      map['weekdays'] = Variable<String>(weekdays);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<String>(endDate);
    }
    map['created_on'] = Variable<DateTime>(createdOn);
    map['modified_on'] = Variable<DateTime>(modifiedOn);
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    return map;
  }

  PlansCompanion toCompanion(bool nullToAbsent) {
    return PlansCompanion(
      startDate: Value(startDate),
      startTime: Value(startTime),
      weekdays: weekdays == null && nullToAbsent
          ? const Value.absent()
          : Value(weekdays),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      createdOn: Value(createdOn),
      modifiedOn: Value(modifiedOn),
      id: Value(id),
      title: Value(title),
    );
  }

  factory Plan.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Plan(
      startDate: serializer.fromJson<String>(json['startDate']),
      startTime: serializer.fromJson<String>(json['startTime']),
      weekdays: serializer.fromJson<String?>(json['weekdays']),
      endDate: serializer.fromJson<String?>(json['endDate']),
      createdOn: serializer.fromJson<DateTime>(json['createdOn']),
      modifiedOn: serializer.fromJson<DateTime>(json['modifiedOn']),
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'startDate': serializer.toJson<String>(startDate),
      'startTime': serializer.toJson<String>(startTime),
      'weekdays': serializer.toJson<String?>(weekdays),
      'endDate': serializer.toJson<String?>(endDate),
      'createdOn': serializer.toJson<DateTime>(createdOn),
      'modifiedOn': serializer.toJson<DateTime>(modifiedOn),
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
    };
  }

  Plan copyWith(
          {String? startDate,
          String? startTime,
          Value<String?> weekdays = const Value.absent(),
          Value<String?> endDate = const Value.absent(),
          DateTime? createdOn,
          DateTime? modifiedOn,
          int? id,
          String? title}) =>
      Plan(
        startDate: startDate ?? this.startDate,
        startTime: startTime ?? this.startTime,
        weekdays: weekdays.present ? weekdays.value : this.weekdays,
        endDate: endDate.present ? endDate.value : this.endDate,
        createdOn: createdOn ?? this.createdOn,
        modifiedOn: modifiedOn ?? this.modifiedOn,
        id: id ?? this.id,
        title: title ?? this.title,
      );
  Plan copyWithCompanion(PlansCompanion data) {
    return Plan(
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      weekdays: data.weekdays.present ? data.weekdays.value : this.weekdays,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      createdOn: data.createdOn.present ? data.createdOn.value : this.createdOn,
      modifiedOn:
          data.modifiedOn.present ? data.modifiedOn.value : this.modifiedOn,
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Plan(')
          ..write('startDate: $startDate, ')
          ..write('startTime: $startTime, ')
          ..write('weekdays: $weekdays, ')
          ..write('endDate: $endDate, ')
          ..write('createdOn: $createdOn, ')
          ..write('modifiedOn: $modifiedOn, ')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(startDate, startTime, weekdays, endDate,
      createdOn, modifiedOn, id, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Plan &&
          other.startDate == this.startDate &&
          other.startTime == this.startTime &&
          other.weekdays == this.weekdays &&
          other.endDate == this.endDate &&
          other.createdOn == this.createdOn &&
          other.modifiedOn == this.modifiedOn &&
          other.id == this.id &&
          other.title == this.title);
}

class PlansCompanion extends UpdateCompanion<Plan> {
  final Value<String> startDate;
  final Value<String> startTime;
  final Value<String?> weekdays;
  final Value<String?> endDate;
  final Value<DateTime> createdOn;
  final Value<DateTime> modifiedOn;
  final Value<int> id;
  final Value<String> title;
  const PlansCompanion({
    this.startDate = const Value.absent(),
    this.startTime = const Value.absent(),
    this.weekdays = const Value.absent(),
    this.endDate = const Value.absent(),
    this.createdOn = const Value.absent(),
    this.modifiedOn = const Value.absent(),
    this.id = const Value.absent(),
    this.title = const Value.absent(),
  });
  PlansCompanion.insert({
    required String startDate,
    required String startTime,
    this.weekdays = const Value.absent(),
    this.endDate = const Value.absent(),
    required DateTime createdOn,
    required DateTime modifiedOn,
    this.id = const Value.absent(),
    required String title,
  })  : startDate = Value(startDate),
        startTime = Value(startTime),
        createdOn = Value(createdOn),
        modifiedOn = Value(modifiedOn),
        title = Value(title);
  static Insertable<Plan> custom({
    Expression<String>? startDate,
    Expression<String>? startTime,
    Expression<String>? weekdays,
    Expression<String>? endDate,
    Expression<DateTime>? createdOn,
    Expression<DateTime>? modifiedOn,
    Expression<int>? id,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (startDate != null) 'start_date': startDate,
      if (startTime != null) 'start_time': startTime,
      if (weekdays != null) 'weekdays': weekdays,
      if (endDate != null) 'end_date': endDate,
      if (createdOn != null) 'created_on': createdOn,
      if (modifiedOn != null) 'modified_on': modifiedOn,
      if (id != null) 'id': id,
      if (title != null) 'title': title,
    });
  }

  PlansCompanion copyWith(
      {Value<String>? startDate,
      Value<String>? startTime,
      Value<String?>? weekdays,
      Value<String?>? endDate,
      Value<DateTime>? createdOn,
      Value<DateTime>? modifiedOn,
      Value<int>? id,
      Value<String>? title}) {
    return PlansCompanion(
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      weekdays: weekdays ?? this.weekdays,
      endDate: endDate ?? this.endDate,
      createdOn: createdOn ?? this.createdOn,
      modifiedOn: modifiedOn ?? this.modifiedOn,
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<String>(startTime.value);
    }
    if (weekdays.present) {
      map['weekdays'] = Variable<String>(weekdays.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (createdOn.present) {
      map['created_on'] = Variable<DateTime>(createdOn.value);
    }
    if (modifiedOn.present) {
      map['modified_on'] = Variable<DateTime>(modifiedOn.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlansCompanion(')
          ..write('startDate: $startDate, ')
          ..write('startTime: $startTime, ')
          ..write('weekdays: $weekdays, ')
          ..write('endDate: $endDate, ')
          ..write('createdOn: $createdOn, ')
          ..write('modifiedOn: $modifiedOn, ')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }
}

class $ExecutionsTable extends Executions
    with TableInfo<$ExecutionsTable, Execution> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExecutionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _isCheckedMeta =
      const VerificationMeta('isChecked');
  @override
  late final GeneratedColumn<bool> isChecked = GeneratedColumn<bool>(
      'is_checked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_checked" IN (0, 1))'));
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<int> planId = GeneratedColumn<int>(
      'plan_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<String> startTime = GeneratedColumn<String>(
      'start_time', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdOnMeta =
      const VerificationMeta('createdOn');
  @override
  late final GeneratedColumn<DateTime> createdOn = GeneratedColumn<DateTime>(
      'created_on', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _modifiedOnMeta =
      const VerificationMeta('modifiedOn');
  @override
  late final GeneratedColumn<DateTime> modifiedOn = GeneratedColumn<DateTime>(
      'modified_on', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  List<GeneratedColumn> get $columns => [
        isChecked,
        planId,
        title,
        startDate,
        startTime,
        createdOn,
        modifiedOn,
        id
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'executions';
  @override
  VerificationContext validateIntegrity(Insertable<Execution> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('is_checked')) {
      context.handle(_isCheckedMeta,
          isChecked.isAcceptableOrUnknown(data['is_checked']!, _isCheckedMeta));
    } else if (isInserting) {
      context.missing(_isCheckedMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(_planIdMeta,
          planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta));
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('created_on')) {
      context.handle(_createdOnMeta,
          createdOn.isAcceptableOrUnknown(data['created_on']!, _createdOnMeta));
    } else if (isInserting) {
      context.missing(_createdOnMeta);
    }
    if (data.containsKey('modified_on')) {
      context.handle(
          _modifiedOnMeta,
          modifiedOn.isAcceptableOrUnknown(
              data['modified_on']!, _modifiedOnMeta));
    } else if (isInserting) {
      context.missing(_modifiedOnMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Execution map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Execution(
      isChecked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_checked'])!,
      planId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}plan_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_time'])!,
      createdOn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_on'])!,
      modifiedOn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}modified_on'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
    );
  }

  @override
  $ExecutionsTable createAlias(String alias) {
    return $ExecutionsTable(attachedDatabase, alias);
  }
}

class Execution extends DataClass implements Insertable<Execution> {
  final bool isChecked;
  final int planId;
  final String title;
  final String startDate;
  final String startTime;
  final DateTime createdOn;
  final DateTime modifiedOn;
  final int id;
  const Execution(
      {required this.isChecked,
      required this.planId,
      required this.title,
      required this.startDate,
      required this.startTime,
      required this.createdOn,
      required this.modifiedOn,
      required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['is_checked'] = Variable<bool>(isChecked);
    map['plan_id'] = Variable<int>(planId);
    map['title'] = Variable<String>(title);
    map['start_date'] = Variable<String>(startDate);
    map['start_time'] = Variable<String>(startTime);
    map['created_on'] = Variable<DateTime>(createdOn);
    map['modified_on'] = Variable<DateTime>(modifiedOn);
    map['id'] = Variable<int>(id);
    return map;
  }

  ExecutionsCompanion toCompanion(bool nullToAbsent) {
    return ExecutionsCompanion(
      isChecked: Value(isChecked),
      planId: Value(planId),
      title: Value(title),
      startDate: Value(startDate),
      startTime: Value(startTime),
      createdOn: Value(createdOn),
      modifiedOn: Value(modifiedOn),
      id: Value(id),
    );
  }

  factory Execution.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Execution(
      isChecked: serializer.fromJson<bool>(json['isChecked']),
      planId: serializer.fromJson<int>(json['planId']),
      title: serializer.fromJson<String>(json['title']),
      startDate: serializer.fromJson<String>(json['startDate']),
      startTime: serializer.fromJson<String>(json['startTime']),
      createdOn: serializer.fromJson<DateTime>(json['createdOn']),
      modifiedOn: serializer.fromJson<DateTime>(json['modifiedOn']),
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'isChecked': serializer.toJson<bool>(isChecked),
      'planId': serializer.toJson<int>(planId),
      'title': serializer.toJson<String>(title),
      'startDate': serializer.toJson<String>(startDate),
      'startTime': serializer.toJson<String>(startTime),
      'createdOn': serializer.toJson<DateTime>(createdOn),
      'modifiedOn': serializer.toJson<DateTime>(modifiedOn),
      'id': serializer.toJson<int>(id),
    };
  }

  Execution copyWith(
          {bool? isChecked,
          int? planId,
          String? title,
          String? startDate,
          String? startTime,
          DateTime? createdOn,
          DateTime? modifiedOn,
          int? id}) =>
      Execution(
        isChecked: isChecked ?? this.isChecked,
        planId: planId ?? this.planId,
        title: title ?? this.title,
        startDate: startDate ?? this.startDate,
        startTime: startTime ?? this.startTime,
        createdOn: createdOn ?? this.createdOn,
        modifiedOn: modifiedOn ?? this.modifiedOn,
        id: id ?? this.id,
      );
  Execution copyWithCompanion(ExecutionsCompanion data) {
    return Execution(
      isChecked: data.isChecked.present ? data.isChecked.value : this.isChecked,
      planId: data.planId.present ? data.planId.value : this.planId,
      title: data.title.present ? data.title.value : this.title,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      createdOn: data.createdOn.present ? data.createdOn.value : this.createdOn,
      modifiedOn:
          data.modifiedOn.present ? data.modifiedOn.value : this.modifiedOn,
      id: data.id.present ? data.id.value : this.id,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Execution(')
          ..write('isChecked: $isChecked, ')
          ..write('planId: $planId, ')
          ..write('title: $title, ')
          ..write('startDate: $startDate, ')
          ..write('startTime: $startTime, ')
          ..write('createdOn: $createdOn, ')
          ..write('modifiedOn: $modifiedOn, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(isChecked, planId, title, startDate,
      startTime, createdOn, modifiedOn, id);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Execution &&
          other.isChecked == this.isChecked &&
          other.planId == this.planId &&
          other.title == this.title &&
          other.startDate == this.startDate &&
          other.startTime == this.startTime &&
          other.createdOn == this.createdOn &&
          other.modifiedOn == this.modifiedOn &&
          other.id == this.id);
}

class ExecutionsCompanion extends UpdateCompanion<Execution> {
  final Value<bool> isChecked;
  final Value<int> planId;
  final Value<String> title;
  final Value<String> startDate;
  final Value<String> startTime;
  final Value<DateTime> createdOn;
  final Value<DateTime> modifiedOn;
  final Value<int> id;
  const ExecutionsCompanion({
    this.isChecked = const Value.absent(),
    this.planId = const Value.absent(),
    this.title = const Value.absent(),
    this.startDate = const Value.absent(),
    this.startTime = const Value.absent(),
    this.createdOn = const Value.absent(),
    this.modifiedOn = const Value.absent(),
    this.id = const Value.absent(),
  });
  ExecutionsCompanion.insert({
    required bool isChecked,
    required int planId,
    required String title,
    required String startDate,
    required String startTime,
    required DateTime createdOn,
    required DateTime modifiedOn,
    this.id = const Value.absent(),
  })  : isChecked = Value(isChecked),
        planId = Value(planId),
        title = Value(title),
        startDate = Value(startDate),
        startTime = Value(startTime),
        createdOn = Value(createdOn),
        modifiedOn = Value(modifiedOn);
  static Insertable<Execution> custom({
    Expression<bool>? isChecked,
    Expression<int>? planId,
    Expression<String>? title,
    Expression<String>? startDate,
    Expression<String>? startTime,
    Expression<DateTime>? createdOn,
    Expression<DateTime>? modifiedOn,
    Expression<int>? id,
  }) {
    return RawValuesInsertable({
      if (isChecked != null) 'is_checked': isChecked,
      if (planId != null) 'plan_id': planId,
      if (title != null) 'title': title,
      if (startDate != null) 'start_date': startDate,
      if (startTime != null) 'start_time': startTime,
      if (createdOn != null) 'created_on': createdOn,
      if (modifiedOn != null) 'modified_on': modifiedOn,
      if (id != null) 'id': id,
    });
  }

  ExecutionsCompanion copyWith(
      {Value<bool>? isChecked,
      Value<int>? planId,
      Value<String>? title,
      Value<String>? startDate,
      Value<String>? startTime,
      Value<DateTime>? createdOn,
      Value<DateTime>? modifiedOn,
      Value<int>? id}) {
    return ExecutionsCompanion(
      isChecked: isChecked ?? this.isChecked,
      planId: planId ?? this.planId,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      createdOn: createdOn ?? this.createdOn,
      modifiedOn: modifiedOn ?? this.modifiedOn,
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (isChecked.present) {
      map['is_checked'] = Variable<bool>(isChecked.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<int>(planId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<String>(startTime.value);
    }
    if (createdOn.present) {
      map['created_on'] = Variable<DateTime>(createdOn.value);
    }
    if (modifiedOn.present) {
      map['modified_on'] = Variable<DateTime>(modifiedOn.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExecutionsCompanion(')
          ..write('isChecked: $isChecked, ')
          ..write('planId: $planId, ')
          ..write('title: $title, ')
          ..write('startDate: $startDate, ')
          ..write('startTime: $startTime, ')
          ..write('createdOn: $createdOn, ')
          ..write('modifiedOn: $modifiedOn, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlansTable plans = $PlansTable(this);
  late final $ExecutionsTable executions = $ExecutionsTable(this);
  late final PlansDao plansDao = PlansDao(this as AppDatabase);
  late final ExecutionsDao executionsDao = ExecutionsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [plans, executions];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$PlansTableCreateCompanionBuilder = PlansCompanion Function({
  required String startDate,
  required String startTime,
  Value<String?> weekdays,
  Value<String?> endDate,
  required DateTime createdOn,
  required DateTime modifiedOn,
  Value<int> id,
  required String title,
});
typedef $$PlansTableUpdateCompanionBuilder = PlansCompanion Function({
  Value<String> startDate,
  Value<String> startTime,
  Value<String?> weekdays,
  Value<String?> endDate,
  Value<DateTime> createdOn,
  Value<DateTime> modifiedOn,
  Value<int> id,
  Value<String> title,
});

class $$PlansTableFilterComposer extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get weekdays => $composableBuilder(
      column: $table.weekdays, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdOn => $composableBuilder(
      column: $table.createdOn, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get modifiedOn => $composableBuilder(
      column: $table.modifiedOn, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));
}

class $$PlansTableOrderingComposer
    extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get weekdays => $composableBuilder(
      column: $table.weekdays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdOn => $composableBuilder(
      column: $table.createdOn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get modifiedOn => $composableBuilder(
      column: $table.modifiedOn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));
}

class $$PlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<String> get weekdays =>
      $composableBuilder(column: $table.weekdays, builder: (column) => column);

  GeneratedColumn<String> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdOn =>
      $composableBuilder(column: $table.createdOn, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedOn => $composableBuilder(
      column: $table.modifiedOn, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);
}

class $$PlansTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlansTable,
    Plan,
    $$PlansTableFilterComposer,
    $$PlansTableOrderingComposer,
    $$PlansTableAnnotationComposer,
    $$PlansTableCreateCompanionBuilder,
    $$PlansTableUpdateCompanionBuilder,
    (Plan, BaseReferences<_$AppDatabase, $PlansTable, Plan>),
    Plan,
    PrefetchHooks Function()> {
  $$PlansTableTableManager(_$AppDatabase db, $PlansTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> startDate = const Value.absent(),
            Value<String> startTime = const Value.absent(),
            Value<String?> weekdays = const Value.absent(),
            Value<String?> endDate = const Value.absent(),
            Value<DateTime> createdOn = const Value.absent(),
            Value<DateTime> modifiedOn = const Value.absent(),
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
          }) =>
              PlansCompanion(
            startDate: startDate,
            startTime: startTime,
            weekdays: weekdays,
            endDate: endDate,
            createdOn: createdOn,
            modifiedOn: modifiedOn,
            id: id,
            title: title,
          ),
          createCompanionCallback: ({
            required String startDate,
            required String startTime,
            Value<String?> weekdays = const Value.absent(),
            Value<String?> endDate = const Value.absent(),
            required DateTime createdOn,
            required DateTime modifiedOn,
            Value<int> id = const Value.absent(),
            required String title,
          }) =>
              PlansCompanion.insert(
            startDate: startDate,
            startTime: startTime,
            weekdays: weekdays,
            endDate: endDate,
            createdOn: createdOn,
            modifiedOn: modifiedOn,
            id: id,
            title: title,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PlansTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlansTable,
    Plan,
    $$PlansTableFilterComposer,
    $$PlansTableOrderingComposer,
    $$PlansTableAnnotationComposer,
    $$PlansTableCreateCompanionBuilder,
    $$PlansTableUpdateCompanionBuilder,
    (Plan, BaseReferences<_$AppDatabase, $PlansTable, Plan>),
    Plan,
    PrefetchHooks Function()>;
typedef $$ExecutionsTableCreateCompanionBuilder = ExecutionsCompanion Function({
  required bool isChecked,
  required int planId,
  required String title,
  required String startDate,
  required String startTime,
  required DateTime createdOn,
  required DateTime modifiedOn,
  Value<int> id,
});
typedef $$ExecutionsTableUpdateCompanionBuilder = ExecutionsCompanion Function({
  Value<bool> isChecked,
  Value<int> planId,
  Value<String> title,
  Value<String> startDate,
  Value<String> startTime,
  Value<DateTime> createdOn,
  Value<DateTime> modifiedOn,
  Value<int> id,
});

class $$ExecutionsTableFilterComposer
    extends Composer<_$AppDatabase, $ExecutionsTable> {
  $$ExecutionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get isChecked => $composableBuilder(
      column: $table.isChecked, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get planId => $composableBuilder(
      column: $table.planId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdOn => $composableBuilder(
      column: $table.createdOn, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get modifiedOn => $composableBuilder(
      column: $table.modifiedOn, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));
}

class $$ExecutionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExecutionsTable> {
  $$ExecutionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get isChecked => $composableBuilder(
      column: $table.isChecked, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get planId => $composableBuilder(
      column: $table.planId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdOn => $composableBuilder(
      column: $table.createdOn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get modifiedOn => $composableBuilder(
      column: $table.modifiedOn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));
}

class $$ExecutionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExecutionsTable> {
  $$ExecutionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get isChecked =>
      $composableBuilder(column: $table.isChecked, builder: (column) => column);

  GeneratedColumn<int> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get createdOn =>
      $composableBuilder(column: $table.createdOn, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedOn => $composableBuilder(
      column: $table.modifiedOn, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);
}

class $$ExecutionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExecutionsTable,
    Execution,
    $$ExecutionsTableFilterComposer,
    $$ExecutionsTableOrderingComposer,
    $$ExecutionsTableAnnotationComposer,
    $$ExecutionsTableCreateCompanionBuilder,
    $$ExecutionsTableUpdateCompanionBuilder,
    (Execution, BaseReferences<_$AppDatabase, $ExecutionsTable, Execution>),
    Execution,
    PrefetchHooks Function()> {
  $$ExecutionsTableTableManager(_$AppDatabase db, $ExecutionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExecutionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExecutionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExecutionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<bool> isChecked = const Value.absent(),
            Value<int> planId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> startDate = const Value.absent(),
            Value<String> startTime = const Value.absent(),
            Value<DateTime> createdOn = const Value.absent(),
            Value<DateTime> modifiedOn = const Value.absent(),
            Value<int> id = const Value.absent(),
          }) =>
              ExecutionsCompanion(
            isChecked: isChecked,
            planId: planId,
            title: title,
            startDate: startDate,
            startTime: startTime,
            createdOn: createdOn,
            modifiedOn: modifiedOn,
            id: id,
          ),
          createCompanionCallback: ({
            required bool isChecked,
            required int planId,
            required String title,
            required String startDate,
            required String startTime,
            required DateTime createdOn,
            required DateTime modifiedOn,
            Value<int> id = const Value.absent(),
          }) =>
              ExecutionsCompanion.insert(
            isChecked: isChecked,
            planId: planId,
            title: title,
            startDate: startDate,
            startTime: startTime,
            createdOn: createdOn,
            modifiedOn: modifiedOn,
            id: id,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExecutionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExecutionsTable,
    Execution,
    $$ExecutionsTableFilterComposer,
    $$ExecutionsTableOrderingComposer,
    $$ExecutionsTableAnnotationComposer,
    $$ExecutionsTableCreateCompanionBuilder,
    $$ExecutionsTableUpdateCompanionBuilder,
    (Execution, BaseReferences<_$AppDatabase, $ExecutionsTable, Execution>),
    Execution,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlansTableTableManager get plans =>
      $$PlansTableTableManager(_db, _db.plans);
  $$ExecutionsTableTableManager get executions =>
      $$ExecutionsTableTableManager(_db, _db.executions);
}
