import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'todos_db.g.dart';

class TodoItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  BoolColumn get isComplete => boolean()();
}

@DriftDatabase(tables: [TodoItems])
class TodosDatabase extends _$TodosDatabase {
  TodosDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// load all todo entries and keep listening data changing by stream
  Stream<List<TodoItem>> get watchAllTodoEntries => select(todoItems).watch();

  /// load all complete todo entries and keep listening data changing by stream
  Stream<List<TodoItem>> get watchCompleteTodoEntries =>
      (select(todoItems)..where((t) => t.isComplete.equals(true))).watch();

  /// load all incomplete todo entries and keep listening data changing by stream
  Stream<List<TodoItem>> get watchIncompleteTodoEntries =>
      (select(todoItems)..where((t) => t.isComplete.equals(false))).watch();
}

/// template codes from Drift docs
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
