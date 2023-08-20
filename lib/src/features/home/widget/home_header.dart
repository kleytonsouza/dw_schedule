import 'package:dw_schedule/src/core/ui/constants.dart';
import 'package:dw_schedule/src/core/ui/schedule_icons.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final bool hideFilter;

  const HomeHeader({super.key, this.hideFilter = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      margin: const EdgeInsets.only(bottom: 16),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
        color: Colors.blue[100],
        image: const DecorationImage(
            image: AssetImage(ImageConstants.backgroundImage),
            fit: BoxFit.cover,
            opacity: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xffbdbdbd),
                child: SizedBox.shrink(),
              ),
              const SizedBox(
                width: 16,
              ),
              const Flexible(
                child: Text(
                  'Kleyton',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Expanded(
                child: Text(
                  'Editar',
                  style: TextStyle(
                      color: ColorsConstants.lightBlue,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    ScheduleIcons.exit,
                    color: ColorsConstants.lightBlue,
                    size: 32,
                  ))
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            "Bem Vindo",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Agende um evento',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 40,
            ),
          ),
          Offstage(
            offstage: !hideFilter,
            child: const SizedBox(
              height: 24,
            ),
          ),
          Offstage(
            offstage: !hideFilter,
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text('Buscar Colaborador'),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Icon(
                    ScheduleIcons.search,
                    color: ColorsConstants.lightBlue,
                    size: 26,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
