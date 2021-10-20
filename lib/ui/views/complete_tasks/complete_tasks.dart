import 'package:flutter/material.dart';

class CompleteTasksView extends StatefulWidget {
  const CompleteTasksView({Key? key}) : super(key: key);

  @override
  _CompleteTasksViewState createState() => _CompleteTasksViewState();
}

class _CompleteTasksViewState extends State<CompleteTasksView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.green,
      child: Center(
        child: Text(
          'Complete Tasks',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
