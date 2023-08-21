import 'package:asyncstate/asyncstate.dart';
import 'package:dw_schedule/src/core/fb/either.dart';
import 'package:dw_schedule/src/core/providers/application_providers.dart';
import 'package:dw_schedule/src/features/appointment/appointment_state.dart';
import 'package:dw_schedule/src/model/schedule_model.dart';
import 'package:dw_schedule/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_vm.g.dart';

@riverpod
class AppointmentVm extends _$AppointmentVm {
  @override
  AppointmentState build() => AppointmentState.initial();

  void hourSelect(int hour) {
    if (hour == state.appointmentHour) {
      state = state.copyWith(
        appointmentHour: () => null,
      );
    } else {
      state = state.copyWith(
        appointmentHour: () => hour,
      );
    }
  }

  void dateSelect(DateTime date) {
    state = state.copyWith(appointmentDate: () => date);
  }

  Future<void> register({
    required UserModel userModel,
    required String clientName,
  }) async {
    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final AppointmentState(:appointmentDate, :appointmentHour) = state;
    final appointmentRepository = ref.read(appointmentRepositoryProvider);
    final ScheduleModel(id: scheduleId) =
        await ref.watch(getMyScheduleProvider.future);
    final dto = (
      scheduleId: scheduleId,
      userId: userModel.id,
      clientName: clientName,
      date: appointmentDate!,
      time: appointmentHour!,
    );

    final appointmentResult =
        await appointmentRepository.appointmentClient(dto);

    switch (appointmentResult) {
      case Success():
        state = state.copyWith(status: AppointmentStateStatus.success);
      case Failure():
        state = state.copyWith(status: AppointmentStateStatus.error);

    }

    asyncLoaderHandler.close();
  }
}
