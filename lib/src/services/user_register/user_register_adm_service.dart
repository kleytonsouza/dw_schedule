import 'package:dw_schedule/src/core/exceptions/service_exception.dart';
import 'package:dw_schedule/src/core/fb/either.dart';
import 'package:dw_schedule/src/core/fb/nil.dart';

abstract interface class UserRegisterAdmService {
  Future<Either<ServiceException, Nil>> execute(
      ({
        String name,
        String email,
        String password,
      }) userdata);
}
