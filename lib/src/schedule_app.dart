import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:dw_schedule/src/core/ui/schedule_nav_global_key.dart';
import 'package:dw_schedule/src/core/ui/schedule_theme.dart';
import 'package:dw_schedule/src/core/ui/widgets/schedule_loader.dart';
import 'package:dw_schedule/src/features/auth/login/login_page.dart';
import 'package:dw_schedule/src/features/auth/register/schedule/schedule_register_page.dart';
import 'package:dw_schedule/src/features/auth/register/user/user_register_page.dart';
import 'package:dw_schedule/src/features/employee/register/employee_register_page.dart';
import 'package:dw_schedule/src/features/home/adm/home_adm_page.dart';
import 'package:dw_schedule/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class ScheduleApp extends StatelessWidget {
  const ScheduleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const ScheduleLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: "events ufpr",
          theme: ScheduleTheme.themeData,
          navigatorKey: ScheduleNavGlobalKey.instance.navKey,
          navigatorObservers: [asyncNavigatorObserver],
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
            '/auth/register/user': (_) => const UserRegisterPage(),
            '/home/register/schedule': (_) => const ScheduleRegisterPage(),
            '/home/adm': (_) => const HomeAdmPage(),
            '/home/employee': (_) => const Text('Employee'),
            '/home/register': (_) => const EmployeeRegisterPage(),
          },
        );
      },
    );
  }
}
