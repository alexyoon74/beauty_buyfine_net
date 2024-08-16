import 'package:beauty_buyfine_net/components/public_func.dart';
import 'package:beauty_buyfine_net/components/sliver_appbar_func.dart';
import 'package:beauty_buyfine_net/components/sliver_list_func.dart';
import 'package:beauty_buyfine_net/components/validator_func.dart';
import 'package:beauty_buyfine_net/constants/constants.dart';
import 'package:beauty_buyfine_net/controller/list_controller.dart';
import 'package:beauty_buyfine_net/view/detail_case.dart';
import 'package:beauty_buyfine_net/view/responsive_center.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ListCase extends GetView<ListController> {
  ListCase({super.key});
  //final ListCaseController listCaseController = Get.put(ListCaseController());
  final ListController listCaseController =
      Get.find<ListController>(tag: 'ListCaseController');
  final SliverAppbarFunc sliverAppbarFunc = SliverAppbarFunc();
  final SliverListFunc sliverListFunc = SliverListFunc();
  //final PublicFunc publicFunc = PublicFunc();

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
      //listCaseController.dataList.clear();
      if (listCaseController.dataList.isNotEmpty) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: listCaseController.dataList.length +
                (listCaseController.isLoading.value ||
                        listCaseController.isLastPage.value
                    ? 1
                    : 0),
            (context, index) {
              if (index == listCaseController.dataList.length &&
                  listCaseController.isLoading.value) {
                return sliverListFunc.refreshLoading(context: context);
              } else if (index == listCaseController.dataList.length &&
                  listCaseController.isLastPage.value) {
                return sliverListFunc.endScrollInfo(
                  context: context,
                  message: '더이상 사례가 없습니다.',
                  controller: listCaseController,
                );
              } else {
                String? title = '';
                if (listCaseController.dataList[index].title!.isNotEmpty) {
                  title = listCaseController.dataList[index].title;
                }
                Html htmlTxt = Html(data: '');
                if (listCaseController.dataList[index].txt!.isNotEmpty) {
                  htmlTxt = Html(data: listCaseController.dataList[index].txt);
                }
                String beforeImageUrl = '';
                if (listCaseController.dataList[index].imgs!.isEmpty) {
                } else {
                  beforeImageUrl =
                      'https:${listCaseController.dataList[index].imgs?[0]}';
                }
                bool isBeforeImage = isImageUrlFormatValid(
                  urlStr: beforeImageUrl,
                );
                String afterImageUrl = '';
                if (listCaseController.dataList[index].imgs!.length < 2) {
                } else {
                  afterImageUrl =
                      'https:${listCaseController.dataList[index].imgs?[1]}';
                }
                afterImageUrl =
                    'https:${listCaseController.dataList[index].imgs?[1]}';
                bool isAfterImage = isImageUrlFormatValid(
                  urlStr: afterImageUrl,
                );
                Widget errImageWiget = Center(
                  child: Text(
                    '이미지로딩실패',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ),
                );
                //debugPrint('$isImage - $imageUrl');
                //debugPrint('Get.width=${Get.width}');
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => DetailCase(
                          uid: listCaseController.dataList[index].uid),
                    );
                  },
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Hero(
                              tag:
                                  'case${listCaseController.dataList[index].uid}',
                              child: Row(
                                children: [
                                  Expanded(
                                    child: !isBeforeImage
                                        ? errImageWiget
                                        : CachedNetworkImage(
                                            height: 120,
                                            fit: BoxFit.cover,
                                            imageUrl: beforeImageUrl,
                                            errorWidget: (context, url, error) {
                                              return errImageWiget;
                                            },
                                          ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: !isAfterImage
                                        ? errImageWiget
                                        : CachedNetworkImage(
                                            height: 120,
                                            fit: BoxFit.cover,
                                            imageUrl: afterImageUrl,
                                            errorWidget: (context, url, error) {
                                              return errImageWiget;
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.fromLTRB(2, 10, 2, 0),
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          htmlTxt,
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        );
      } else {
        return sliverListFunc.errorMessage(
          context: context,
          controller: listCaseController,
          pageIndex: 1,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(
    //     'listCaseController.hasRequested.value = ${listCaseController.hasRequested.value}');
    return Scaffold(
      drawer: sliverAppbarFunc.topMenu(
        context: context,
        controller: listCaseController,
      ),
      body: RefreshIndicator(
        onRefresh: listCaseController.onRefresh,
        child: Obx(
          () => ResponsiveCenter(
            maxContentWidth: deskTopMaxWidth,
            child: CustomScrollView(
              controller: listCaseController.scrollController.value,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                sliverAppbarFunc.listSliverAppbar(
                  context: context,
                  controller: listCaseController,
                  pageType: 'c',
                  title: '整容案例',
                  lottieFileName: 'case.json',
                ),
                _listPage(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
