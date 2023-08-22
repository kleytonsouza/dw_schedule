import 'dart:developer';

import 'package:dw_schedule/src/core/ui/constants.dart';
import 'package:dw_schedule/src/core/ui/widgets/schedule_loader.dart';
import 'package:dw_schedule/src/features/employee/appointment/employee_appointment_vm.dart';
import 'package:dw_schedule/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'appointment_ds.dart';

class EmployeeAppointmentPage extends ConsumerStatefulWidget {
  const EmployeeAppointmentPage({super.key});

  @override
  ConsumerState<EmployeeAppointmentPage> createState() =>
      _EmployeeAppointmentPageState();
}

class _EmployeeAppointmentPageState
    extends ConsumerState<EmployeeAppointmentPage> {
  late DateTime dateSelected;

  @override
  void initState() {
    final DateTime(:year, :month, :day) = DateTime.now();
    dateSelected = DateTime(year, month, day, 0, 0, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel(id: userId, :name) =
        ModalRoute.of(context)!.settings.arguments as UserModel;

    final appointmentAsync =
        ref.watch(employeeAppointmentVmProvider(userId, dateSelected));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: Column(
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 44,
          ),
          appointmentAsync.when(
            loading: () => ScheduleLoader(),
            error: (error, stackTrace) {
              log('Erro ao carregar agendamento',
                  error: error, stackTrace: stackTrace);
              return const Center(
                child: Text('Erro ao carregar página'),
              );
            },
            data: (appointments) {
              return Expanded(
                child: SfCalendar(
                  allowViewNavigation: true,
                  view: CalendarView.day,
                  showNavigationArrow: true,
                  todayHighlightColor: ColorsConstants.lightBlue,
                  showDatePickerButton: true,
                  showTodayButton: true,
                  dataSource: AppointmentDs(),
                  onTap: (calendarTapDetails) {
                    if (calendarTapDetails.appointments != null &&
                        calendarTapDetails.appointments!.isNotEmpty) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          final dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Cliente: ${calendarTapDetails.appointments?.first.subject}'),
                                  Text(
                                      'Horário: ${dateFormat.format(calendarTapDetails.date ?? DateTime.now())}'),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
