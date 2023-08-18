import 'package:dw_schedule/src/core/exceptions/service_exception.dart';
import 'package:dw_schedule/src/core/fb/either.dart';
import 'package:dw_schedule/src/core/fb/nil.dart';

abstract interface class UserLoginService{
  Future<Either<ServiceException, Nil>> execute(String email, String password);
}