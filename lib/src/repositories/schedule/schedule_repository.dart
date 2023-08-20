import 'package:dw_schedule/src/core/exceptions/repository_exception.dart';
import 'package:dw_schedule/src/core/fb/either.dart';
import 'package:dw_schedule/src/core/fb/nil.dart';
import 'package:dw_schedule/src/model/schedule_model.dart';
import 'package:dw_schedule/src/model/user_model.dart';

abstract interface class ScheduleRepository {
  Future<Either<RepositoryException, Nil>> save(
      ({
        String name,
        String email,
        List<String> openingDays,
        List<int> openingHours,
      }) data);

  Future<Either<RepositoryException, ScheduleModel>> getMySchedule(
      UserModel userModel);
}
