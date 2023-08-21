import 'package:dw_schedule/src/core/exceptions/repository_exception.dart';
import 'package:dw_schedule/src/core/fb/either.dart';
import 'package:dw_schedule/src/core/fb/nil.dart';


abstract interface class AppointmentRepository {
  Future<Either<RepositoryException, Nil>> appointmentClient(
      ({
        int scheduleId,
        int userId,
        String clientName,
        DateTime date,
        int time
      }) appointmentData);
}
