import 'package:drift/drift.dart';
import 'package:my_todos/database/todos_db.dart';

class TodosBloc {
  final _database = TodosDatabase();

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

  Future<void> markCompleteTodo(TodoItem item) {
    return _database.updateTodo(TodoItemsCompanion(
      id: Value(item.id),
      title: Value(item.title),
      isComplete: const Value(true),
    ));
  }

  void dispose() {}
}
