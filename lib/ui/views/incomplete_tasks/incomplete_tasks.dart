import 'package:flutter/material.dart';

class IncompleteTasksView extends StatefulWidget {
  const IncompleteTasksView({Key? key}) : super(key: key);

  @override
  _IncompleteTasksViewState createState() => _IncompleteTasksViewState();
}

class _IncompleteTasksViewState extends State<IncompleteTasksView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.red,
      child: Center(
        child: Text(
          'Incomplete Tasks',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
