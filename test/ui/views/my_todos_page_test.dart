import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'package:my_todos/database/todos_db.dart';
import 'package:my_todos/localizations/app_localization.dart';
import 'package:my_todos/logic/blocs/todos.dart';
import 'package:my_todos/ui/views/all_tasks_view.dart';
import 'package:my_todos/ui/views/complete_tasks_view.dart';
import 'package:my_todos/ui/views/incomplete_tasks_view.dart';
import 'package:my_todos/ui/views/my_todos_page.dart';

import 'my_todos_page_test.mocks.dart';

@GenerateMocks([TodosBloc])
void main() {
  testWidgets('test switching page', (tester) async {
    final TodosBloc bloc = MockTodosBloc();

    when(bloc.loadAllTodoEntries())
        .thenAnswer((_) => Stream.value(<TodoItem>[]).asBroadcastStream());
    when(bloc.loadCompleteTodoEntries())
        .thenAnswer((_) => Stream.value(<TodoItem>[]).asBroadcastStream());
    when(bloc.loadIncompleteTodoEntries())
        .thenAnswer((_) => Stream.value(<TodoItem>[]).asBroadcastStream());

    await tester.pumpWidget(
      MultiProvider(
        providers: [Provider.value(value: bloc)],
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: MyTodosPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    /// verify initial page
    expect(find.byType(AllTasksView), findsOneWidget);
    expect(find.byType(CompleteTasksView), findsNothing);
    expect(find.byType(IncompleteTasksView), findsNothing);

    /// tap on bottom menu to switch page
    await tester.tap(find.ancestor(
      of: find.text('Complete'),
      matching: find.byType(InkResponse),
    ));

    await tester.pumpAndSettle();

    /// verify new page
    expect(find.byType(CompleteTasksView), findsOneWidget);

    /// tap on bottom menu to switch page
    await tester.tap(find.ancestor(
      of: find.text('Incomplete'),
      matching: find.byType(InkResponse),
    ));

    await tester.pumpAndSettle();

    /// verify new page
    expect(find.byType(IncompleteTasksView), findsOneWidget);
  });
}
