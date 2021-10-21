import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_todos/localizations/app_localization.dart';
import 'package:my_todos/ui/widgets/new_todo_sheet.dart';

void main() {
  testWidgets('test create new todo sheet', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Material(
          child: Builder(
            builder: (context) {
              return Center(
                child: ElevatedButton(
                  child: const Text('X'),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      enableDrag: false,
                      isDismissible: false,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (c) => Padding(
                        padding: MediaQuery.of(c).viewInsets,
                        child: const NewTodoSheet(),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.text('X'));
    await tester.pumpAndSettle();

    /// verify dialog appearance
    expect(find.byType(NewTodoSheet), findsOneWidget);

    /// verify save button state, expect the button is disabled at first
    expect(
        tester
            .widget<TextButton>(find.ancestor(
                of: find.text('Save'), matching: find.byType(TextButton)))
            .onPressed,
        isNull);

    /// enter some text into textfield
    await tester.enterText(
        find.descendant(
            of: find.byType(NewTodoSheet), matching: find.byType(TextField)),
        'task');
    await tester.pumpAndSettle();

    /// verify save button state, expect the button is enabled
    expect(
        tester
            .widget<TextButton>(find.ancestor(
                of: find.text('Save'), matching: find.byType(TextButton)))
            .onPressed,
        isNotNull);

    /// tap on outside of the sheet
    await tester.tap(find.byKey(const ValueKey('hit_box')));
    await tester.pumpAndSettle();

    /// verify dismiss flow, if the textfield is not empty then expect that warning alert is shown
    expect(
        find.byKey(
          const ValueKey('discard_warning'),
        ),
        findsOneWidget);

    /// dismiss warning alert
    await tester.tap(find.descendant(
        of: find.byKey(
          const ValueKey('discard_warning'),
        ),
        matching: find.text('Cancel')));
    await tester.pumpAndSettle();

    /// clear text on textfield
    await tester.enterText(
        find.descendant(
            of: find.byType(NewTodoSheet), matching: find.byType(TextField)),
        '');

    /// tap on outside of the sheet
    await tester.tap(find.byKey(const ValueKey('hit_box')));
    await tester.pumpAndSettle();

    /// verify dialog appearance, expect the dialog is dismissed
    expect(find.byType(NewTodoSheet), findsNothing);
  });
}
