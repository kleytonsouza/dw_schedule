import 'package:dw_schedule/src/core/fb/either.dart';
import 'package:dw_schedule/src/core/restClient/rest_client.dart';
import 'package:dw_schedule/src/model/schedule_model.dart';
import 'package:dw_schedule/src/model/user_model.dart';
import 'package:dw_schedule/src/repositories/schedule/schedule_repository.dart';
import 'package:dw_schedule/src/repositories/schedule/schedule_repository_impl.dart';
import 'package:dw_schedule/src/repositories/user/user_repository.dart';
import 'package:dw_schedule/src/repositories/user/user_repository_impl.dart';
import 'package:dw_schedule/src/services/users_login/user_login_service.dart';
import 'package:dw_schedule/src/services/users_login/user_login_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
