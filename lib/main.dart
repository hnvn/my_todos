import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_todos/localizations/app_localization.dart';
import 'package:my_todos/logic/blocs/todos.dart';
import 'package:my_todos/ui/themes/light_theme.dart' as light;
import 'package:my_todos/ui/themes/dark_theme.dart' as dark;
import 'package:my_todos/ui/views/my_todos_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyTodosApp());
}

class MyTodosApp extends StatefulWidget {
  const MyTodosApp({Key? key}) : super(key: key);

  @override
  State<MyTodosApp> createState() => _MyTodosAppState();
}

class _MyTodosAppState extends State<MyTodosApp> {
  final _todosBloc = TodosBloc();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: _todosBloc),
      ],
      child: MaterialApp(
        title: 'My Todos',
        theme: light.theme,
        darkTheme: dark.theme,
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('vi'),
          Locale('en'),
        ],
        localeResolutionCallback:
            (Locale? locale, Iterable<Locale> supportedLocales) {
          return locale;
        },
        home: const MyTodosPage(),
      ),
    );
  }

  @override
  void dispose() {
    _todosBloc.dispose();
    super.dispose();
  }
}
