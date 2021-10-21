import 'package:flutter/material.dart';
import 'package:my_todos/localizations/app_localization.dart';
import 'package:my_todos/ui/views/all_tasks/all_tasks_view.dart';
import 'package:my_todos/ui/views/complete_tasks/complete_tasks.dart';
import 'package:my_todos/ui/views/incomplete_tasks/incomplete_tasks.dart';
import 'package:my_todos/ui/widgets/new_todo_sheet.dart';

class MyTodosPage extends StatefulWidget {
  const MyTodosPage({Key? key}) : super(key: key);

  @override
  _MyTodosPageState createState() => _MyTodosPageState();
}

class _MyTodosPageState extends State<MyTodosPage> {
  final _pageController = PageController(initialPage: 0, keepPage: true);
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyPageView(),
      bottomNavigationBar: _bottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewTodoSheet();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _bodyPageView() => PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          AllTasksView(),
          CompleteTasksView(),
          IncompleteTasksView()
        ],
      );

  Widget _bottomNavBar() => BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: _onBottomNavItemTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
                _currentPageIndex == 0 ? Icons.ballot : Icons.ballot_outlined),
            label: AppLocalization.of(context)!.todosTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentPageIndex == 1
                ? Icons.check_box
                : Icons.check_box_outlined),
            label: AppLocalization.of(context)!.completeTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentPageIndex == 2
                ? Icons.indeterminate_check_box
                : Icons.indeterminate_check_box_outlined),
            label: AppLocalization.of(context)!.incompleteTitle,
          )
        ],
      );

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void _onBottomNavItemTap(int index) {
    setState(() {
      _currentPageIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut);
  }

  Future<void> _showNewTodoSheet() async {
    await showModalBottomSheet(
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
  }
}
