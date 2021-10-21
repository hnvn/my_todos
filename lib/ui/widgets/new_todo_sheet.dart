import 'package:flutter/material.dart';
import 'package:my_todos/localizations/app_localization.dart';
import 'package:rxdart/rxdart.dart';

class NewTodoSheet extends StatefulWidget {
  const NewTodoSheet({Key? key}) : super(key: key);

  @override
  _NewTodoSheetState createState() => _NewTodoSheetState();
}

class _NewTodoSheetState extends State<NewTodoSheet> {
  final _buttonValidatorSubject = BehaviorSubject.seeded(false);
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_handleTextTyping);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        _hitBox(),
        _content(theme),
      ],
    );
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_handleTextTyping);
    _textEditingController.dispose();
    _focusNode.dispose();
    _buttonValidatorSubject.close();
    super.dispose();
  }

  Widget _hitBox() {
    return SizedBox.expand(
      child: GestureDetector(
        key: const ValueKey('hit_box'),
        onTap: _quitOrAskUser,
      ),
    );
  }

  Widget _content(ThemeData theme) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0,
                  ),
                  child: TextField(
                      controller: _textEditingController,
                      focusNode: _focusNode,
                      autofocus: true,
                      expands: true,
                      maxLines: null,
                      textInputAction: TextInputAction.done,
                      keyboardAppearance: theme.brightness,
                      decoration: InputDecoration.collapsed(
                        hintText: AppLocalization.of(context)!.newTaskTitle,
                      ),
                      onSubmitted: (_) {
                        _saveData();
                      }),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: StreamBuilder<bool>(
                      stream: _buttonValidatorSubject
                          .debounceTime(const Duration(milliseconds: 200))
                          .distinct(),
                      builder: (context, snapshot) {
                        final isActive = snapshot.data ?? false;
                        return TextButton(
                          onPressed: isActive ? _saveData : null,
                          child: Text(AppLocalization.of(context)!.saveAction),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTextTyping() {
    final text = _textEditingController.text;
    _buttonValidatorSubject.add(text.isNotEmpty);
  }

  void _saveData() {
    final text = _textEditingController.text;
    Navigator.of(context).pop(text);
  }

  void _quitOrAskUser() {
    final text = _textEditingController.text;
    if (text.isNotEmpty) {
      _showQuitWarningAlert();
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> _showQuitWarningAlert() async {
    /// unfocus to hide keyboard before displaying alert
    /// this also prevents keyboard from being appear temporarily right after
    /// user choose Discard option (it causes an odd animation when the sheet hiding)
    _focusNode.unfocus();

    final result = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        key: const ValueKey('discard_warning'),
        title: Text(AppLocalization.of(context)!.quitNewTaskAlertTitle),
        content: Text(AppLocalization.of(context)!.quitNewTaskAlertMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(c).pop(false);
            },
            child: Text(AppLocalization.of(context)!.cancelAction),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(c).pop(true);
            },
            child: Text(AppLocalization.of(context)!.discardAction),
          ),
        ],
      ),
    );

    if (result == true) {
      Navigator.of(context).pop();
    } else {
      _focusNode.requestFocus();
    }
  }
}
