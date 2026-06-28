// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $EntriesTable extends Entries with TableInfo<$EntriesTable, Entry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
      'tag', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isPinnedMeta =
      const VerificationMeta('isPinned');
  @override
  late final GeneratedColumn<bool> isPinned = GeneratedColumn<bool>(
      'is_pinned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_pinned" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _reminderIdMeta =
      const VerificationMeta('reminderId');
  @override
  late final GeneratedColumn<String> reminderId = GeneratedColumn<String>(
      'reminder_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        content,
        title,
        createdAt,
        updatedAt,
        tag,
        color,
        isPinned,
        reminderId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entries';
  @override
  VerificationContext validateIntegrity(Insertable<Entry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('is_pinned')) {
      context.handle(_isPinnedMeta,
          isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta));
    }
    if (data.containsKey('reminder_id')) {
      context.handle(
          _reminderIdMeta,
          reminderId.isAcceptableOrUnknown(
              data['reminder_id']!, _reminderIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Entry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Entry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      tag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      isPinned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_pinned'])!,
      reminderId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reminder_id']),
    );
  }

  @override
  $EntriesTable createAlias(String alias) {
    return $EntriesTable(attachedDatabase, alias);
  }
}

class Entry extends DataClass implements Insertable<Entry> {
  final String id;
  final String content;
  final String? title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? tag;
  final String? color;
  final bool isPinned;
  final String? reminderId;
  const Entry(
      {required this.id,
      required this.content,
      this.title,
      required this.createdAt,
      required this.updatedAt,
      this.tag,
      this.color,
      required this.isPinned,
      this.reminderId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || tag != null) {
      map['tag'] = Variable<String>(tag);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['is_pinned'] = Variable<bool>(isPinned);
    if (!nullToAbsent || reminderId != null) {
      map['reminder_id'] = Variable<String>(reminderId);
    }
    return map;
  }

  EntriesCompanion toCompanion(bool nullToAbsent) {
    return EntriesCompanion(
      id: Value(id),
      content: Value(content),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      tag: tag == null && nullToAbsent ? const Value.absent() : Value(tag),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      isPinned: Value(isPinned),
      reminderId: reminderId == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderId),
    );
  }

  factory Entry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Entry(
      id: serializer.fromJson<String>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      title: serializer.fromJson<String?>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      tag: serializer.fromJson<String?>(json['tag']),
      color: serializer.fromJson<String?>(json['color']),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
      reminderId: serializer.fromJson<String?>(json['reminderId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'content': serializer.toJson<String>(content),
      'title': serializer.toJson<String?>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'tag': serializer.toJson<String?>(tag),
      'color': serializer.toJson<String?>(color),
      'isPinned': serializer.toJson<bool>(isPinned),
      'reminderId': serializer.toJson<String?>(reminderId),
    };
  }

  Entry copyWith(
          {String? id,
          String? content,
          Value<String?> title = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<String?> tag = const Value.absent(),
          Value<String?> color = const Value.absent(),
          bool? isPinned,
          Value<String?> reminderId = const Value.absent()}) =>
      Entry(
        id: id ?? this.id,
        content: content ?? this.content,
        title: title.present ? title.value : this.title,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        tag: tag.present ? tag.value : this.tag,
        color: color.present ? color.value : this.color,
        isPinned: isPinned ?? this.isPinned,
        reminderId: reminderId.present ? reminderId.value : this.reminderId,
      );
  Entry copyWithCompanion(EntriesCompanion data) {
    return Entry(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      tag: data.tag.present ? data.tag.value : this.tag,
      color: data.color.present ? data.color.value : this.color,
      isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,
      reminderId:
          data.reminderId.present ? data.reminderId.value : this.reminderId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Entry(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('tag: $tag, ')
          ..write('color: $color, ')
          ..write('isPinned: $isPinned, ')
          ..write('reminderId: $reminderId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, title, createdAt, updatedAt, tag,
      color, isPinned, reminderId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Entry &&
          other.id == this.id &&
          other.content == this.content &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.tag == this.tag &&
          other.color == this.color &&
          other.isPinned == this.isPinned &&
          other.reminderId == this.reminderId);
}

class EntriesCompanion extends UpdateCompanion<Entry> {
  final Value<String> id;
  final Value<String> content;
  final Value<String?> title;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> tag;
  final Value<String?> color;
  final Value<bool> isPinned;
  final Value<String?> reminderId;
  final Value<int> rowid;
  const EntriesCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.tag = const Value.absent(),
    this.color = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.reminderId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntriesCompanion.insert({
    required String id,
    required String content,
    this.title = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.tag = const Value.absent(),
    this.color = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.reminderId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        content = Value(content),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Entry> custom({
    Expression<String>? id,
    Expression<String>? content,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? tag,
    Expression<String>? color,
    Expression<bool>? isPinned,
    Expression<String>? reminderId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (tag != null) 'tag': tag,
      if (color != null) 'color': color,
      if (isPinned != null) 'is_pinned': isPinned,
      if (reminderId != null) 'reminder_id': reminderId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? content,
      Value<String?>? title,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String?>? tag,
      Value<String?>? color,
      Value<bool>? isPinned,
      Value<String?>? reminderId,
      Value<int>? rowid}) {
    return EntriesCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tag: tag ?? this.tag,
      color: color ?? this.color,
      isPinned: isPinned ?? this.isPinned,
      reminderId: reminderId ?? this.reminderId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (reminderId.present) {
      map['reminder_id'] = Variable<String>(reminderId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntriesCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('tag: $tag, ')
          ..write('color: $color, ')
          ..write('isPinned: $isPinned, ')
          ..write('reminderId: $reminderId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dueTimeMeta =
      const VerificationMeta('dueTime');
  @override
  late final GeneratedColumn<DateTime> dueTime = GeneratedColumn<DateTime>(
      'due_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sourceEntryIdMeta =
      const VerificationMeta('sourceEntryId');
  @override
  late final GeneratedColumn<String> sourceEntryId = GeneratedColumn<String>(
      'source_entry_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notificationIdMeta =
      const VerificationMeta('notificationId');
  @override
  late final GeneratedColumn<int> notificationId = GeneratedColumn<int>(
      'notification_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        content,
        dueTime,
        isCompleted,
        createdAt,
        sourceEntryId,
        notificationId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(Insertable<Reminder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('due_time')) {
      context.handle(_dueTimeMeta,
          dueTime.isAcceptableOrUnknown(data['due_time']!, _dueTimeMeta));
    } else if (isInserting) {
      context.missing(_dueTimeMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('source_entry_id')) {
      context.handle(
          _sourceEntryIdMeta,
          sourceEntryId.isAcceptableOrUnknown(
              data['source_entry_id']!, _sourceEntryIdMeta));
    }
    if (data.containsKey('notification_id')) {
      context.handle(
          _notificationIdMeta,
          notificationId.isAcceptableOrUnknown(
              data['notification_id']!, _notificationIdMeta));
    } else if (isInserting) {
      context.missing(_notificationIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      dueTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_time'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      sourceEntryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_entry_id']),
      notificationId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}notification_id'])!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final String id;
  final String content;
  final DateTime dueTime;
  final bool isCompleted;
  final DateTime createdAt;
  final String? sourceEntryId;
  final int notificationId;
  const Reminder(
      {required this.id,
      required this.content,
      required this.dueTime,
      required this.isCompleted,
      required this.createdAt,
      this.sourceEntryId,
      required this.notificationId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['content'] = Variable<String>(content);
    map['due_time'] = Variable<DateTime>(dueTime);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || sourceEntryId != null) {
      map['source_entry_id'] = Variable<String>(sourceEntryId);
    }
    map['notification_id'] = Variable<int>(notificationId);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      content: Value(content),
      dueTime: Value(dueTime),
      isCompleted: Value(isCompleted),
      createdAt: Value(createdAt),
      sourceEntryId: sourceEntryId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceEntryId),
      notificationId: Value(notificationId),
    );
  }

  factory Reminder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<String>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      dueTime: serializer.fromJson<DateTime>(json['dueTime']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      sourceEntryId: serializer.fromJson<String?>(json['sourceEntryId']),
      notificationId: serializer.fromJson<int>(json['notificationId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'content': serializer.toJson<String>(content),
      'dueTime': serializer.toJson<DateTime>(dueTime),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'sourceEntryId': serializer.toJson<String?>(sourceEntryId),
      'notificationId': serializer.toJson<int>(notificationId),
    };
  }

  Reminder copyWith(
          {String? id,
          String? content,
          DateTime? dueTime,
          bool? isCompleted,
          DateTime? createdAt,
          Value<String?> sourceEntryId = const Value.absent(),
          int? notificationId}) =>
      Reminder(
        id: id ?? this.id,
        content: content ?? this.content,
        dueTime: dueTime ?? this.dueTime,
        isCompleted: isCompleted ?? this.isCompleted,
        createdAt: createdAt ?? this.createdAt,
        sourceEntryId:
            sourceEntryId.present ? sourceEntryId.value : this.sourceEntryId,
        notificationId: notificationId ?? this.notificationId,
      );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
      dueTime: data.dueTime.present ? data.dueTime.value : this.dueTime,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      sourceEntryId: data.sourceEntryId.present
          ? data.sourceEntryId.value
          : this.sourceEntryId,
      notificationId: data.notificationId.present
          ? data.notificationId.value
          : this.notificationId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('dueTime: $dueTime, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('sourceEntryId: $sourceEntryId, ')
          ..write('notificationId: $notificationId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, dueTime, isCompleted, createdAt,
      sourceEntryId, notificationId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.content == this.content &&
          other.dueTime == this.dueTime &&
          other.isCompleted == this.isCompleted &&
          other.createdAt == this.createdAt &&
          other.sourceEntryId == this.sourceEntryId &&
          other.notificationId == this.notificationId);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<String> id;
  final Value<String> content;
  final Value<DateTime> dueTime;
  final Value<bool> isCompleted;
  final Value<DateTime> createdAt;
  final Value<String?> sourceEntryId;
  final Value<int> notificationId;
  final Value<int> rowid;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.dueTime = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.sourceEntryId = const Value.absent(),
    this.notificationId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersCompanion.insert({
    required String id,
    required String content,
    required DateTime dueTime,
    this.isCompleted = const Value.absent(),
    required DateTime createdAt,
    this.sourceEntryId = const Value.absent(),
    required int notificationId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        content = Value(content),
        dueTime = Value(dueTime),
        createdAt = Value(createdAt),
        notificationId = Value(notificationId);
  static Insertable<Reminder> custom({
    Expression<String>? id,
    Expression<String>? content,
    Expression<DateTime>? dueTime,
    Expression<bool>? isCompleted,
    Expression<DateTime>? createdAt,
    Expression<String>? sourceEntryId,
    Expression<int>? notificationId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (dueTime != null) 'due_time': dueTime,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (createdAt != null) 'created_at': createdAt,
      if (sourceEntryId != null) 'source_entry_id': sourceEntryId,
      if (notificationId != null) 'notification_id': notificationId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersCompanion copyWith(
      {Value<String>? id,
      Value<String>? content,
      Value<DateTime>? dueTime,
      Value<bool>? isCompleted,
      Value<DateTime>? createdAt,
      Value<String?>? sourceEntryId,
      Value<int>? notificationId,
      Value<int>? rowid}) {
    return RemindersCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      dueTime: dueTime ?? this.dueTime,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      sourceEntryId: sourceEntryId ?? this.sourceEntryId,
      notificationId: notificationId ?? this.notificationId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (dueTime.present) {
      map['due_time'] = Variable<DateTime>(dueTime.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (sourceEntryId.present) {
      map['source_entry_id'] = Variable<String>(sourceEntryId.value);
    }
    if (notificationId.present) {
      map['notification_id'] = Variable<int>(notificationId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('dueTime: $dueTime, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('sourceEntryId: $sourceEntryId, ')
          ..write('notificationId: $notificationId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabase.connect(DatabaseConnection c) : super.connect(c);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $EntriesTable entries = $EntriesTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final EntryDao entryDao = EntryDao(this as AppDatabase);
  late final ReminderDao reminderDao = ReminderDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [entries, reminders];
}

typedef $$EntriesTableCreateCompanionBuilder = EntriesCompanion Function({
  required String id,
  required String content,
  Value<String?> title,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String?> tag,
  Value<String?> color,
  Value<bool> isPinned,
  Value<String?> reminderId,
  Value<int> rowid,
});
typedef $$EntriesTableUpdateCompanionBuilder = EntriesCompanion Function({
  Value<String> id,
  Value<String> content,
  Value<String?> title,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String?> tag,
  Value<String?> color,
  Value<bool> isPinned,
  Value<String?> reminderId,
  Value<int> rowid,
});

class $$EntriesTableFilterComposer
    extends Composer<_$AppDatabase, $EntriesTable> {
  $$EntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tag => $composableBuilder(
      column: $table.tag, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPinned => $composableBuilder(
      column: $table.isPinned, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderId => $composableBuilder(
      column: $table.reminderId, builder: (column) => ColumnFilters(column));
}

class $$EntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $EntriesTable> {
  $$EntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tag => $composableBuilder(
      column: $table.tag, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPinned => $composableBuilder(
      column: $table.isPinned, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderId => $composableBuilder(
      column: $table.reminderId, builder: (column) => ColumnOrderings(column));
}

class $$EntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntriesTable> {
  $$EntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<bool> get isPinned =>
      $composableBuilder(column: $table.isPinned, builder: (column) => column);

  GeneratedColumn<String> get reminderId => $composableBuilder(
      column: $table.reminderId, builder: (column) => column);
}

class $$EntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EntriesTable,
    Entry,
    $$EntriesTableFilterComposer,
    $$EntriesTableOrderingComposer,
    $$EntriesTableAnnotationComposer,
    $$EntriesTableCreateCompanionBuilder,
    $$EntriesTableUpdateCompanionBuilder,
    (Entry, BaseReferences<_$AppDatabase, $EntriesTable, Entry>),
    Entry,
    PrefetchHooks Function()> {
  $$EntriesTableTableManager(_$AppDatabase db, $EntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String?> tag = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<bool> isPinned = const Value.absent(),
            Value<String?> reminderId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EntriesCompanion(
            id: id,
            content: content,
            title: title,
            createdAt: createdAt,
            updatedAt: updatedAt,
            tag: tag,
            color: color,
            isPinned: isPinned,
            reminderId: reminderId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String content,
            Value<String?> title = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String?> tag = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<bool> isPinned = const Value.absent(),
            Value<String?> reminderId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EntriesCompanion.insert(
            id: id,
            content: content,
            title: title,
            createdAt: createdAt,
            updatedAt: updatedAt,
            tag: tag,
            color: color,
            isPinned: isPinned,
            reminderId: reminderId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EntriesTable,
    Entry,
    $$EntriesTableFilterComposer,
    $$EntriesTableOrderingComposer,
    $$EntriesTableAnnotationComposer,
    $$EntriesTableCreateCompanionBuilder,
    $$EntriesTableUpdateCompanionBuilder,
    (Entry, BaseReferences<_$AppDatabase, $EntriesTable, Entry>),
    Entry,
    PrefetchHooks Function()>;
typedef $$RemindersTableCreateCompanionBuilder = RemindersCompanion Function({
  required String id,
  required String content,
  required DateTime dueTime,
  Value<bool> isCompleted,
  required DateTime createdAt,
  Value<String?> sourceEntryId,
  required int notificationId,
  Value<int> rowid,
});
typedef $$RemindersTableUpdateCompanionBuilder = RemindersCompanion Function({
  Value<String> id,
  Value<String> content,
  Value<DateTime> dueTime,
  Value<bool> isCompleted,
  Value<DateTime> createdAt,
  Value<String?> sourceEntryId,
  Value<int> notificationId,
  Value<int> rowid,
});

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueTime => $composableBuilder(
      column: $table.dueTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceEntryId => $composableBuilder(
      column: $table.sourceEntryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get notificationId => $composableBuilder(
      column: $table.notificationId,
      builder: (column) => ColumnFilters(column));
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueTime => $composableBuilder(
      column: $table.dueTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceEntryId => $composableBuilder(
      column: $table.sourceEntryId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get notificationId => $composableBuilder(
      column: $table.notificationId,
      builder: (column) => ColumnOrderings(column));
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get dueTime =>
      $composableBuilder(column: $table.dueTime, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get sourceEntryId => $composableBuilder(
      column: $table.sourceEntryId, builder: (column) => column);

  GeneratedColumn<int> get notificationId => $composableBuilder(
      column: $table.notificationId, builder: (column) => column);
}

class $$RemindersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RemindersTable,
    Reminder,
    $$RemindersTableFilterComposer,
    $$RemindersTableOrderingComposer,
    $$RemindersTableAnnotationComposer,
    $$RemindersTableCreateCompanionBuilder,
    $$RemindersTableUpdateCompanionBuilder,
    (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
    Reminder,
    PrefetchHooks Function()> {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<DateTime> dueTime = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String?> sourceEntryId = const Value.absent(),
            Value<int> notificationId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RemindersCompanion(
            id: id,
            content: content,
            dueTime: dueTime,
            isCompleted: isCompleted,
            createdAt: createdAt,
            sourceEntryId: sourceEntryId,
            notificationId: notificationId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String content,
            required DateTime dueTime,
            Value<bool> isCompleted = const Value.absent(),
            required DateTime createdAt,
            Value<String?> sourceEntryId = const Value.absent(),
            required int notificationId,
            Value<int> rowid = const Value.absent(),
          }) =>
              RemindersCompanion.insert(
            id: id,
            content: content,
            dueTime: dueTime,
            isCompleted: isCompleted,
            createdAt: createdAt,
            sourceEntryId: sourceEntryId,
            notificationId: notificationId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RemindersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RemindersTable,
    Reminder,
    $$RemindersTableFilterComposer,
    $$RemindersTableOrderingComposer,
    $$RemindersTableAnnotationComposer,
    $$RemindersTableCreateCompanionBuilder,
    $$RemindersTableUpdateCompanionBuilder,
    (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
    Reminder,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EntriesTableTableManager get entries =>
      $$EntriesTableTableManager(_db, _db.entries);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
}

mixin _$EntryDaoMixin on DatabaseAccessor<AppDatabase> {
  $EntriesTable get entries => attachedDatabase.entries;
}
mixin _$ReminderDaoMixin on DatabaseAccessor<AppDatabase> {
  $RemindersTable get reminders => attachedDatabase.reminders;
}
