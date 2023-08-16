import 'package:dw_schedule/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

sealed class ScheduleTheme {
  static ThemeData themeData = ThemeData(
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: ColorsConstants.grey),
      ));
}
