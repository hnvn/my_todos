import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

ThemeData theme = ThemeData(
  brightness: Brightness.light,
  primaryTextTheme: textTheme,
  colorScheme: const ColorScheme.light(),
);

TextTheme textTheme = ThemeData.light().textTheme;
