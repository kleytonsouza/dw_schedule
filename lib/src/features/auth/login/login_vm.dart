import 'package:asyncstate/asyncstate.dart';
import 'package:dw_schedule/src/core/exceptions/service_exception.dart';
import 'package:dw_schedule/src/core/fb/either.dart';
import 'package:dw_schedule/src/core/providers/application_providers.dart';
import 'package:dw_schedule/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'login_state.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandler = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);

    final result = await loginService.execute(email, password);

    switch (result) {
      case Success():
        ref.invalidate(getMeProvider);
        ref.invalidate(getMyScheduleProvider);
        final userModel = await ref.read(getMeProvider.future);
        switch (userModel) {
          case (UserModelADM()):
            state = state.copyWith(status: LoginStateStatus.admLogin);
          case (UserModelEmployee()):
            state = state.copyWith(status: LoginStateStatus.employeeLogin);
        }
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message,
        );
    }
    loaderHandler.close();
  }
}
