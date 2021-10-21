// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
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
  String get localeName => 'vi';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function> {
    "cancelAction" : MessageLookupByLibrary.simpleMessage("Hủy"),
    "commonErrorMessage" : MessageLookupByLibrary.simpleMessage("Opps, đã có lỗi xảy ra.\nVui lòng khởi động lại ứng dụng và thử lại."),
    "commonErrorShortMessage" : MessageLookupByLibrary.simpleMessage("Đã có lỗi xảy ra. Vui lòng thử lại."),
    "completeTitle" : MessageLookupByLibrary.simpleMessage("Đã hoàn thành"),
    "discardAction" : MessageLookupByLibrary.simpleMessage("Hủy bản nháp"),
    "incompleteTitle" : MessageLookupByLibrary.simpleMessage("Chưa hoàn thành"),
    "newTaskTitle" : MessageLookupByLibrary.simpleMessage("Việc mới cần làm"),
    "noDataMessage" : MessageLookupByLibrary.simpleMessage("Chưa có dữ liệu"),
    "quitNewTaskAlertMessage" : MessageLookupByLibrary.simpleMessage("Bạn có chắc chắn muốn hủy bản nháp hiện tại không?"),
    "quitNewTaskAlertTitle" : MessageLookupByLibrary.simpleMessage("Hủy việc cần làm hiện tại?"),
    "saveAction" : MessageLookupByLibrary.simpleMessage("Lưu"),
    "todosTitle" : MessageLookupByLibrary.simpleMessage("Việc cần làm")
  };
}
