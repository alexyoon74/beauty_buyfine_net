import 'package:beauty_buyfine_net/controller/bottom_navigation_controller.dart';
import 'package:beauty_buyfine_net/controller/list_controller.dart';
import 'package:beauty_buyfine_net/view/list_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SliverAppbarFunc {
  Drawer topMenu({
    required BuildContext context,
    ListController? controller,
  }) {
    return Drawer(
      width: 200,
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      child: ListView(
        children: [
          // const UserAccountsDrawerHeader(
          //   accountName: Text("Your Name"),
          //   accountEmail: Text("your.email@example.com"),
          //   currentAccountPicture: CircleAvatar(
          //     backgroundColor: Colors.white,
          //     child: FlutterLogo(),
          //   ),
          // ),
          ListTile(
            leading: const Icon(Icons.domain_add),
            title: Text(
              '找医院',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            onTap: () {
              // Get.off(
              //   preventDuplicates: false,
              //   () => ListMain(),
              // );
              // BottomNavigationController.to
              //     .changeBottomNavigation(pageIndex: 0);
              // Get.back();
              if (controller != null) {
                controller.pageType.value = 'h';
                controller.reloadPage(pageIndex: 0);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.format_list_numbered),
            title: Text(
              '整容案例',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            onTap: () {
              // Get.off(
              //   preventDuplicates: false,
              //   () => ListMain(),
              // );

              //BottomNavigationController.to.changeBottomNavigation(pageIndex: 1);
              //Get.back();
              if (controller != null) {
                controller.pageType.value = 'c';
                controller.reloadPage(pageIndex: 1);
              }

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const ListMain(
              //       initSelectedIndex: 1,
              //     ),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_add_alt_1_rounded),
            title: Text(
              '找医生',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            onTap: () {
              // Get.off(
              //   preventDuplicates: false,
              //   () => ListMain(),
              // );
              // BottomNavigationController.to
              //     .changeBottomNavigation(pageIndex: 2);
              // Get.back();
              if (controller != null) {
                controller.pageType.value = 'e';
                controller.reloadPage(pageIndex: 2);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory_outlined),
            title: Text(
              '整容攻略',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            onTap: () {
              // Get.off(
              //   preventDuplicates: false,
              //   () => ListMain(),
              // );
              // BottomNavigationController.to
              //     .changeBottomNavigation(pageIndex: 3);
              // Get.back();
              if (controller != null) {
                controller.pageType.value = 'i';
                controller.reloadPage(pageIndex: 3);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              '找',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            onTap: () {
              // Get.off(
              //   preventDuplicates: false,
              //   () => ListMain(),
              // );
              BottomNavigationController.to
                  .changeBottomNavigation(pageIndex: 4);
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  SliverAppBar listSliverAppbar({
    required BuildContext context,
    ListController? controller,
    required String pageType,
    required String title,
    String? lottieFileName,
    bool isNeedBottomAppbar = true,
  }) {
    lottieFileName ??= '';
    int selectedCategoryNum = 0;
    if (controller != null) {
      selectedCategoryNum = controller.selectedCategoryNum.value;
    }

    return SliverAppBar(
      floating: true,
      pinned: true,
      centerTitle: true,
      expandedHeight: lottieFileName.isNotEmpty ? 120 : 0,
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
      title: Text(title),
      flexibleSpace: lottieFileName.isNotEmpty
          ? FlexibleSpaceBar(
              background: Lottie.asset(
                'lottie/$lottieFileName',
                fit: BoxFit.cover,
              ),
            )
          : null,
      // leading: IconButton(// SliverAppBar에서 leading추가하면 drawer 설정해도 leading이 우선한다
      //   onPressed: () {},
      //   icon: const Icon(
      //     Icons.menu,
      //   ),
      // ),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(() => const ListSearch());
          },
          icon: const Icon(Icons.search),
        ),
        // const SizedBox(
        //   width: 12,
        // ),
      ],

      bottom: !isNeedBottomAppbar
          ? null
          : PreferredSize(
              preferredSize: const Size.fromHeight(58),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      const SizedBox(width: 10.0),
                      TextButtonTheme(
                        data: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            foregroundColor: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            side: const BorderSide(
                              width: 1,
                              color: Colors.white,
                            ),
                            minimumSize: const Size(10, 30),
                          ),
                        ),
                        child: sliverAppbarBottom(
                          context: context,
                          controller: controller,
                          pageType: pageType,
                          selectedCategoryNum: selectedCategoryNum,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget sliverAppbarBottom({
    required BuildContext context,
    ListController? controller,
    required String pageType,
    int selectedCategoryNum = 0,
  }) {
    //double height = 20;
    Map<int, Map<String, dynamic>> category = {
      0: {
        'title': '全部',
        'icon': const Icon(Icons.accessibility_new_outlined),
      },
      1: {
        'title': '胸部',
        'icon': const Icon(Icons.favorite),
        // 'icon': SvgPicture.asset(
        //   'svg/chest.svg',
        //   height: height,
        //   fit: BoxFit.contain,
        // ),
      },
      2: {
        'title': '皮肤',
        'icon': const Icon(Icons.wb_twilight_sharp),
        // 'icon': SvgPicture.asset(
        //   'svg/dermatology.svg',
        //   height: height,
        //   fit: BoxFit.contain,
        // ),
      },
      3: {
        'title': '眼眉',
        'icon': const Icon(Icons.visibility),
      },
      4: {
        'title': '身体塑形',
        'icon': const Icon(Icons.settings_accessibility),
        // 'icon': SvgPicture.asset(
        //   'svg/metabolism.svg',
        //   height: height,
        //   fit: BoxFit.contain,
        // ),
      },
      5: {
        'title': '鼻部',
        'icon': const Icon(Icons.mode_of_travel_sharp),
        // 'icon': SvgPicture.asset(
        //   'svg/voice_selection.svg',
        //   height: height,
        //   fit: BoxFit.contain,
        // ),
      },
      6: {
        'title': '面部轮廓',
        'icon': const Icon(Icons.mood),
      },
      7: {
        'title': '其他',
        'icon': const Icon(Icons.e_mobiledata),
      },
    };
    // category.forEach((key, value) {
    //   debugPrint('key=$key / value=$value');
    // });
    List<Widget> buttons = [];
    bool isSelected;
    for (var entry in category.entries) {
      isSelected = false;
      // debugPrint(
      //     'pageType=$pageType -> entry.key=${entry.key} == selectedCategoryNum=$selectedCategoryNum');
      if (entry.key == selectedCategoryNum) {
        isSelected = true;
      }
      buttons.add(
        TextButton.icon(
          onPressed: () {
            // debugPrint(
            //     'pageType=$pageType -> selectedCategoryNum=$selectedCategoryNum / entry.key=${entry.key} / entry.value=${entry.value['title']}');
            if (controller != null) {
              if (controller.selectedCategoryNum.value != entry.key &&
                  !controller.isInitLoading.value) {
                controller.selectedCategoryNum.value = entry.key;
                controller.reloadPage(reloadType: 'self');
              }
            }
          },
          style: !isSelected
              ? null
              : TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                ),
          label: Text(entry.value['title']),
          icon: entry.value['icon'],
        ),
      );
      // debugPrint(
      //     'entry=$entry / category.entries.last = ${category.entries.last}');
      //if ('$entry' != '${category.entries.last}') {
      //debugPrint('aaaaaa');
      buttons.add(
        const SizedBox(width: 6.0),
      );
      //}
    }

    return Row(
      children: buttons,
    );
  }
}
