import 'dart:io';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw_schedule/src/core/exceptions/auth_exception.dart';
import 'package:dw_schedule/src/core/exceptions/repository_exception.dart';
import 'package:dw_schedule/src/core/fb/either.dart';
import 'package:dw_schedule/src/core/fb/nil.dart';
import 'package:dw_schedule/src/core/restClient/rest_client.dart';
import 'package:dw_schedule/src/model/user_model.dart';
import 'package:dw_schedule/src/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await restClient.unAuth.post('/auth', data: {
        'email': email,
        'password': password,
      });
      return Success(data['access_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log('Login ou senha inválidos', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao realizar login 2'));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final data = await restClient.auth.get('/me');
      return Success(UserModel.fromMap(data.data));
    } on DioException catch (e, s) {
      log("Erro ao buscar usuário 1", error: e, stackTrace: s);
      return Failure(RepositoryException(message: "Erro ao buscar usuário"));
    } on ArgumentError catch (e, s) {
      log("Invalid Json", error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String email, String name, String password}) userData) async {
    try {
      await restClient.unAuth.post('/users', data: {
        'name': userData.name,
        'email': userData.email,
        'password': userData.password,
        'profile': 'ADM'
      });
      return Success(nil);
    } on Exception catch (e, s) {
      log('Erro ao registrar usuário admin', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao registrar usuário admin'));
    }
  }
}
