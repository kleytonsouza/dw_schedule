import 'package:dw_schedule/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_schedule/src/core/ui/widgets/weekdays_panel.dart';
import 'package:flutter/material.dart';

class ScheduleRegisterPage extends StatelessWidget {
  const ScheduleRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Local'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              const TextField(
                  decoration: InputDecoration(
                label: Text('Nome'),
              )),
              const SizedBox(
                height: 24,
              ),
              const TextField(
                decoration: InputDecoration(
                  label: Text('E-mail'),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const WeekDaysPanel(),
              const SizedBox(
                height: 24,
              ),
              const HoursPanel(
                startTime: 6,
                endTime: 23,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromRadius(56),
                ),
                onPressed: () {},
                child: const Text('Cadastrar Local'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
