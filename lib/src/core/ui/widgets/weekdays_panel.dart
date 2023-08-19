import 'package:dw_schedule/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class WeekDaysPanel extends StatelessWidget {
  const WeekDaysPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selecione os dias da semana',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonDay(label: "Seg"),
                ButtonDay(label: "Ter"),
                ButtonDay(label: "Qua"),
                ButtonDay(label: "Qui"),
                ButtonDay(label: "Sex"),
                ButtonDay(label: "Sab"),
                ButtonDay(label: "Dom"),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ButtonDay extends StatelessWidget {
  final String label;

  const ButtonDay({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(color: ColorsConstants.greyLight)),
          child: const Center(
              child: Text(
            'Seg',
            style: TextStyle(
              fontSize: 12,
              color: ColorsConstants.grey,
              fontWeight: FontWeight.w500,
            ),
          )),
        ),
      ),
    );
  }
}
