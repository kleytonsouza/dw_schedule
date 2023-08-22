import 'package:dw_schedule/src/core/providers/application_providers.dart';
import 'package:dw_schedule/src/model/appointment_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/fb/either.dart';

part 'employee_appointment_vm.g.dart';

@riverpod
class EmployeeAppointmentVm extends _$EmployeeAppointmentVm {
  @override
  Future<List<AppointmentModel>> build(int userId, DateTime date) async {
    final repository = ref.read(appointmentRepositoryProvider);
    final appointmentListResult = await repository.findAppointmentByDate((userId: userId, date: date));

    return switch(appointmentListResult){
      Success(value: final appointments) => appointments,
      Failure(: final exception) =>  throw Exception(exception)
    };

  }
}
