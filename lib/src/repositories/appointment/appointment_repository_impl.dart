import 'package:dio/dio.dart';
import 'package:dw_schedule/src/core/exceptions/repository_exception.dart';

import 'package:dw_schedule/src/core/fb/either.dart';
import 'dart:developer';
import 'package:dw_schedule/src/core/fb/nil.dart';
import 'package:dw_schedule/src/core/restClient/rest_client.dart';
import 'package:dw_schedule/src/model/appointment_model.dart';

import './appointment_repository.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final RestClient restClient;

  AppointmentRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryException, Nil>> appointmentClient(
      ({
        String clientName,
        DateTime date,
        int scheduleId,
        int time,
        int userId
      }) appointmentData) async {
    try {
      await restClient.auth.post('/appointments', data: {
        'schedule_id': appointmentData.scheduleId,
        'user_id': appointmentData.userId,
        'client_name': appointmentData.clientName,
        'date': appointmentData.date.toIso8601String(),
        'time': appointmentData.time,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar agendamento', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao agendar horário'));
    }
  }

  @override
  Future<Either<RepositoryException, List<AppointmentModel>>>
      findAppointmentByDate(({DateTime date, int userId}) filter) async {
    try {
      final Response(:data) =
          await restClient.auth.get('/appointment', queryParameters: {
        'user_id': filter.userId,
        'date': filter.date.toIso8601String(),
      });
      final appointments =
          data.map((e) => AppointmentModel.fromMap(e)).toList();
      return Success(appointments);
    } on DioException catch (e, s) {
      log('Erro ao buscar agendamentos de uma data', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: 'Erro ao buscar agendamentos de uma data'));
    } on ArgumentError catch (e, s) {
      log('invalid Json', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'invalid json'));
    }
  }
}
