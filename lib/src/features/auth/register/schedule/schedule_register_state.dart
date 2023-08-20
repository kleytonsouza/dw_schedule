enum ScheduleRegisterStateStatus {
  initial,
  success,
  error,
}

class ScheduleRegisterState {
  final ScheduleRegisterStateStatus status;
  final List<String> openingDays;
  final List<int> openingHours;

  ScheduleRegisterState.initial()
      : this(
            status: ScheduleRegisterStateStatus.initial,
            openingHours: <int>[],
            openingDays: <String>[]);

  ScheduleRegisterState({
    required this.openingDays,
    required this.openingHours,
    required this.status,
  });

  ScheduleRegisterState copyWith({
    ScheduleRegisterStateStatus? status,
    List<String>? openingDays,
    List<int>? openingHours,
  }) {
    return ScheduleRegisterState(
      openingDays: openingDays ?? this.openingDays,
      openingHours: openingHours ?? this.openingHours,
      status: status ?? this.status,
    );
  }
}
