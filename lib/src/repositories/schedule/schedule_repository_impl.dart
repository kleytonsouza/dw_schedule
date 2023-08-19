import 'package:dio/dio.dart';
import 'package:dw_schedule/src/core/exceptions/repository_exception.dart';
import 'package:dw_schedule/src/core/fb/either.dart';
import 'package:dw_schedule/src/core/restClient/rest_client.dart';
import 'package:dw_schedule/src/model/schedule_model.dart';
import 'package:dw_schedule/src/model/user_model.dart';
import './schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final RestClient restClient;

  ScheduleRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryException, ScheduleModel>> getMySchedule(
      UserModel userModel) async {
    
    switch (userModel) {
      
      case UserModelADM():
        final Response(data: List(first: data)) = await restClient.auth.get(
          '/schedule',
          queryParameters: {'user_id': '#userAuthRef'},
        );
        return Success(ScheduleModel.fromMap(data));
      
      case UserModelEmployee():
        final Response(:data) = await restClient.auth.get(
          '/schedule/${userModel.localEventId}',
        );
        return Success(ScheduleModel.fromMap(data));
    }
  }
}
