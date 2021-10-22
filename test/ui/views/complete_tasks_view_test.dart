import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_todos/database/todos_db.dart';
import 'package:my_todos/localizations/app_localization.dart';
import 'package:my_todos/logic/blocs/todos.dart';
import 'package:my_todos/ui/views/complete_tasks_view.dart';
import 'package:provider/provider.dart';

void main() {
  late TodosDatabase db;
  late TodosBloc bloc;

  setUp(() {
    db = TodosDatabase.mock(NativeDatabase.memory());
    bloc = TodosBloc.mock(db);
  });

  group('test complete tasks view,', () {
    testWidgets('no complete task', (tester) async {
      await db.into(db.todoItems).insert(
          TodoItemsCompanion.insert(title: 'Task 1', isComplete: false));

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
            body: CompleteTasksView(),
          ),
        ),
      ));

      await tester.pumpAndSettle();

      expect(find.text('No data found'), findsOneWidget);

      await db.close();
    });

    testWidgets('one complete task', (tester) async {
      await db
          .into(db.todoItems)
          .insert(TodoItemsCompanion.insert(title: 'Task 1', isComplete: true));

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
            body: CompleteTasksView(),
          ),
        ),
      ));

      await tester.pumpAndSettle();

      expect(find.text('Task 1'), findsOneWidget);

      /// toggle todo to incomplete
      await tester.tap(find.byType(Checkbox));

      await tester.pumpAndSettle();

      expect(find.text('Task 1'), findsNothing);
      expect(find.text('No data found'), findsOneWidget);

      await db.close();
    });
  });
}
