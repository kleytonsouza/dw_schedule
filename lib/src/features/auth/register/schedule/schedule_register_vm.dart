import 'package:dw_schedule/src/core/fb/either.dart';
import 'package:dw_schedule/src/core/providers/application_providers.dart';
import 'package:dw_schedule/src/features/auth/register/schedule/schedule_register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_register_vm.g.dart';

@riverpod
class ScheduleRegisterVm extends _$ScheduleRegisterVm {
  @override
  ScheduleRegisterState build() => ScheduleRegisterState.initial();

  void addOrRemoveOpenDay(String weekDay) {
    final openingDays = state.openingDays;
    if (openingDays.contains(weekDay)) {
      openingDays.remove(weekDay);
    } else {
      openingDays.add(weekDay);
    }

    state = state.copyWith(openingDays: openingDays);
  }

  void addOrRemoveOpenHour(int hour) {
    final openingHours = state.openingHours;
    if (openingHours.contains(hour)) {
      openingHours.remove(hour);
    } else {
      openingHours.add(hour);
    }

    state = state.copyWith(openingHours: openingHours);
  }

  Future<void> register(String name, String email) async {
    final repository = ref.watch(scheduleRepositoryProvider);
    final ScheduleRegisterState(:openingDays, :openingHours) = state;

    final dto = (
      name: name,
      email: email,
      openingDays: openingDays,
      openingHours: openingHours,
    );

    final registerResult = await repository.save(dto);

    switch (registerResult) {
      case Success():
        ref.invalidate(getMyScheduleProvider);
        state = state.copyWith(status: ScheduleRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: ScheduleRegisterStateStatus.error);
    }
  }
}
