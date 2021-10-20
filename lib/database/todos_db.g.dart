// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class TodoItem extends DataClass implements Insertable<TodoItem> {
  final int id;
  final String title;
  final bool isComplete;
  TodoItem({required this.id, required this.title, required this.isComplete});
  factory TodoItem.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TodoItem(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      isComplete: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_complete'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['is_complete'] = Variable<bool>(isComplete);
    return map;
  }

  TodoItemsCompanion toCompanion(bool nullToAbsent) {
    return TodoItemsCompanion(
      id: Value(id),
      title: Value(title),
      isComplete: Value(isComplete),
    );
  }

  factory TodoItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoItem(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      isComplete: serializer.fromJson<bool>(json['isComplete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'isComplete': serializer.toJson<bool>(isComplete),
    };
  }

  TodoItem copyWith({int? id, String? title, bool? isComplete}) => TodoItem(
        id: id ?? this.id,
        title: title ?? this.title,
        isComplete: isComplete ?? this.isComplete,
      );
  @override
  String toString() {
    return (StringBuffer('TodoItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('isComplete: $isComplete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, isComplete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.isComplete == this.isComplete);
}

class TodoItemsCompanion extends UpdateCompanion<TodoItem> {
  final Value<int> id;
  final Value<String> title;
  final Value<bool> isComplete;
  const TodoItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.isComplete = const Value.absent(),
  });
  TodoItemsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required bool isComplete,
  })  : title = Value(title),
        isComplete = Value(isComplete);
  static Insertable<TodoItem> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<bool>? isComplete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (isComplete != null) 'is_complete': isComplete,
    });
  }

  TodoItemsCompanion copyWith(
      {Value<int>? id, Value<String>? title, Value<bool>? isComplete}) {
    return TodoItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (isComplete.present) {
      map['is_complete'] = Variable<bool>(isComplete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('isComplete: $isComplete')
          ..write(')'))
        .toString();
  }
}

class $TodoItemsTable extends TodoItems
    with TableInfo<$TodoItemsTable, TodoItem> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TodoItemsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _isCompleteMeta = const VerificationMeta('isComplete');
  late final GeneratedColumn<bool?> isComplete = GeneratedColumn<bool?>(
      'is_complete', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_complete IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [id, title, isComplete];
  @override
  String get aliasedName => _alias ?? 'todo_items';
  @override
  String get actualTableName => 'todo_items';
  @override
  VerificationContext validateIntegrity(Insertable<TodoItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('is_complete')) {
      context.handle(
          _isCompleteMeta,
          isComplete.isAcceptableOrUnknown(
              data['is_complete']!, _isCompleteMeta));
    } else if (isInserting) {
      context.missing(_isCompleteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TodoItem.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TodoItemsTable createAlias(String alias) {
    return $TodoItemsTable(_db, alias);
  }
}

abstract class _$TodosDatabase extends GeneratedDatabase {
  _$TodosDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TodoItemsTable todoItems = $TodoItemsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todoItems];
}
