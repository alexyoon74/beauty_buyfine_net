import 'package:beauty_buyfine_net/constants/constants.dart';
import 'package:beauty_buyfine_net/controller/detail_controller.dart';
import 'package:beauty_buyfine_net/view/detail_experts.dart';
import 'package:beauty_buyfine_net/view/detail_hospital.dart';
import 'package:beauty_buyfine_net/view/list_search.dart';
import 'package:beauty_buyfine_net/view/responsive_center.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final Map<String, String> replaceStrList = {
  '非常爱美网': 'BuyFine',
  'verym.com': 'buyfine.net',
  'iverym': 'buyfine',
  'verym': 'buyfine',
};
final List<String> skipStrList = ['编辑'];
final Map<String, String> returnPageType = {
  'b_uid': 'h',
  'e_id': 'e',
  'c_uid': 'c',
  'f_uid': 'i',
};
final Map<String, String> imgMidLoc = {
  'h': 'detail/info',
  'e': 'expert/info',
  'c': 'case/info',
  'i': 'faq/info',
};

class DetailPageFunc {
  SliverAppBar detailSliverAppbar({
    required BuildContext context,
    required String pageType,
    required String title,
  }) {
    return SliverAppBar(
      title: Text(title),
      floating: true,
      pinned: true,
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      foregroundColor: Theme.of(context).colorScheme.onSecondary,
      // backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      // foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
      actions: [
        IconButton(
          onPressed: () {
            Get.to(() => const ListSearch());
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  Widget buttonAction({
    required BuildContext context,
    required String type,
    required String title,
    required String label,
    required int uid,
  }) {
    return Wrap(
      //alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          '$title : ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        //const SizedBox(width: 5),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(0, 28),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            elevation: 0,
            visualDensity: VisualDensity.compact,
          ),
          onPressed: () {
            if (type == 'h' && uid > 0) {
              Get.to(
                () => DetailHospital(uid: uid),
              );
            } else if (type == 'e' && uid > 0) {
              Get.to(
                () => DetailExperts(uid: uid),
              );
            }
          },
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  Widget errorMessage({
    required BuildContext context,
    required DetailController controller,
  }) {
    String errMsg = '정보가 없습니다';
    Color containerColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    Color onContainerColor = Theme.of(context).colorScheme.onSurfaceVariant;
    if (controller.errMsg.value.isNotEmpty) {
      errMsg = controller.errMsg.value;
      containerColor = Theme.of(context).colorScheme.errorContainer;
      onContainerColor = Theme.of(context).colorScheme.onErrorContainer;
    }
    return ResponsiveCenter(
      maxContentWidth: deskTopMaxWidth,
      child: Container(
        //alignment: Alignment.center,
        width: double.infinity,
        color: containerColor,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errMsg,
              style: TextStyle(
                color: onContainerColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                return controller.reloadPage();
              },
              icon: const Icon(Icons.refresh_outlined),
              color: onContainerColor,
            ),
          ],
        ),
      ),
    );
  }
}
