import 'package:flutter/material.dart';

enum AppointmentStateStatus {
  initial,
  success,
  error,
}

class AppointmentState {
  final AppointmentStateStatus status;
  final int? appointmentHour;
  final DateTime? appointmentDate;

  AppointmentState.initial() : this(status: AppointmentStateStatus.initial);

  AppointmentState({
    required this.status,
    this.appointmentDate,
    this.appointmentHour,
  });

  AppointmentState copyWith({
    AppointmentStateStatus? status,
    ValueGetter<int?>? appointmentHour,
    ValueGetter<DateTime?>? appointmentDate,
  }){
    return AppointmentState(status: status ?? this.status,
     appointmentDate: appointmentDate != null ? appointmentDate() : this.appointmentDate,
     appointmentHour: appointmentHour != null ? appointmentHour() : this.appointmentHour);
  }

}
