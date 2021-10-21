// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, always_declare_return_types

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String MessageIfAbsent(String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function> {
    "cancelAction" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "commonErrorMessage" : MessageLookupByLibrary.simpleMessage("Opps, something went wrong.\nPlease reopen app and try again."),
    "commonErrorShortMessage" : MessageLookupByLibrary.simpleMessage("Something went wrong. Please try again."),
    "completeTitle" : MessageLookupByLibrary.simpleMessage("Complete"),
    "discardAction" : MessageLookupByLibrary.simpleMessage("Discard"),
    "incompleteTitle" : MessageLookupByLibrary.simpleMessage("Incomplete"),
    "newTaskTitle" : MessageLookupByLibrary.simpleMessage("New task"),
    "noDataMessage" : MessageLookupByLibrary.simpleMessage("No data found"),
    "quitNewTaskAlertMessage" : MessageLookupByLibrary.simpleMessage("Are you sure you want to discard the current draft?"),
    "quitNewTaskAlertTitle" : MessageLookupByLibrary.simpleMessage("Discard current task?"),
    "saveAction" : MessageLookupByLibrary.simpleMessage("Save"),
    "todosTitle" : MessageLookupByLibrary.simpleMessage("Todos")
  };
}
