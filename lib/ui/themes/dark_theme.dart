import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

ThemeData theme = ThemeData(
  brightness: Brightness.dark,
  primaryTextTheme: textTheme,
  colorScheme: const ColorScheme.dark(),
);

TextTheme textTheme = ThemeData.dark().textTheme;
