import 'package:asyncstate/asyncstate.dart';
import 'package:dw_schedule/src/core/fb/either.dart';
import 'package:dw_schedule/src/core/providers/application_providers.dart';
import 'package:dw_schedule/src/features/home/widget/home_adm_state.dart';
import 'package:dw_schedule/src/model/schedule_model.dart';
import 'package:dw_schedule/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_adm_vm.g.dart';

@riverpod
class HomeAdmVm extends _$HomeAdmVm {
  @override
  Future<HomeAdmState> build() async {
    final repository = ref.read(userRepositoryProvider);
    final ScheduleModel(id: scheduleId) =
        await ref.read(getMyScheduleProvider.future);

    final me = await ref.watch(getMeProvider.future);

    final employeesResult = await repository.getEmployees(scheduleId);

    switch (employeesResult) {
      case Success(value: final employeesData):

        final employees = <UserModel>[];

        if (me case UserModelADM(workDays: _?, workHours: _?)) {
          employees.add(me);
        }
        employees.addAll(employeesData);

        return HomeAdmState(
            status: HomeAdmStateStatus.loaded, employees: employees);
      case Failure():
        return HomeAdmState(status: HomeAdmStateStatus.error, employees: []);
    }
  }

  Future<void> logout() => ref.read(logoutProvider.future).asyncLoader();
}
