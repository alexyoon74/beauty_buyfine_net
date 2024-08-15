import 'package:beauty_buyfine_net/components/public_func.dart';
import 'package:beauty_buyfine_net/components/sliver_appbar_func.dart';
import 'package:beauty_buyfine_net/components/sliver_list_func.dart';
import 'package:beauty_buyfine_net/controller/list_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListCase extends GetView<ListController> {
  ListCase({super.key});
  final ListController listCaseController =
      Get.find<ListController>(tag: 'ListCaseController');
  final SliverAppbarFunc sliverAppbarFunc = SliverAppbarFunc();
  final SliverListFunc sliverListFunc = SliverListFunc();

  Widget _listPage(BuildContext context) {
    if (!listCaseController.hasRequested.value ||
        listCaseController.isInitLoading.value) {
      return SliverToBoxAdapter(
        child: PublicFunc().loadingBar(
          context: context,
          label: 'Loading...',
        ),
      );
    } else {
      if (listCaseController.dataList.isNotEmpty) {
        return SliverList.builder(
          itemCount: listCaseController.dataList.length,
          itemBuilder: (context, index) {
            if (listCaseController.isLoading.value) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: RefreshProgressIndicator(),
                ),
              );
            } else {
              return Card(
                margin: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                color: Theme.of(context).colorScheme.onInverseSurface,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: CachedNetworkImage(
                        imageUrl:
                            'https:${listCaseController.dataList[index].imgs?[1]}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        );
      } else {
        String errMsg = '정보가 없습니다';
        if (listCaseController.errMsg.value.isNotEmpty) {
          errMsg = listCaseController.errMsg.value;
        }
        return SliverToBoxAdapter(
          child: Center(
            child: Text(errMsg),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(
    //     'listCaseController.hasRequestedCase.value = ${listCaseController.hasRequested.value}');

    return Scaffold(
      drawer: sliverAppbarFunc.topMenu(context: context),
      body: Obx(
        () => CustomScrollView(
          controller: listCaseController.scrollController.value,
          slivers: [
            sliverAppbarFunc.listSliverAppbar(
                context: context,
                controller: listCaseController,
                pageType: 'c',
                title: '整容案例',
                lottieFileName: 'case.json'),
            _listPage(context),
          ],
        ),
      ),
    );
  }
}
