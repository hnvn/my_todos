import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_todos/ui/views/all_tasks/all_tasks_view.dart';
import 'package:my_todos/ui/views/complete_tasks/complete_tasks.dart';
import 'package:my_todos/ui/views/incomplete_tasks/incomplete_tasks.dart';
import 'package:my_todos/ui/views/my_todos_page.dart';

void main() {
  testWidgets('test switching page', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyTodosPage(),
      ),
    );

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
