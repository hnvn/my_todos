import 'package:flutter/material.dart';

class AllTasksView extends StatefulWidget {
  const AllTasksView({Key? key}) : super(key: key);

  @override
  _AllTasksViewState createState() => _AllTasksViewState();
}

class _AllTasksViewState extends State<AllTasksView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.blue,
      child: Center(
        child: Text(
          'All Tasks',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
