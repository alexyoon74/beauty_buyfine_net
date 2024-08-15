import 'package:beauty_buyfine_net/controller/bottom_navigation_controller.dart';
import 'package:beauty_buyfine_net/view/list_case.dart';
import 'package:beauty_buyfine_net/view/list_experts.dart';
import 'package:beauty_buyfine_net/view/list_hospital.dart';
import 'package:beauty_buyfine_net/view/list_info.dart';
import 'package:beauty_buyfine_net/view/my_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListMain extends GetView<BottomNavigationController> {
  ListMain({super.key});
  //BottomNavigationController는 InitBindings에 이미 permanent: true로 이미 인스턴스화해서 Get.find 사용하였음
  final BottomNavigationController bottomNavigationController =
      Get.find<BottomNavigationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: bottomNavigationController.selectedIndex.value,
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
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          indicatorColor: Theme.of(context).colorScheme.onSecondaryContainer,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          animationDuration: const Duration(milliseconds: 1000),
          selectedIndex: bottomNavigationController.selectedIndex.value,
          onDestinationSelected: (value) {
            bottomNavigationController.changeBottomNavigation(pageIndex: value);
          },
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.domain_add),
              label: '找医院',
              selectedIcon: Icon(
                Icons.domain_add,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            NavigationDestination(
              icon: const Icon(Icons.format_list_numbered),
              label: '整容案例',
              selectedIcon: Icon(
                Icons.format_list_numbered,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_add_alt_1_rounded),
              label: '找医生',
              selectedIcon: Icon(
                Icons.person_add_alt_1_rounded,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            NavigationDestination(
              icon: const Icon(Icons.inventory_outlined),
              label: '整容攻略',
              selectedIcon: Icon(
                Icons.inventory_outlined,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            NavigationDestination(
              icon: const Icon(Icons.person),
              label: '我',
              selectedIcon: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
