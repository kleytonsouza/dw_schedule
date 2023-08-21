import 'package:dw_schedule/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class WeekDaysPanel extends StatelessWidget {
  final ValueChanged<String> onDayPressed;
  final List<String>? enabledDay;

  const WeekDaysPanel({super.key, required this.onDayPressed, this.enabledDay});

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
                ButtonDay(
                  label: "Seg",
                  onDaySelected: onDayPressed,
                  enabledDay: enabledDay,
                ),
                ButtonDay(
                  label: "Ter",
                  onDaySelected: onDayPressed,
                  enabledDay: enabledDay,
                ),
                ButtonDay(
                  label: "Qua",
                  onDaySelected: onDayPressed,
                  enabledDay: enabledDay,
                ),
                ButtonDay(
                  label: "Qui",
                  onDaySelected: onDayPressed,
                  enabledDay: enabledDay,
                ),
                ButtonDay(
                  label: "Sex",
                  onDaySelected: onDayPressed,
                  enabledDay: enabledDay,
                ),
                ButtonDay(
                  label: "Sab",
                  onDaySelected: onDayPressed,
                  enabledDay: enabledDay,
                ),
                ButtonDay(
                  label: "Dom",
                  onDaySelected: onDayPressed,
                ),
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
  final List<String>? enabledDay;

  const ButtonDay({
    required this.label,
    required this.onDaySelected,
    this.enabledDay,
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

    final ButtonDay(:enabledDay, :label) = widget;

    final disableDay = enabledDay != null && !enabledDay.contains(label);

    if (disableDay) {
      buttonColor = Colors.grey[400]!;
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: disableDay
            ? null
            : () {
                widget.onDaySelected(label);
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
            label,
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
