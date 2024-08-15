import 'package:beauty_buyfine_net/constants/constants.dart';
import 'package:beauty_buyfine_net/controller/list_controller.dart';
import 'package:beauty_buyfine_net/view/responsive_center.dart';
import 'package:flutter/material.dart';

class SliverListFunc {
  Widget refreshLoading({
    required BuildContext context,
  }) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: RefreshProgressIndicator(),
      ),
    );
  }

  Widget endScrollInfo({
    required BuildContext context,
    required String message,
    required ListController controller,
  }) {
    return ResponsiveCenter(
      maxContentWidth: deskTopMaxWidth,
      child: Container(
        color: Theme.of(context).colorScheme.surfaceVariant,
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
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
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  Widget errorMessage({
    required BuildContext context,
    required ListController controller,
    pageIndex = 0,
  }) {
    String errMsg = '정보가 없습니다';
    Color containerColor = Theme.of(context).colorScheme.surfaceVariant;
    Color onContainerColor = Theme.of(context).colorScheme.onSurfaceVariant;
    if (controller.errMsg.value.isNotEmpty) {
      errMsg = controller.errMsg.value;
      containerColor = Theme.of(context).colorScheme.errorContainer;
      onContainerColor = Theme.of(context).colorScheme.onErrorContainer;
    }
    return SliverToBoxAdapter(
      child: ResponsiveCenter(
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
                  return controller.reloadPage(pageIndex: pageIndex);
                },
                icon: const Icon(Icons.refresh_outlined),
                color: onContainerColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
