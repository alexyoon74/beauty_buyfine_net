import 'package:beauty_buyfine_net/components/detail_page_func.dart';
import 'package:beauty_buyfine_net/controller/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailExperts extends GetView<DetailController> {
  final int uid;
  DetailExperts({
    super.key,
    required this.uid,
  });

  final DetailController detailExpertsController = Get.find<DetailController>(
    tag: 'DetailExpertsController',
  );
  final DetailPageFunc detailPageFunc = DetailPageFunc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Experts (uid=$uid)'),
      ),
      body: const Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
