import 'package:dw_schedule/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class WeekDaysPanel extends StatelessWidget {
  const WeekDaysPanel({super.key, required this.onDayPressed});
  final ValueChanged<String> onDayPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecione os dias da semana',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonDay(label: "Seg", onDaySelected: onDayPressed,),
                ButtonDay(label: "Ter", onDaySelected: onDayPressed,),
                ButtonDay(label: "Qua", onDaySelected: onDayPressed,),
                ButtonDay(label: "Qui", onDaySelected: onDayPressed,),
                ButtonDay(label: "Sex", onDaySelected: onDayPressed,),
                ButtonDay(label: "Sab", onDaySelected: onDayPressed,),
                ButtonDay(label: "Dom", onDaySelected: onDayPressed,),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ButtonDay extends StatefulWidget {
  final String label;
  final ValueChanged<String> onDaySelected;

  const ButtonDay({
    required this.label,
    required this.onDaySelected,
    super.key,
  });

  @override
  State<ButtonDay> createState() => _ButtonDayState();
}

class _ButtonDayState extends State<ButtonDay> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : ColorsConstants.grey;
    var buttonColor = selected ? ColorsConstants.lightBlue : Colors.white;
    final buttonBorderColor =
        selected ? ColorsConstants.lightBlue : ColorsConstants.grey;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          widget.onDaySelected(widget.label);
          setState(() {
            selected = !selected;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: buttonColor,
            border: Border.all(
              color: buttonBorderColor,
            ),
          ),
          child: Center(
              child: Text(
            'Seg',
            style: TextStyle(
              fontSize: 12,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          )),
        ),
      ),
    );
  }
}
