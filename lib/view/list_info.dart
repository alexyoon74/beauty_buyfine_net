import 'package:beauty_buyfine_net/components/public_func.dart';
import 'package:beauty_buyfine_net/components/sliver_appbar_func.dart';
import 'package:beauty_buyfine_net/components/sliver_list_func.dart';
import 'package:beauty_buyfine_net/components/validator_func.dart';
import 'package:beauty_buyfine_net/constants/constants.dart';
import 'package:beauty_buyfine_net/controller/list_controller.dart';
import 'package:beauty_buyfine_net/view/detail_info.dart';
import 'package:beauty_buyfine_net/view/responsive_center.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListInfo extends GetView<ListController> {
  ListInfo({super.key});
  final ListController listInfoController =
      Get.find<ListController>(tag: 'ListInfoController');
  final SliverAppbarFunc sliverAppbarFunc = SliverAppbarFunc();
  final SliverListFunc sliverListFunc = SliverListFunc();
  final double imageH = 120;

  Widget _listPage(BuildContext context) {
    if (!listInfoController.hasRequested.value ||
        listInfoController.isInitLoading.value) {
      return SliverToBoxAdapter(
        child: PublicFunc().loadingBar(
          context: context,
          label: 'Loading...',
        ),
      );
    } else {
      if (listInfoController.dataList.isNotEmpty) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: listInfoController.dataList.length +
                  (listInfoController.isLoading.value ||
                          listInfoController.isLastPage.value
                      ? 1
                      : 0), (context, index) {
            if (index == listInfoController.dataList.length &&
                listInfoController.isLoading.value) {
              return sliverListFunc.refreshLoading(context: context);
            } else if (index == listInfoController.dataList.length &&
                listInfoController.isLastPage.value) {
              return sliverListFunc.endScrollInfo(
                context: context,
                message: '더이상 정보가 없습니다.',
                controller: listInfoController,
              );
            } else {
              String title = '';
              if (listInfoController.dataList[index].title!.isNotEmpty) {
                title = listInfoController.dataList[index].title!;
              }

              String items = '';
              if (listInfoController.dataList[index].items!.isNotEmpty) {
                items = listInfoController.dataList[index].items!;
              }

              String summary = '';
              if (listInfoController.dataList[index].summary!.isNotEmpty) {
                summary = listInfoController.dataList[index].summary!;
              }

              String infoImage = '';
              if (listInfoController.dataList[index].img!.isEmpty) {
              } else {
                infoImage = 'https:${listInfoController.dataList[index].img}';
              }
              bool isInfoImage = isImageUrlFormatValid(
                urlStr: infoImage,
              );

              Widget errImageWiget = Center(
                child: Text(
                  '이미지로딩실패',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
              );

              return GestureDetector(
                onTap: () {
                  Get.to(
                    () =>
                        DetailInfo(uid: listInfoController.dataList[index].uid),
                  );
                },
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  elevation: 0,
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 15,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: !isInfoImage
                              ? errImageWiget
                              : CachedNetworkImage(
                                  height: imageH,
                                  alignment: Alignment.center,
                                  fit: BoxFit.cover,
                                  imageUrl: infoImage,
                                  errorWidget: (context, url, error) {
                                    return errImageWiget;
                                  },
                                ),
                        ),
                        SizedBox(
                          height: imageH - 10,
                          child: VerticalDivider(
                            width: 9,
                            thickness: 1,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withOpacity(0.2),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(
                                  height: 10,
                                  thickness: 1,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant
                                      .withOpacity(0.2),
                                ),
                                Text(
                                  items,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  summary,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
        );
      } else {
        return sliverListFunc.errorMessage(
          context: context,
          controller: listInfoController,
          pageIndex: 3,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(
    //     'listInfoController.hasRequested.value = ${listInfoController.hasRequested.value}');
    return Scaffold(
      drawer: sliverAppbarFunc.topMenu(
        context: context,
        controller: listInfoController,
      ),
      body: RefreshIndicator(
        onRefresh: listInfoController.onRefresh,
        child: Obx(
          () => ResponsiveCenter(
            maxContentWidth: deskTopMaxWidth,
            child: CustomScrollView(
              controller: listInfoController.scrollController.value,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                sliverAppbarFunc.listSliverAppbar(
                    context: context,
                    controller: listInfoController,
                    pageType: 'i',
                    title: '整容攻略',
                    lottieFileName: 'info2.json'),
                //_sampleList(),
                _listPage(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // SliverList _sampleList() {
  //   return SliverList.builder(
  //     itemCount: 10,
  //     itemBuilder: (context, index) {
  //       return Column(
  //         children: [
  //           Container(
  //             margin: const EdgeInsets.fromLTRB(8, 10, 8, 0),
  //             width: double.infinity,
  //             height: 200,
  //             color: Colors.amber,
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
