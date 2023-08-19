import 'package:flutter/material.dart';

class ScheduleNavGlobalKey {
  static ScheduleNavGlobalKey? _instance;
  final navKey = GlobalKey<NavigatorState>();

  ScheduleNavGlobalKey._();

  static ScheduleNavGlobalKey get instance =>
      _instance ??= ScheduleNavGlobalKey._();
}
