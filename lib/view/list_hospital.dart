import 'package:beauty_buyfine_net/components/public_func.dart';
import 'package:beauty_buyfine_net/components/sliver_appbar_func.dart';
import 'package:beauty_buyfine_net/components/sliver_list_func.dart';
import 'package:beauty_buyfine_net/components/validator_func.dart';
import 'package:beauty_buyfine_net/constants/constants.dart';
import 'package:beauty_buyfine_net/controller/list_controller.dart';
import 'package:beauty_buyfine_net/view/detail_case.dart';
import 'package:beauty_buyfine_net/view/detail_experts.dart';
import 'package:beauty_buyfine_net/view/detail_hospital.dart';
import 'package:beauty_buyfine_net/view/responsive_center.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

double minH = 120;
double maxH = 140;

class ListHospital extends GetView<ListController> {
  ListHospital({super.key});
  final ListController listHospitalController =
      Get.find<ListController>(tag: 'ListHospitalController');
  final SliverAppbarFunc sliverAppbarFunc = SliverAppbarFunc();
  final SliverListFunc sliverListFunc = SliverListFunc();

  Widget _listPage(BuildContext context) {
    if (!listHospitalController.hasRequested.value ||
        listHospitalController.isInitLoading.value) {
      return SliverToBoxAdapter(
        child: PublicFunc().loadingBar(
          context: context,
          label: 'Loading...',
        ),
      );
    } else {
      if (listHospitalController.dataList.isNotEmpty) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: listHospitalController.dataList.length +
                (listHospitalController.isLoading.value ||
                        listHospitalController.isLastPage.value
                    ? 1
                    : 0),
            (context, index) {
              if (index == listHospitalController.dataList.length &&
                  listHospitalController.isLoading.value) {
                return sliverListFunc.refreshLoading(context: context);
              } else if (index == listHospitalController.dataList.length &&
                  listHospitalController.isLastPage.value) {
                return sliverListFunc.endScrollInfo(
                  context: context,
                  message: '더이상 병원정보가 없습니다.',
                  controller: listHospitalController,
                );
              } else {
                int hospitalUid = 0;
                if (listHospitalController.dataList[index].uid > 0) {
                  hospitalUid = listHospitalController.dataList[index].uid;
                }
                String cnTitle = '';
                if (listHospitalController
                    .dataList[index].cnTitle!.isNotEmpty) {
                  cnTitle = listHospitalController.dataList[index].cnTitle!;
                }
                String krTitle = '';
                if (listHospitalController
                    .dataList[index].krTitle!.isNotEmpty) {
                  krTitle = listHospitalController.dataList[index].krTitle!;
                }
                String items = '';
                if (listHospitalController.dataList[index].items!.isNotEmpty) {
                  items = listHospitalController.dataList[index].items!;
                }
                String hospitalImage = '';
                if (listHospitalController
                    .dataList[index].hospitalImage!.isEmpty) {
                } else {
                  hospitalImage =
                      'https:${listHospitalController.dataList[index].hospitalImage}';
                }
                bool isHospitalImage = isImageUrlFormatValid(
                  urlStr: hospitalImage,
                );

                Widget errImageWiget = Center(
                  child: Text(
                    '이미지로딩실패',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ),
                );

                Widget subExpertsWidget = const SizedBox.shrink();
                if (listHospitalController.dataList[index].subExpertsList !=
                    null) {
                  subExpertsWidget = _subExpertsInfo(
                      context,
                      listHospitalController.dataList[index].subExpertsList!,
                      errImageWiget);
                }

                Widget subCaseWidget = const SizedBox.shrink();
                if (listHospitalController.dataList[index].subCaseList !=
                    null) {
                  subCaseWidget = _subCaseInfo(
                      context,
                      listHospitalController.dataList[index].subCaseList!,
                      errImageWiget);
                }
                //debugPrint('$isImage - $imageUrl');
                //debugPrint('Get.width=${Get.width}');
                return Card(
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  elevation: 0,
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    child: Column(
                      children: [
                        _titleInfo(context, hospitalUid, cnTitle, items),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    if (hospitalUid > 0) {
                                      Get.to(
                                        () => DetailHospital(uid: hospitalUid),
                                      );
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      !isHospitalImage
                                          ? errImageWiget
                                          : CachedNetworkImage(
                                              alignment: Alignment.topLeft,
                                              fit: BoxFit.contain,
                                              imageUrl: hospitalImage,
                                              errorWidget:
                                                  (context, url, error) {
                                                return errImageWiget;
                                              },
                                            ),
                                      const SizedBox(height: 5),
                                      Text(
                                        krTitle,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: subExpertsWidget,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: subCaseWidget,
                                ),
                              ),
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
          controller: listHospitalController,
          pageIndex: 0,
        );
      }
    }
  }

  Widget _subExpertsInfo(
      BuildContext context, Map subList, Widget errImageWiget) {
    List<Widget> widgets = [];
    String imageUrl = '';
    bool isImage = false;
    if (subList.isNotEmpty) {
      for (var entry in subList.entries) {
        int uid = int.parse(entry.key);
        imageUrl = '';
        if (entry.value.img.isEmpty) {
        } else {
          imageUrl = 'https:${entry.value.img}';
        }
        isImage = isImageUrlFormatValid(
          urlStr: imageUrl,
        );
        widgets.add(
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                if (uid > 0) {
                  Get.to(
                    () => DetailExperts(uid: uid),
                  );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    constraints:
                        BoxConstraints(maxHeight: maxH, minHeight: minH),
                    child: !isImage
                        ? errImageWiget
                        : CachedNetworkImage(
                            alignment: Alignment.topLeft,
                            fit: BoxFit.cover,
                            imageUrl: imageUrl,
                            errorWidget: (context, url, error) {
                              return errImageWiget;
                            },
                          ),
                  ),
                  // !isImage
                  //     ? errImageWiget
                  //     : CachedNetworkImage(
                  //         alignment: Alignment.topCenter,
                  //         height: minH,
                  //         fit: BoxFit.cover,
                  //         imageUrl: imageUrl,
                  //         errorWidget: (context, url, error) {
                  //           return errImageWiget;
                  //         },
                  //       ),
                  const SizedBox(height: 5),
                  Text(
                    entry.value.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
        // debugPrint(
        //     'entry=$entry / subList.entries.last = ${subList.entries.last}');
        if ('$entry' != '${subList.entries.last}') {
          //debugPrint('aaaaaa');
          widgets.add(
            const SizedBox(width: 5.0),
          );
        }
      }
      if (subList.length == 1) {
        widgets.add(
          const SizedBox(width: 5.0),
        );
        widgets.add(
          const Expanded(
            flex: 1,
            child: SizedBox.shrink(),
          ),
        );
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widgets,
    );
  }

  Widget _subCaseInfo(BuildContext context, Map subList, Widget errImageWiget) {
    int uid = 0;
    List<Widget> widgets = [];
    String beforeImageUrl = '';
    String afterImageUrl = '';
    bool isBeforeImage = false;
    bool isAfterImage = false;
    //debugPrint('subList = $subList');
    if (subList.isNotEmpty) {
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
        widgets.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  constraints: BoxConstraints(maxHeight: maxH, minHeight: minH),
                  child: !isBeforeImage
                      ? errImageWiget
                      : CachedNetworkImage(
                          alignment: Alignment.topLeft,
                          fit: BoxFit.cover,
                          imageUrl: beforeImageUrl,
                          errorWidget: (context, url, error) {
                            return errImageWiget;
                          },
                        ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Container(
                  constraints: BoxConstraints(maxHeight: maxH, minHeight: minH),
                  child: !isAfterImage
                      ? errImageWiget
                      : CachedNetworkImage(
                          alignment: Alignment.topLeft,
                          fit: BoxFit.cover,
                          imageUrl: afterImageUrl,
                          errorWidget: (context, url, error) {
                            return errImageWiget;
                          },
                        ),
                ),
              ),
            ],
          ),
        );
        widgets.add(const SizedBox(
          height: 5,
        ));
        widgets.add(
          Text(
            entry.value.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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

  Widget _titleInfo(
      BuildContext context, int uid, String cnTitle, String items) {
    return GestureDetector(
      onTap: () {
        if (uid > 0) {
          Get.to(
            () => DetailHospital(uid: uid),
          );
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: Get.width / 2),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Theme.of(context).colorScheme.secondary,
              child: Text(
                cnTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Text(
                  items,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(
    //     'listHospitalController.hasRequested.value = ${listHospitalController.hasRequested.value}');
    return Scaffold(
      drawer: sliverAppbarFunc.topMenu(
        context: context,
        controller: listHospitalController,
      ),
      body: RefreshIndicator(
        onRefresh: listHospitalController.onRefresh,
        child: Obx(
          () => ResponsiveCenter(
            maxContentWidth: deskTopMaxWidth,
            child: CustomScrollView(
              controller: listHospitalController.scrollController.value,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                sliverAppbarFunc.listSliverAppbar(
                    context: context,
                    controller: listHospitalController,
                    pageType: 'h',
                    title: '找医院',
                    lottieFileName: 'hospital.json'),
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
  //             color: Colors.green,
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
