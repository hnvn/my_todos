import 'package:flutter/material.dart';
import 'package:my_todos/database/todos_db.dart';
import 'package:my_todos/localizations/app_localization.dart';
import 'package:my_todos/logic/blocs/todos.dart';
import 'package:my_todos/ui/widgets/todo_list.dart';
import 'package:provider/provider.dart';

class IncompleteTasksView extends StatelessWidget {
  const IncompleteTasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bloc = Provider.of<TodosBloc>(context, listen: false);
    return SizedBox.expand(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: topPadding + 24.0,
              left: 16.0,
              bottom: 12.0,
            ),
            child: Text(
              AppLocalization.of(context)!.incompleteTitle,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Divider(height: 1.0),
          Expanded(
            child: StreamBuilder<List<TodoItem>?>(
              stream: bloc.loadIncompleteTodoEntries(),
              builder: (_, snapshot) => MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: AsyncTodoList(dataSnapshot: snapshot),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
