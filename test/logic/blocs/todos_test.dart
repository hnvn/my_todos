import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_todos/database/todos_db.dart';
import 'package:my_todos/logic/blocs/todos.dart';

void main() {
  late TodosDatabase db;

  setUp(() {
    db = TodosDatabase.mock(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('test todo bloc,', () {
    test('add new todo', () async {
      final bloc = TodosBloc.mock(db);

      await bloc.addNewTodo('Task 1');

      final list1 = await bloc.loadAllTodoEntries().first;

      expect(list1.length, equals(1));
      expect(list1.first.title, equals('Task 1'));

      final list2 = await bloc.loadCompleteTodoEntries().first;

      expect(list2.isEmpty, isTrue);

      final list3 = await bloc.loadIncompleteTodoEntries().first;

      expect(list3.length, equals(1));
    });

    test('toggle complete todo', () async {
      final bloc = TodosBloc.mock(db);

      await bloc.addNewTodo('Task 1');

      final allList1 = await bloc.loadAllTodoEntries().first;
      final completeList1 = await bloc.loadCompleteTodoEntries().first;
      final incompleteList1 = await bloc.loadIncompleteTodoEntries().first;

      expect(allList1.first.title, equals('Task 1'));
      expect(allList1.first.isComplete, isFalse);
      expect(completeList1.isEmpty, isTrue);
      expect(incompleteList1.length, equals(1));
      expect(incompleteList1.first.title, equals('Task 1'));

      await bloc.toggleCompleteTodo(allList1.first);

      final allList2 = await bloc.loadAllTodoEntries().first;
      final completeList2 = await bloc.loadCompleteTodoEntries().first;
      final incompleteList2 = await bloc.loadIncompleteTodoEntries().first;

      expect(allList2.first.isComplete, isTrue);
      expect(completeList2.length, equals(1));
      expect(completeList2.first.title, equals('Task 1'));
      expect(incompleteList2.isEmpty, isTrue);
    });
  });
}
