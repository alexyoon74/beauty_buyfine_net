import 'package:beauty_buyfine_net/view/list_case.dart';
import 'package:beauty_buyfine_net/view/list_experts.dart';
import 'package:beauty_buyfine_net/view/list_hospital.dart';
import 'package:beauty_buyfine_net/view/list_info.dart';
import 'package:beauty_buyfine_net/view/my_page.dart';
import 'package:flutter/material.dart';

class ListMain extends StatefulWidget {
  final int initSelectedIndex;
  const ListMain({
    super.key,
    this.initSelectedIndex = 0,
  });

  @override
  State<ListMain> createState() => _ListMainState();
}

class _ListMainState extends State<ListMain> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initSelectedIndex;
    if (widget.initSelectedIndex == 1) {
      //debugPrint('init value = 1');
      //ApiServices.hasRequestedCase = true;
      //ListCaseController.to.setRequestedValue(boolValue: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          ListHospital(),
          ListCase(),
          ListExperts(),
          ListInfo(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        height: 80,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        animationDuration: const Duration(milliseconds: 10000),
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) {
          return setState(() {
            if (value == 1) {
              //debugPrint('value = 1');
              //ApiServices.hasRequestedCase = true;
              //ListCaseController.to.setRequestedValue(boolValue: true);
            }
            selectedIndex = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_work_outlined),
            label: '找医院',
            selectedIcon: Icon(
              Icons.home_work_outlined,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          NavigationDestination(
            icon: const Icon(Icons.cases_rounded),
            label: '整容案例',
            selectedIcon: Icon(
              Icons.cases_rounded,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_add_alt_1_rounded),
            label: '找医生',
            selectedIcon: Icon(
              Icons.person_add_alt_1_rounded,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          NavigationDestination(
            icon: const Icon(Icons.info),
            label: '整容攻略',
            selectedIcon: Icon(
              Icons.info,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person),
            label: '我',
            selectedIcon: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
