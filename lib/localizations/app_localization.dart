import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['vi', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class AppLocalization {
  final String? localeName;

  AppLocalization(this.localeName);

  static Future<AppLocalization> load(Locale locale) {
    final String name = locale.countryCode?.isEmpty ?? true
        ? locale.languageCode
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return AppLocalization(localeName);
    });
  }

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  String get todosTitle {
    return Intl.message(
      'Todos',
      name: 'todosTitle',
      locale: localeName,
    );
  }

  String get completeTitle {
    return Intl.message(
      'Complete',
      name: 'completeTitle',
      locale: localeName,
    );
  }

  String get incompleteTitle {
    return Intl.message(
      'Incomplete',
      name: 'incompleteTitle',
      locale: localeName,
    );
  }

  String get newTaskTitle {
    return Intl.message(
      'New task',
      name: 'newTaskTitle',
      locale: localeName,
    );
  }

  String get saveAction {
    return Intl.message(
      'Save',
      name: 'saveAction',
      locale: localeName,
    );
  }

  String get quitNewTaskAlertTitle {
    return Intl.message(
      'Discard current task?',
      name: 'quitNewTaskAlertTitle',
      locale: localeName,
    );
  }

  String get quitNewTaskAlertMessage {
    return Intl.message(
      'Are you sure you want to discard the current draft?',
      name: 'quitNewTaskAlertMessage',
      locale: localeName,
    );
  }

  String get cancelAction {
    return Intl.message(
      'Cancel',
      name: 'cancelAction',
      locale: localeName,
    );
  }

  String get discardAction {
    return Intl.message(
      'Discard',
      name: 'discardAction',
      locale: localeName,
    );
  }

  String get noDataMessage {
    return Intl.message(
      'No data found',
      name: 'noDataMessage',
      locale: localeName,
    );
  }

  String get commonErrorMessage {
    return Intl.message(
      'Opps, something went wrong.\nPlease reopen app and try again.',
      name: 'commonErrorMessage',
      locale: localeName,
    );
  }

  String get commonErrorShortMessage {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'commonErrorShortMessage',
      locale: localeName,
    );
  }
}
