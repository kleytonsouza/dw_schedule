enum EmployeeRegisterStateStatus { initial, success, error }

class EmployeeRegisterState {
  final EmployeeRegisterStateStatus status;
  final bool registerADM;
  final List<String> workDays;
  final List<int> workHours;

  EmployeeRegisterState.initial()
      : this(
          status: EmployeeRegisterStateStatus.initial,
          registerADM: false,
          workDays: <String>[],
          workHours: <int>[],
        );

  EmployeeRegisterState({
    required this.registerADM,
    required this.status,
    required this.workDays,
    required this.workHours,
  });

  EmployeeRegisterState copyWith({
    EmployeeRegisterStateStatus? status,
    bool? registerADM,
    List<String>? workDays,
    List<int>? workHours,
  }) {
    return EmployeeRegisterState(
      registerADM: registerADM ?? this.registerADM,
      status: status ?? this.status,
      workDays: workDays ?? this.workDays,
      workHours: workHours ?? this.workHours,
    );
  }
}
