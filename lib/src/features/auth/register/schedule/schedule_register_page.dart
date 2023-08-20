import 'package:dw_schedule/src/core/ui/helpers/form_helper.dart';
import 'package:dw_schedule/src/core/ui/helpers/messages.dart';
import 'package:dw_schedule/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_schedule/src/core/ui/widgets/weekdays_panel.dart';
import 'package:dw_schedule/src/features/auth/register/schedule/schedule_register_state.dart';
import 'package:dw_schedule/src/features/auth/register/schedule/schedule_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class ScheduleRegisterPage extends ConsumerStatefulWidget {
  const ScheduleRegisterPage({super.key});

  @override
  ConsumerState<ScheduleRegisterPage> createState() =>
      _ScheduleRegisterPageState();
}

class _ScheduleRegisterPageState extends ConsumerState<ScheduleRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleRegisterVm = ref.watch(scheduleRegisterVmProvider.notifier);

    ref.listen(scheduleRegisterVmProvider, (_, state) {
      switch (state.status) {
        case ScheduleRegisterStateStatus.initial:
          break;
        case ScheduleRegisterStateStatus.error:
          Messages.showError("Erro ao registrar o Local", context);
        case ScheduleRegisterStateStatus.success:
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/adm', (route) => false);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Local'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: nameEC,
                  validator: Validatorless.required("nome obrigatório"),
                  onTapOutside: (_) => context.unfocus(),
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail obrigatório'),
                    Validatorless.email('E-mail inválido')
                  ]),
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                WeekDaysPanel(onDayPressed: (value) {
                  scheduleRegisterVm.addOrRemoveOpenDay(value);
                }),
                const SizedBox(
                  height: 24,
                ),
                HoursPanel(
                  startTime: 6,
                  endTime: 23,
                  onHourPressed: (int value) {
                    scheduleRegisterVm.addOrRemoveOpenHour(value);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromRadius(56),
                  ),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case false || null:
                        Messages.showError('Formulário inválido', context);
                      case true:
                        scheduleRegisterVm.register(nameEC.text, emailEC.text);
                    }
                  },
                  child: const Text('Cadastrar Local'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
