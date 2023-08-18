import 'package:dw_schedule/src/core/exceptions/auth_exception.dart';
import 'package:dw_schedule/src/core/fb/either.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
}
