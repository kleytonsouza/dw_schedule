import 'package:dw_schedule/src/core/exceptions/repository_exception.dart';
import 'package:dw_schedule/src/core/fb/either.dart';
import 'package:dw_schedule/src/core/fb/nil.dart';
import 'package:dw_schedule/src/model/appointment_model.dart';


abstract interface class AppointmentRepository {
  Future<Either<RepositoryException, Nil>> appointmentClient(
      ({
        int scheduleId,
        int userId,
        String clientName,
        DateTime date,
        int time
      }) appointmentData);

  Future<Either<RepositoryException, List<AppointmentModel>>> findAppointmentByDate(({
    DateTime date,
    int userId
  }) filter);
}
