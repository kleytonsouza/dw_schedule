import 'package:dw_schedule/src/core/fb/either.dart';
import 'package:dw_schedule/src/core/restClient/rest_client.dart';
import 'package:dw_schedule/src/core/ui/schedule_nav_global_key.dart';
import 'package:dw_schedule/src/model/schedule_model.dart';
import 'package:dw_schedule/src/model/user_model.dart';
import 'package:dw_schedule/src/repositories/appointment/appointment_repository.dart';
import 'package:dw_schedule/src/repositories/appointment/appointment_repository_impl.dart';
import 'package:dw_schedule/src/repositories/schedule/schedule_repository.dart';
import 'package:dw_schedule/src/repositories/schedule/schedule_repository_impl.dart';
import 'package:dw_schedule/src/repositories/user/user_repository.dart';
import 'package:dw_schedule/src/repositories/user/user_repository_impl.dart';
import 'package:dw_schedule/src/services/users_login/user_login_service.dart';
import 'package:dw_schedule/src/services/users_login/user_login_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
    UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();

  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
ScheduleRepository scheduleRepository(ScheduleRepositoryRef ref) =>
    ScheduleRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<ScheduleModel> getMySchedule(GetMyScheduleRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);

  final scheduleRepository = ref.watch(scheduleRepositoryProvider);
  final result = await scheduleRepository.getMySchedule(userModel);

  return switch (result) {
    Success(value: final schedule) => schedule,
    Failure(:final exception) => throw exception
  };
}

@Riverpod()
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();
  sp.clear();

  ref.invalidate(getMeProvider);
  ref.invalidate(getMyScheduleProvider);
  Navigator.of(ScheduleNavGlobalKey.instance.navKey.currentContext!)
      .pushNamedAndRemoveUntil('/auth/login', (route) => false);
}


@riverpod
AppointmentRepository appointmentRepository(AppointmentRepositoryRef ref) =>
    AppointmentRepositoryImpl(restClient: ref.read(restClientProvider));
