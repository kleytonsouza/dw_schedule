import 'package:dw_schedule/src/core/ui/constants.dart';
import 'package:dw_schedule/src/model/appointment_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDs extends CalendarDataSource {
  final List<AppointmentModel> aappointments;

  AppointmentDs({required this.aappointments});

  @override
  List<dynamic>? get appointments => aappointments
      .map((e) => Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(
            const Duration(hours: 1),
          ),
          subject: 'ton souza'))
      .toList();
}



  //       [Appointment(
  //           startTime: DateTime.now(),
  //           endTime: DateTime.now().add(
  //             const Duration(hours: 1),
  //           ),
  //           subject: 'kleyton souza'),
  //       Appointment(
  //           color: ColorsConstants.lightBlue,
  //           startTime: DateTime.now().add(
  //             const Duration(hours: 2),
  //           ),
  //           endTime: DateTime.now().add(
  //             const Duration(hours: 3),
  //           ),
  //           subject: 'ton souza'),
  //     ];