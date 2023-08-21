import 'package:dw_schedule/src/model/user_model.dart';

enum HomeAdmStateStatus { loaded, error }

class HomeAdmState {
  final List<UserModel> employees;
  final HomeAdmStateStatus status;

  HomeAdmState({required this.status, required this.employees});

  HomeAdmState copyWith(
      {HomeAdmStateStatus? status, List<UserModel>? employees}) {
    return HomeAdmState(
      status: status ?? this.status,
      employees: employees ?? this.employees,
    );
  }
}
