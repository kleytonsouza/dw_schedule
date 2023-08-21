import 'package:dw_schedule/src/core/exceptions/auth_exception.dart';
import 'package:dw_schedule/src/core/exceptions/repository_exception.dart';
import 'package:dw_schedule/src/core/fb/either.dart';
import 'package:dw_schedule/src/core/fb/nil.dart';
import 'package:dw_schedule/src/model/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, UserModel>> me();

  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({
        String name,
        String email,
        String password,
      }) userData);

  Future<Either<RepositoryException, List<UserModel>>> getEmployees(
      int scheduleId);

  Future<Either<RepositoryException, Nil>> registerAdmAsEmployee(
      ({
        List<String> workDays,
        List<int> workHours,
      }) userModel);
  
  Future<Either<RepositoryException, Nil>> registerEmployee(
      ({
        int scheduleId,
        String name,
        String email,
        String password,
        List<String> workDays,
        List<int> workHours,
      }) userModel);
}
