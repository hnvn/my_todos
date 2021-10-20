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
}
