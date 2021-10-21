import 'package:flutter/material.dart';
import 'package:my_todos/database/todos_db.dart';
import 'package:my_todos/logic/blocs/todos.dart';
import 'package:provider/provider.dart';

class TodoTile extends StatefulWidget {
  final TodoItem data;

  const TodoTile({Key? key, required this.data}) : super(key: key);

  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isComplete = widget.data.isComplete;
    final title = widget.data.title;
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: isComplete,
      title: Text(
        title,
        style: theme.textTheme.subtitle1!.copyWith(
          decoration: isComplete ? TextDecoration.lineThrough : null,
        ),
      ),
      onChanged: _onCheckboxChanged,
    );
  }

  void _onCheckboxChanged(bool? value) {
    final bloc = Provider.of<TodosBloc>(context, listen: false);
    if (value == true) {
      bloc.toggleCompleteTodo(widget.data);
    } else if (value == false) {
      bloc.toggleIncompleteTodo(widget.data);
    }
  }
}
