import 'package:beauty_buyfine_net/components/detail_page_func.dart';
import 'package:beauty_buyfine_net/controller/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailInfo extends GetView<DetailController> {
  final int uid;
  DetailInfo({
    super.key,
    required this.uid,
  });

  final DetailController detailInfoController = Get.find<DetailController>(
    tag: 'DetailInfoController',
  );
  final DetailPageFunc detailPageFunc = DetailPageFunc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info (uid=$uid)'),
      ),
      body: const Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
