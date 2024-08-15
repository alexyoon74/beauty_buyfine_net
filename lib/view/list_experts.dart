import 'package:beauty_buyfine_net/components/public_func.dart';
import 'package:beauty_buyfine_net/components/sliver_appbar_func.dart';
import 'package:beauty_buyfine_net/components/sliver_list_func.dart';
import 'package:beauty_buyfine_net/components/validator_func.dart';
import 'package:beauty_buyfine_net/constants/constants.dart';
import 'package:beauty_buyfine_net/controller/list_controller.dart';
import 'package:beauty_buyfine_net/view/detail_case.dart';
import 'package:beauty_buyfine_net/view/detail_experts.dart';
import 'package:beauty_buyfine_net/view/detail_info.dart';
import 'package:beauty_buyfine_net/view/responsive_center.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ListExperts extends GetView<ListController> {
  ListExperts({super.key});
  final ListController listExpertsController =
      Get.find<ListController>(tag: 'ListExpertsController');
  final SliverAppbarFunc sliverAppbarFunc = SliverAppbarFunc();
  final SliverListFunc sliverListFunc = SliverListFunc();
  final double imageH = 100;
  final double dividerH = 10;

  Divider _divider(BuildContext context,
      {double height = 16, double opacity = 0.3}) {
    return Divider(
      height: height,
      thickness: 1,
      color:
          Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(opacity),
    );
  }

  VerticalDivider _verticalDivider(BuildContext context,
      {double opacity = 0.1}) {
    return VerticalDivider(
      width: 9,
      thickness: 1,
      color:
          Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(opacity),
    );
  }

  Widget _subCaseInfo(BuildContext context, Map subList, Widget errImageWiget) {
    int uid = 0;
    List<Widget> widgets = [];
    String beforeImageUrl = '';
    String afterImageUrl = '';
    bool isBeforeImage = false;
    bool isAfterImage = false;
    String title = '';
    String txt = '';
    //debugPrint('subList = $subList');
    if (subList.isNotEmpty) {
      widgets.add(
        _divider(context),
      );
      for (var entry in subList.entries) {
        uid = int.parse(entry.key);
        //debugPrint('entry.key = ${entry.value.imgs[0]}');
        beforeImageUrl = '';
        if (entry.value.imgs[0].isEmpty) {
        } else {
          beforeImageUrl = 'https:${entry.value.imgs[0]}';
        }
        isBeforeImage = isImageUrlFormatValid(
          urlStr: beforeImageUrl,
        );
        afterImageUrl = '';
        if (entry.value.imgs.length < 2) {
        } else {
          afterImageUrl = 'https:${entry.value.imgs[1]}';
        }
        isAfterImage = isImageUrlFormatValid(
          urlStr: afterImageUrl,
        );
        title = entry.value.title ?? '';
        txt = entry.value.txt ?? '';
        widgets.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 6),
                      child: Text(
                        '$title ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _divider(context, height: 1, opacity: 0.1),
                    Html(
                      data: '<p>$txt</p>',
                      style: {
                        'p': Style(
                          //backgroundColor: Colors.amber,
                          direction: TextDirection.rtl,
                          padding: HtmlPaddings.zero,
                          margin: Margins.zero,
                        ),
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: imageH - 10,
                child: _verticalDivider(context),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: !isBeforeImage
                          ? errImageWiget
                          : CachedNetworkImage(
                              height: imageH,
                              fit: BoxFit.cover,
                              imageUrl: beforeImageUrl,
                              errorWidget: (context, url, error) {
                                return errImageWiget;
                              },
                            ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: !isAfterImage
                          ? errImageWiget
                          : CachedNetworkImage(
                              height: imageH,
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
            ],
          ),
        );
      }
    }

    return GestureDetector(
      onTap: () {
        if (uid > 0) {
          Get.to(
            () => DetailCase(uid: uid),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      ),
    );
  }

  Widget _subInfoInfo(BuildContext context, Map subList, Widget errImageWiget) {
    int uid = 0;
    List<Widget> widgets = [];
    String infoImageUrl = '';
    bool isInfoImage = false;
    String title = '';
    String items = '';
    String summary = '';
    if (subList.isNotEmpty) {
      widgets.add(_divider(context));
      for (var entry in subList.entries) {
        uid = int.parse(entry.key);
        infoImageUrl = '';
        if (entry.value.img.isEmpty) {
        } else {
          infoImageUrl = 'https:${entry.value.img}';
        }
        isInfoImage = isImageUrlFormatValid(
          urlStr: infoImageUrl,
        );
        title = entry.value.title ?? '';
        items = entry.value.items ?? '';
        summary = entry.value.summary ?? '';
        widgets.add(
          Row(
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
                        imageUrl: infoImageUrl,
                        errorWidget: (context, url, error) {
                          return errImageWiget;
                        },
                      ),
              ),
              SizedBox(
                height: imageH - 10,
                child: _verticalDivider(context),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
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
                      _divider(context, height: 10, opacity: 0.1),
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
        );
      }
    }
    return GestureDetector(
      onTap: () {
        if (uid > 0) {
          Get.to(
            () => DetailInfo(uid: uid),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widgets,
        ),
      ),
    );
  }

  Widget _listPage(BuildContext context) {
    if (!listExpertsController.hasRequested.value ||
        listExpertsController.isInitLoading.value) {
      return SliverToBoxAdapter(
        child: PublicFunc().loadingBar(
          context: context,
          label: 'Loading...',
        ),
      );
    } else {
      if (listExpertsController.dataList.isNotEmpty) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: listExpertsController.dataList.length +
                (listExpertsController.isLoading.value ||
                        listExpertsController.isLastPage.value
                    ? 1
                    : 0),
            (context, index) {
              if (index == listExpertsController.dataList.length &&
                  listExpertsController.isLoading.value) {
                return sliverListFunc.refreshLoading(context: context);
              } else if (index == listExpertsController.dataList.length &&
                  listExpertsController.isLastPage.value) {
                return sliverListFunc.endScrollInfo(
                  context: context,
                  message: '더이상 의사정보가 없습니다.',
                  controller: listExpertsController,
                );
              } else {
                String hospitalName = '';
                if (listExpertsController.dataList[index].cn!.isNotEmpty) {
                  hospitalName = listExpertsController.dataList[index].cn!;
                }

                String hospitalPosition = '';
                if (listExpertsController.dataList[index].pos!.isNotEmpty) {
                  hospitalPosition = listExpertsController.dataList[index].pos!;
                }

                String expertsItems = '';
                if (listExpertsController.dataList[index].items!.isNotEmpty) {
                  expertsItems = listExpertsController.dataList[index].items!;
                }

                String expertImage = '';
                if (listExpertsController.dataList[index].img!.isEmpty) {
                } else {
                  expertImage =
                      'https:${listExpertsController.dataList[index].img}';
                }
                bool isExpertImage = isImageUrlFormatValid(
                  urlStr: expertImage,
                );

                Widget errImageWiget = Center(
                  child: Text(
                    '이미지로딩실패',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ),
                );

                Widget subCaseWidget = const SizedBox.shrink();
                if (listExpertsController.dataList[index].subCaseList != null) {
                  subCaseWidget = _subCaseInfo(
                    context,
                    listExpertsController.dataList[index].subCaseList!,
                    errImageWiget,
                  );
                }

                Widget subInfoWidget = const SizedBox.shrink();
                if (listExpertsController.dataList[index].subInfoList != null) {
                  subInfoWidget = _subInfoInfo(
                    context,
                    listExpertsController.dataList[index].subInfoList!,
                    errImageWiget,
                  );
                }

                return Card(
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  elevation: 0,
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 15,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                          width: double.infinity,
                          child: Column(
                            children: [
                              //_expertsInfo(context, errImageWiget),
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => DetailExperts(
                                        uid: listExpertsController
                                            .dataList[index].uid),
                                  );
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: !isExpertImage
                                          ? errImageWiget
                                          : CachedNetworkImage(
                                              height: imageH,
                                              alignment: Alignment.center,
                                              fit: BoxFit.contain,
                                              imageUrl: expertImage,
                                              errorWidget:
                                                  (context, url, error) {
                                                return errImageWiget;
                                              },
                                            ),
                                    ),
                                    SizedBox(
                                      height: imageH - 10,
                                      child: _verticalDivider(context),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Card(
                                                margin: EdgeInsets.zero,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                clipBehavior: Clip.hardEdge,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                elevation: 0,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 6,
                                                      vertical: 2),
                                                  child: Text(
                                                    listExpertsController
                                                        .dataList[index].name!,
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSecondary,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  ' $hospitalName $hospitalPosition',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          _divider(context,
                                              height: 10, opacity: 0.1),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 3, vertical: 0),
                                            child: Text(
                                              expertsItems,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              subCaseWidget,
                              subInfoWidget,
                            ],
                          ),
                        ),
                      ],
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
          controller: listExpertsController,
          pageIndex: 2,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(
    //     'listExpertsController.hasRequested.value = ${listExpertsController.hasRequested.value}');
    return Scaffold(
      drawer: sliverAppbarFunc.topMenu(
        context: context,
        controller: listExpertsController,
      ),
      body: RefreshIndicator(
        onRefresh: listExpertsController.onRefresh,
        child: Obx(
          () => ResponsiveCenter(
            maxContentWidth: deskTopMaxWidth,
            child: CustomScrollView(
              controller: listExpertsController.scrollController.value,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                sliverAppbarFunc.listSliverAppbar(
                    context: context,
                    controller: listExpertsController,
                    pageType: 'e',
                    title: '找医生',
                    lottieFileName: 'doctors.json'),
                _listPage(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
