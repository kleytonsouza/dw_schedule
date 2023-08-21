import 'package:dw_schedule/src/core/ui/constants.dart';
import 'package:dw_schedule/src/core/ui/helpers/form_helper.dart';
import 'package:dw_schedule/src/core/ui/schedule_icons.dart';
import 'package:dw_schedule/src/core/ui/widgets/avatar_widget.dart';
import 'package:dw_schedule/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_schedule/src/features/appointment/appointment_state.dart';
import 'package:dw_schedule/src/features/appointment/appointment_vm.dart';
import 'package:dw_schedule/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';
import 'package:dw_schedule/src/core/ui/helpers/messages.dart';

import 'widgets/appointment_calendar.dart';

class AppointmentPage extends ConsumerStatefulWidget {
  const AppointmentPage({super.key});

  @override
  ConsumerState<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends ConsumerState<AppointmentPage> {
  var dateFormat = DateFormat('dd/MM/yyyy');
  var showCalendar = false;
  final formKey = GlobalKey<FormState>();
  final clientEC = TextEditingController();
  final dateEC = TextEditingController();

  @override
  void dispose() {
    clientEC.dispose();
    dateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appointmentVM = ref.watch(appointmentVmProvider.notifier);
    final userModel = ModalRoute.of(context)!.settings.arguments as UserModel;

    final employeeData = switch (userModel) {
      UserModelADM(:final workDays, :final workHours) => (
          workDays: workDays!,
          workHours: workHours!,
        ),
      UserModelEmployee(:final workDays, :final workHours) => (
          workDays: workDays,
          workHours: workHours,
        )
    };

    ref.listen(appointmentVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case AppointmentStateStatus.initial:
          break;
        case AppointmentStateStatus.success:
          Messages.showSuccess('Cliente agendado com sucesso', context);
        case AppointmentStateStatus.error:
          Messages.showError('Erro ao agendar cliente', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar cliente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  const AvatarWidget(hideUploadButton: true),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    userModel.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 37,
                  ),
                  TextFormField(
                    controller: clientEC,
                    validator: Validatorless.required('Cliente obrigatório'),
                    decoration: const InputDecoration(
                      label: Text('Nome'),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextFormField(
                    controller: dateEC,
                    validator: Validatorless.required('Selecione uma data'),
                    readOnly: true,
                    onTap: () {
                      setState(() {
                        showCalendar = true;
                      });
                      context.unfocus();
                    },
                    decoration: const InputDecoration(
                      label: Text('Selecione um data'),
                      hintText: 'Selecione uma data',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: Icon(
                        ScheduleIcons.calendar,
                        color: ColorsConstants.lightBlue,
                        size: 18,
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: !showCalendar,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        AppointmentCalendar(
                          cancelPressed: () {
                            setState(() {
                              showCalendar = false;
                            });
                          },
                          okPressed: (DateTime value) {
                            setState(() {
                              dateEC.text = dateFormat.format(value);
                              appointmentVM.dateSelect(value);
                              showCalendar = false;
                            });
                          },
                          workDays: employeeData.workDays,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  HoursPanel.singleSelection(
                    startTime: 6,
                    endTime: 23,
                    onHourPressed: appointmentVM.hourSelect,
                    enabledTimes: employeeData.workHours,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case null || false:
                          Messages.showError('Dados incompletos', context);
                        case true:
                          final hourSelected = ref.watch(
                              appointmentVmProvider.select(
                                  (state) => state.appointmentHour != null));
                          if (hourSelected) {
                            appointmentVM.register(
                                userModel: userModel,
                                clientName: clientEC.text);
                          } else {
                            Messages.showError(
                                'Por favor, selecione um horário', context);
                          }
                      }
                    },
                    child: const Text('Agendar'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
