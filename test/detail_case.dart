import 'package:beauty_buyfine_net/components/detail_page_func.dart';
import 'package:beauty_buyfine_net/components/public_func.dart';
import 'package:beauty_buyfine_net/constants/constants.dart';
import 'package:beauty_buyfine_net/controller/detail_controller.dart';
import 'package:beauty_buyfine_net/view/list_search.dart';
import 'package:beauty_buyfine_net/view/responsive_center.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailCase extends GetView<DetailController> {
  final int uid;
  DetailCase({
    super.key,
    required this.uid,
  });

  final DetailController detailCaseController = Get.find<DetailController>(
    tag: 'DetailCaseController',
  );
  final DetailPageFunc detailPageFunc = DetailPageFunc();
  //final PublicFunc publicFunc = PublicFunc();

  Widget _detailPage(BuildContext context) {
    if (detailCaseController.isLoading.value &&
        !detailCaseController.isRefreshLoading.value) {
      return Center(
        child: PublicFunc().loadingBar(
          context: context,
          label: 'Loading...',
        ),
      );
    } else {
      final data = detailCaseController.dataInfo.value;
      if (data.detailInfos != null) {
        return ResponsiveCenter(
          maxContentWidth: deskTopMaxWidth,
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.fromLTRB(8, 18, 8, 18),
                color: Theme.of(context).colorScheme.surfaceVariant,
                elevation: 0,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(10.0),
                // ),
                // shape: BeveledRectangleBorder(
                //   borderRadius: BorderRadius.circular(10.0),
                // ),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 16,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            data.detailInfos!.cTitle ?? 'No title',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(
                          height: 20,
                          thickness: 1,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        if (data.detailInfos!.bNameCn!.isNotEmpty)
                          detailPageFunc.buttonAction(
                            context: context,
                            type: 'h',
                            title: '医院',
                            label: data.detailInfos!.bNameCn!,
                            uid: data.detailInfos!.bUid!,
                          ),
                        if (data.detailInfos!.relatedExperts!.isNotEmpty)
                          detailPageFunc.buttonAction(
                            context: context,
                            type: 'e',
                            title: '医生',
                            label: data.detailInfos!.relatedExperts![0].name!,
                            uid: data.detailInfos!.relatedExperts![0].uid,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Hero(
                tag: 'case$uid',
                child: Text('Detail-$uid'),
              ),
            ],
          ),
        );
      } else {
        return detailPageFunc.errorMessage(
          context: context,
          controller: detailCaseController,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!detailCaseController.isLoading.value) {
      detailCaseController.uid.value = uid;
      detailCaseController.pageType.value = 'c';
      detailCaseController.fetchData(uid: uid, arguPageType: 'c');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        centerTitle: true,
        title: const Text('整容案例'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const ListSearch());
            },
            icon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          //debugPrint('constraints.maxHeight=${constraints.maxHeight}');
          return RefreshIndicator(
            onRefresh: detailCaseController.onRefresh,
            child: SingleChildScrollView(
              //controller: detailCaseController.scrollController.value,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => _detailPage(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
