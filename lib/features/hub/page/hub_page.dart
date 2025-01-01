import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_slot/features/hub/cubit/hub_cubit.dart';
import 'package:medi_slot/features/hub/page/favorites.dart';
import 'package:medi_slot/features/hub/page/home.dart';
import 'package:medi_slot/features/hub/page/notifications.dart';
import 'package:medi_slot/features/hub/page/schedule.dart';
import 'package:medi_slot/features/hub/widgets/hub_bottom_nav_bar.dart';

import '../widgets/app_drawer.dart';

class HubPage extends StatelessWidget {
  HubPage({super.key});

  final List<Widget> _pages = [
    Home(),
    Schedule(),
    Favorites(),
    Notifications(),
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HubCubit>(context);
    return Scaffold(
      endDrawer: AppDrawer(),
      bottomNavigationBar: HubBottomNavBar(),
      body: SafeArea(
        child: BlocBuilder<HubCubit, HubState>(
          buildWhen: (_, currentState) => currentState is NavBarChange,
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _pages[cubit.pageIndex],
            );
          },
        ),
      ),
    );
  }
}
