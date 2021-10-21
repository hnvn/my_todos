import 'package:drift/drift.dart';
import 'package:my_todos/database/todos_db.dart';

class TodosBloc {
  final TodosDatabase _database;

  TodosBloc() : _database = TodosDatabase();

  TodosBloc.mock(TodosDatabase database) : _database = database;

  Stream<List<TodoItem>> loadAllTodoEntries() => _database.watchAllTodoEntries;

  Stream<List<TodoItem>> loadCompleteTodoEntries() =>
      _database.watchCompleteTodoEntries;

  Stream<List<TodoItem>> loadIncompleteTodoEntries() =>
      _database.watchIncompleteTodoEntries;

  Future<void> addNewTodo(String title) {
    return _database.addTodo(
      TodoItemsCompanion.insert(title: title, isComplete: false),
    );
  }

  Future<void> toggleCompleteTodo(TodoItem item) {
    return _database.updateTodo(TodoItemsCompanion(
      id: Value(item.id),
      title: Value(item.title),
      isComplete: const Value(true),
    ));
  }

  Future<void> toggleIncompleteTodo(TodoItem item) {
    return _database.updateTodo(TodoItemsCompanion(
      id: Value(item.id),
      title: Value(item.title),
      isComplete: const Value(false),
    ));
  }

  void dispose() {}
}
