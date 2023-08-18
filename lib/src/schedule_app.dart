import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:dw_schedule/src/core/ui/schedule_theme.dart';
import 'package:dw_schedule/src/core/ui/widgets/schedule_loader.dart';
import 'package:dw_schedule/src/features/auth/login/login_page.dart';
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
          navigatorObservers: [asyncNavigatorObserver],
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
            '/auth/adm': (_) => const Text("ADM"),
            '/auth/employee': (_) => const Text("Employee"),
          },
        );
      },
    );
  }
}
