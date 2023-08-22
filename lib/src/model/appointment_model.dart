class AppointmentModel {
  final int id;
  final int sheduleId;
  final int userId;
  final String clientName;
  final DateTime date;
  final int hour;

  AppointmentModel({
    required this.clientName,
    required this.date,
    required this.hour,
    required this.id,
    required this.sheduleId,
    required this.userId,
  });

  factory AppointmentModel.fromMap(Map<String, dynamic> json) {
    switch (json) {
      case {
          'id': int id,
          'schedule_id': int sheduleId,
          'user_id': int userId,
          'client_name': String clientName,
          'date': String date,
          'time': int hour,
        }:
        return AppointmentModel(
          id: id,
          clientName: clientName,
          date: DateTime.parse(date),
          hour: hour,
          sheduleId: sheduleId,
          userId: userId,
        );
      case _:
        throw ArgumentError('Invalid json');
    }
  }
}
