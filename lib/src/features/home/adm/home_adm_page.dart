import 'package:dw_schedule/src/features/home/widget/home_header.dart';
import 'package:flutter/material.dart';

class HomeAdmPage extends StatelessWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
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
