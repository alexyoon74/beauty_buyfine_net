import 'package:beauty_buyfine_net/components/detail_page_func.dart';
import 'package:beauty_buyfine_net/components/public_func.dart';
import 'package:beauty_buyfine_net/constants/constants.dart';
import 'package:beauty_buyfine_net/controller/detail_controller.dart';
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

  Map<String, String> _makeInfoTitle({
    required String str,
  }) {
    Map<String, String> arrResult = {
      'title': '',
      'str': '',
      'change': 'no',
    };
    str = str.replaceAll('：', ':'); //手术时间：1.5小时
    List<String> arrTitle = str.split(':');
    //debugPrint('arrTitle.length=${arrTitle.length} / $str');
    if (arrTitle.length > 1) {
      arrResult = {
        'title': arrTitle[0].trim(),
        'str': arrTitle[1].trim(),
        'change': 'yes',
      };
    }
    return arrResult;
  }

  Widget _infoWidget({
    required String title1,
    required String title2,
    required String str1,
    required String str2,
  }) {
    if (title1.isEmpty && str1.isNotEmpty) {
      Map<String, String> arrCheck = _makeInfoTitle(str: str1);
      if (arrCheck['change'] == 'yes') {
        title1 = arrCheck['title'].toString();
        str1 = arrCheck['str'].toString();
      }
    }
    if (title2.isEmpty && str2.isNotEmpty) {
      Map<String, String> arrCheck = _makeInfoTitle(str: str2);
      if (arrCheck['change'] == 'yes') {
        title2 = arrCheck['title'].toString();
        str2 = arrCheck['str'].toString();
      }
    }
    List arrInfoTitle = [];
    List arrInfoStr = [];
    if (str1.isNotEmpty) {
      if (title1.isEmpty) {
        arrInfoTitle.add('');
      } else {
        arrInfoTitle.add('$title1 : ');
      }
      arrInfoStr.add(str1);
    }
    if (str2.isNotEmpty) {
      if (title2.isEmpty) {
        arrInfoTitle.add('');
      } else {
        arrInfoTitle.add('$title2 : ');
      }
      arrInfoStr.add(str2);
    }
    Widget infoWidget = const SizedBox.shrink();
    if (arrInfoStr.isNotEmpty) {
      infoWidget = Wrap(
        //alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (int i = 0; i < arrInfoStr.length; i++) ...[
            Text(
              '${arrInfoTitle[i]}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('${arrInfoStr[i]}'),
            if (arrInfoStr[i] != arrInfoStr.last) const SizedBox(width: 14),
          ],
        ],
      );
    }
    return infoWidget;
  }

  Widget _detailPage(BuildContext context) {
    if (detailCaseController.isLoading.value) {
      return Center(
        child: PublicFunc().loadingBar(
          context: context,
          label: 'Loading...',
        ),
      );
    } else {
      final data = detailCaseController.dataInfo.value;
      if (data.detailInfos != null) {
        // Map<String, List> viewedList = {};
        // viewedList = {'c':[123, 125]};

        Widget hospitalWidget = const SizedBox.shrink();
        if (data.detailInfos!.bNameCn!.isNotEmpty) {
          hospitalWidget = detailPageFunc.buttonAction(
            context: context,
            type: 'h',
            title: '医院',
            label: data.detailInfos!.bNameCn ?? '',
            uid: data.detailInfos!.bUid ?? 0,
          );
        }

        Widget expertsWidget = const SizedBox.shrink();
        if (data.detailInfos!.relatedExperts!.isNotEmpty) {
          expertsWidget = detailPageFunc.buttonAction(
            context: context,
            type: 'e',
            title: '医生',
            label: data.detailInfos!.relatedExperts![0].name ?? '',
            uid: data.detailInfos!.relatedExperts![0].uid,
          );
        }

        Widget info1Widget = _infoWidget(
          title1: '价格',
          title2: '项目',
          str1: data.detailInfos!.priceInfo ?? '',
          str2: data.detailInfos!.relatedItems ?? '',
        );

        data.detailInfos!.otTimeInfo ?? '';
        data.detailInfos!.recoveryPeriodInfo ?? '';
        Widget info2Widget = _infoWidget(
          title1: '',
          title2: '',
          str1: data.detailInfos!.otTimeInfo!,
          str2: data.detailInfos!.recoveryPeriodInfo!,
        );

        return Column(
          children: [
            Hero(
              tag: 'case$uid',
              child: Card(
                clipBehavior: Clip.hardEdge,
                shadowColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                margin: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                elevation: 8,
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
                    height: 1.8,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Text(
                            data.detailInfos!.cTitle ?? 'No title',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                          ),
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        hospitalWidget,
                        expertsWidget,
                        info1Widget,
                        info2Widget,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              shadowColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(0.6),
              margin: const EdgeInsets.fromLTRB(8, 10, 8, 10),
              color: Theme.of(context).colorScheme.surface,
              elevation: 8,
              child: DefaultTextStyle(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 16,
                  height: 1.8,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Text(data.detailInfos!.contents ?? 'No contents'),
                        // Html(
                        //   data: data.detailInfos!.contents ?? 'No contents',
                        // ),
                        data.detailInfos!.contents!.isNotEmpty
                            ? contentsViewer(
                                context, data.detailInfos!.contents!)
                            : const Text('No contents')
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        if (detailCaseController.isRefreshLoading.value) {
          return const SizedBox.shrink();
        } else {
          return detailPageFunc.errorMessage(
            context: context,
            controller: detailCaseController,
          );
        }
      }
    }
  }

  Widget contentsViewer(BuildContext context, String contents) {
    for (MapEntry<String, String> entry in replaceStrList.entries) {
      contents = contents.replaceAll(entry.key, entry.value);
    }
    List<String> entries = contents.split('__');
    List<Widget> widgets = [];
    for (var entry in entries) {
      entry = entry.trim();
      if (entry.isEmpty) continue;
      List<String> parts = entry.split('^|');
      String type = parts[0];
      String value = parts[1];

      if (skipStrList.isNotEmpty && type != 'img') {
        bool isSkip = false;
        for (String skipStr in skipStrList) {
          if (entry.toLowerCase().contains(skipStr.toLowerCase())) {
            isSkip = true;
            break;
          }
        }
        if (isSkip) continue;
      }

      if (value.isNotEmpty && (type == 'txt' || type == 'bold_txt')) {
        TextStyle textStyle = const TextStyle();
        if (type == 'bold_txt') {
          textStyle = const TextStyle(
            fontWeight: FontWeight.bold,
          );
        }
        widgets.add(
          Text(
            value,
            style: textStyle,
          ),
        );
      } else if (type == 'txt_link' ||
          type == 'link' ||
          type == 'bold_txt_link') {
        // uid : b_uid, e_id, c_uid, f_uid
        // txt_link^|韩国ID整形朴华成前后对比照片^|c_uid*|1391
        // txt_link^|《我在韩国id家近五个月来的削骨经历日记》^|no_match_link*|no_match_link
        // txt_link^|如果没有效果的话，小编建议你^|b_uid*|22

        // faq_detail > contents 여기에서 txt_link는 특정 문자열만 링크를 걸어준다
        // link^|韩国365MC吸脂医院*|b_uid*|931
        // txt_link^|韩国延世slimline（延世姿丽来姻）^|延世姿丽来姻*|b_uid*|2
        // txt_link^|像韩国modelline，维摩，劳波尔，丽妍K，Dreamline……都是反馈不错的吸脂整形外科。^|modelline*|b_uid*|219^_维摩*|b_uid*|458^_劳波尔*|b_uid*|378^_丽妍K*|b_uid*|14^_Dreamline*|b_uid*|649
      } else if (type == 'img' || type == 'txt_img' || type == 'bold_txt_img') {
        // img^|2
        // txt_img^|李奇泳 韩国美特乐整形外科医院院长^|1
        // bold_txt_img^|孙院长面诊图↓^|1
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!detailCaseController.isLoading.value) {
      detailCaseController.uid.value = uid;
      detailCaseController.pageType.value = 'c';
      detailCaseController.fetchData(uid: uid, arguPageType: 'c');
    }
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: detailCaseController.onRefresh,
        child: ResponsiveCenter(
          maxContentWidth: deskTopMaxWidth,
          child: CustomScrollView(
            //controller: detailCaseController.scrollController.value,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              detailPageFunc.detailSliverAppbar(
                context: context,
                pageType: 'c',
                title: '整容案例',
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(
                      () => _detailPage(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
