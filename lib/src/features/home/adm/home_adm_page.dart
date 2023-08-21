import 'dart:developer';

import 'package:dw_schedule/src/core/ui/constants.dart';
import 'package:dw_schedule/src/core/ui/schedule_icons.dart';
import 'package:dw_schedule/src/core/ui/widgets/schedule_loader.dart';
import 'package:dw_schedule/src/features/home/adm/home_employee_tile.dart';
import 'package:dw_schedule/src/features/home/widget/home_adm_state.dart';
import 'package:dw_schedule/src/features/home/widget/home_adm_vm.dart';
import 'package:dw_schedule/src/features/home/widget/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAdmPage extends ConsumerWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeAdmVmProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsConstants.lightBlue,
        onPressed: () {
          Navigator.of(context).pushNamed('/employee/register');
        },
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 12,
          child: Icon(
            ScheduleIcons.addEmployee,
            color: ColorsConstants.lightBlue,
          ),
        ),
      ),
      body: homeState.when(
        data: (HomeAdmState data) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      HomeEmployeeTile(employee: data.employees[index]),
                  childCount: data.employees.length,
                ),
              )
            ],
          );
        },
        error: (error, stackTrace) {
          log('Erro ao carregar colaboradores',
              error: error, stackTrace: stackTrace);
          return const Center(
            child: Text('Errro ao carregar página'),
          );
        },
        loading: () {
          return const ScheduleLoader();
        },
      ),
    );
  }
}
