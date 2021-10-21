import 'package:flutter/material.dart';
import 'package:my_todos/database/todos_db.dart';
import 'package:my_todos/localizations/app_localization.dart';
import 'package:my_todos/ui/widgets/todo_tile.dart';

class AsyncTodoList extends StatelessWidget {
  final AsyncSnapshot<List<TodoItem>?> dataSnapshot;

  const AsyncTodoList({
    Key? key,
    required this.dataSnapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = dataSnapshot.data;
    if (list != null && list.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 8.0),
        itemBuilder: (_, index) {
          final item = list[index];
          return TodoTile(data: item);
        },
        itemCount: list.length,
      );
    } else if (list != null && list.isEmpty) {
      return Center(
        child: Text(
          AppLocalization.of(context)!.noDataMessage,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Theme.of(context).textTheme.caption!.color),
        ),
      );
    } else if (dataSnapshot.hasError) {
      return Center(
        child: Text(
          AppLocalization.of(context)!.commonErrorMessage,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Theme.of(context).textTheme.caption!.color),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
