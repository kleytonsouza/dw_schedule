import 'package:dw_schedule/src/core/ui/constants.dart';
import 'package:dw_schedule/src/core/ui/schedule_icons.dart';
import 'package:dw_schedule/src/features/home/widget/home_header.dart';
import 'package:flutter/material.dart';

class HomeAdmPage extends StatelessWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsConstants.lightBlue,
        onPressed: () {},
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 12,
          child: Icon(
            ScheduleIcons.addEmployee,
            color: ColorsConstants.lightBlue,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: HomeHeader(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const Text('x'),
              childCount: 20,
            ),
          )
        ],
      ),
    );
  }
}
