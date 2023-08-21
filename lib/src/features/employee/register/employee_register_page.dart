import 'dart:developer';

import 'package:dw_schedule/src/core/providers/application_providers.dart';
import 'package:dw_schedule/src/core/ui/helpers/messages.dart';
import 'package:dw_schedule/src/core/ui/widgets/avatar_widget.dart';
import 'package:dw_schedule/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_schedule/src/core/ui/widgets/schedule_loader.dart';
import 'package:dw_schedule/src/core/ui/widgets/weekdays_panel.dart';
import 'package:dw_schedule/src/features/employee/register/employee_register_state.dart';
import 'package:dw_schedule/src/features/employee/register/employee_register_vm.dart';
import 'package:dw_schedule/src/model/schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() =>
      _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  var registerADM = false;
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeRegisterVm = ref.watch(employeeRegisterVmProvider.notifier);
    final scheduleAsyncValue = ref.watch(getMyScheduleProvider);

    ref.listen(employeeRegisterVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case EmployeeRegisterStateStatus.initial:
          break;
        case EmployeeRegisterStateStatus.success:
          Messages.showSuccess('Colaborador cadastrado com sucesso', context);
          Navigator.of(context).pop();
        case EmployeeRegisterStateStatus.error:
          Messages.showError('Erro ao cadastrar o colaborado', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar colaborador'),
      ),
      body: scheduleAsyncValue.when(
          error: (error, stackTrack) {
            log('Erro ao carregar a página',
                error: error, stackTrace: stackTrack);
            return const Center(
              child: Text('Erro ao carregar a página'),
            );
          },
          loading: () => const ScheduleLoader(),
          data: (scheduleModel) {
            final ScheduleModel(:openingDays, :openingHours) = scheduleModel;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      children: [
                        const AvatarWidget(),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          children: [
                            Checkbox.adaptive(
                                value: registerADM,
                                onChanged: (value) {
                                  setState(() {
                                    registerADM = !registerADM;
                                    employeeRegisterVm
                                        .setRegisterADM(registerADM);
                                  });
                                }),
                            const Expanded(
                              child: Text(
                                'Sou adminstrador e quero me cadastrar como colaborador',
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          ],
                        ),
                        Offstage(
                          offstage: registerADM,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                controller: nameEC,
                                validator: registerADM
                                    ? null
                                    : Validatorless.required(
                                        'Nome Obrigatório'),
                                decoration:
                                    const InputDecoration(label: Text('Nome')),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                controller: emailEC,
                                validator: registerADM
                                    ? null
                                    : Validatorless.multiple([
                                        Validatorless.email('E-mail inválido'),
                                        Validatorless.required(
                                            'E-mail obrigatório'),
                                      ]),
                                decoration: const InputDecoration(
                                    label: Text('E-mail')),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                controller: passwordEC,
                                obscureText: true,
                                validator: registerADM ? null : Validatorless.multiple([
                                  Validatorless.required('Senha obrigatória'),
                                  Validatorless.min(6,
                                      'Senha deve conter ao menos 6 caracteres'),
                                ]),
                                decoration:
                                    const InputDecoration(label: Text('Senha')),
                              ),
                            ],
                          ),
                        ),
                        WeekDaysPanel(
                          enabledDay: openingDays,
                          onDayPressed: employeeRegisterVm.addOrRemoveWorkDays,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        HoursPanel(
                          enabledTimes: openingHours,
                          startTime: 6,
                          endTime: 23,
                          onHourPressed:
                              employeeRegisterVm.addOrRemoveWorkHours,
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
                              case false || null:
                                Messages.showError(
                                    'Existem campos inválidos', context);
                              case true:
                                final EmployeeRegisterState(
                                  workDays: List(isNotEmpty: hasWorkDays),
                                  workHours: List(isNotEmpty: hasWorkHours)
                                ) = ref.watch(employeeRegisterVmProvider);

                                if (!hasWorkDays || !hasWorkHours) {
                                  Messages.showError(
                                      'Por favor, selecione os dias e horários de atendimento',
                                      context);
                                  return;
                                }
                                final name = nameEC.text;
                                final email = emailEC.text;
                                final password = passwordEC.text;
                                employeeRegisterVm.register(
                                    email: email,
                                    name: name,
                                    password: password);
                            }
                          },
                          child: const Text('Cadastrar Colaborador'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
