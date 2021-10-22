import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_todos/database/todos_db.dart';
import 'package:my_todos/localizations/app_localization.dart';
import 'package:my_todos/logic/blocs/todos.dart';
import 'package:my_todos/ui/views/all_tasks_view.dart';
import 'package:provider/provider.dart';

void main() {
  late TodosDatabase db;
  late TodosBloc bloc;

  setUp(() {
    db = TodosDatabase.mock(NativeDatabase.memory());
    bloc = TodosBloc.mock(db);
  });

  group('test all tasks view,', () {});

  testWidgets('test all tasks view', (tester) async {
    await db
        .into(db.todoItems)
        .insert(TodoItemsCompanion.insert(title: 'Task 1', isComplete: false));

    await tester.pumpWidget(MultiProvider(
      providers: [
        Provider.value(value: bloc),
      ],
      child: const MaterialApp(
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Scaffold(
          body: AllTasksView(),
        ),
      ),
    ));

    await tester.pumpAndSettle();

    /// verify appearance info, expect: "Task 1" text, normal text style, not checked checkbox
    final todoItem1 = (await bloc.loadAllTodoEntries().first).first;
    expect(todoItem1.title, equals('Task 1'));
    expect(todoItem1.isComplete, isFalse);
    expect(find.text('Task 1'), findsOneWidget);
    expect(tester.widget<Text>(find.text('Task 1')).style?.decoration,
        equals(TextDecoration.none));
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isFalse);

    /// toggle a todo to complete
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    /// verify appearance info, expect: "Task 1" text, text style of line through, checked checkbox
    final todoItem2 = (await bloc.loadAllTodoEntries().first).first;
    expect(todoItem2.isComplete, isTrue);
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);
    expect(tester.widget<Text>(find.text('Task 1')).style?.decoration,
        equals(TextDecoration.lineThrough));

    /// ad a new todo task
    await bloc.addNewTodo('Task 2');
    await tester.pumpAndSettle();

    /// verify appearance info
    /// expect:
    ///  - list of 2 items
    ///  - two texts: "Task 1" and "Task 2"
    ///  - text style of "Task 1" is line through style
    ///  - text style of "Task 2" is normal style
    ///  - checkbox of "Task 1" is checked
    ///  - checkbox of "Task 2" is not checked
    final todoList = await bloc.loadAllTodoEntries().first;
    expect(todoList.length, equals(2));
    expect(find.text('Task 1'), findsOneWidget);
    expect(find.text('Task 2'), findsOneWidget);
    expect(tester.widget<Text>(find.text('Task 1')).style?.decoration,
        equals(TextDecoration.lineThrough));
    expect(tester.widget<Text>(find.text('Task 2')).style?.decoration,
        equals(TextDecoration.none));
    expect(
        tester
            .widget<Checkbox>(find.descendant(
                of: find.ancestor(
                    of: find.text('Task 1'),
                    matching: find.byType(CheckboxListTile)),
                matching: find.byType(Checkbox)))
            .value,
        isTrue);
    expect(
        tester
            .widget<Checkbox>(find.descendant(
                of: find.ancestor(
                    of: find.text('Task 2'),
                    matching: find.byType(CheckboxListTile)),
                matching: find.byType(Checkbox)))
            .value,
        isFalse);

    await db.close();
  });
}
