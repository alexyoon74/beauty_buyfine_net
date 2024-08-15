import 'package:beauty_buyfine_net/controller/bottom_navigation_controller.dart';
import 'package:beauty_buyfine_net/model/list_data.dart';
import 'package:beauty_buyfine_net/model/services/api_services.dart';
import 'package:beauty_buyfine_net/view/list_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListController extends GetxController {
  //static ListController get to => Get.find();
  static ListController toHospital() {
    return Get.find<ListController>(tag: 'ListHospitalController');
  }

  static ListController toCase() {
    return Get.find<ListController>(tag: 'ListCaseController');
  }

  static ListController toExperts() {
    return Get.find<ListController>(tag: 'ListExpertsController');
  }

  static ListController toInfo() {
    return Get.find<ListController>(tag: 'ListInfoController');
  }

  final Rx<ScrollController> scrollController = ScrollController().obs;
  final Rx<ListData> dataInfo = ListData().obs;
  //final RxList<RowsData> dataList = <RowsData>[].obs;
  final RxList<dynamic> dataList = <dynamic>[].obs;
  //final RxList<HospitalData> hospitalDataList = <HospitalData>[].obs;
  final RxList<ExpertsData> expertsDataList = <ExpertsData>[].obs;
  //final RxString pageType = 'c'.obs;
  final RxString pageType = ''.obs;
  final RxBool hasRequested = false.obs;
  final RxBool isInitLoading = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isLastPage = false.obs;
  final RxInt selectedCategoryNum = 0.obs;
  final RxString errMsg = ''.obs;

  bool isRefreshLoading = false;
  int nextPageNum = 1;
  int wasPageNum = 0;
  int pageSize = 10;
  int nextCursor = 0;
  int nextSortCursor = 0;
  double scrollGap = 0.0;
  //dataCallingScrollGap, tempDataCalledScrollGap 여기서만 초기화하기때무에 static으로처리
  //static 처리시 주의점
  //tag 옵션을 이용하여 하나의 컨트롤러 파일로 여러개 컨트롤러를 인스턴스를 하게 되면
  //컨트롤러 파일 변수를 static로 했을경우 tag 옵션을 사용한 모든 컨트롤러에서 공유되기 때문에
  //static로 처리한거는 초기화값이 변하면 안된다.
  static double dataCallingScrollGap = 200.0;
  static double tempDataCalledScrollGap = dataCallingScrollGap * 2;
  double dataCalledScrollGap = tempDataCalledScrollGap;

  //처음에 선택된 IndexedStack 페이지 데이터를 불러오기위해 한번만 필요하여 tag 적용한 모든 컨트롤러에 공유되게 static으로 처리하였음.
  static bool isInitCalledApi = false;

  @override
  void onReady() {
    //debugPrint('ListController - onReady');
    if (!isInitCalledApi) {
      //debugPrint('ListController - onReady-2');
      BottomNavigationController.to.changeBottomNavigation(
          pageIndex: BottomNavigationController.to.selectedIndex.value);
      isInitCalledApi = true;
    }
    super.onReady();
  }

  @override
  void onInit() {
    scrollController.value.addListener(
      () {
        // debugPrint(
        //     'scrollController.value.position.pixels = ${scrollController.value.position.pixels}');
        // debugPrint(
        //     'scrollController.value.position.maxScrollExtent = ${scrollController.value.position.maxScrollExtent}');
        scrollGap = scrollController.value.position.maxScrollExtent -
            scrollController.value.position.pixels;
        // debugPrint(
        //     '${scrollController.value.position.pixels} = ${scrollController.value.position.maxScrollExtent}');
        //if (scrollController.value.position.pixels == scrollController.value.position.maxScrollExtent)
        // debugPrint(
        //     'scrollGap=${scrollGap} / dataCalledScrollGap=${dataCalledScrollGap}');
        if (!isRefreshLoading &&
            scrollGap > 0 &&
            scrollGap < dataCallingScrollGap) {
          if (!isLastPage.value) {
            if (dataCalledScrollGap > scrollGap) {
              nextPageNum++;
              //debugPrint('called next page num =$nextPageNum');
              dataCalledScrollGap = -dataCallingScrollGap * 4;
              fetchData();
            }
          }
        } else {
          if (scrollGap > dataCallingScrollGap * 4) {
            dataCalledScrollGap = scrollGap;
          }
        }

        if (scrollController.value.position.pixels == 0.0) {
          isRefreshLoading = false;
        }
      },
    );

    super.onInit();
  }

  void initVar() {
    nextPageNum = 1;
    wasPageNum = 0;
    nextCursor = 0;
    nextSortCursor = 0;
    isLastPage.value = false;
    isInitLoading.value = false;
    isLoading.value = false;
    dataInfo.value = ListData();
    dataList.clear();
    errMsg.value = '';
  }

  Future<void> fetchData() async {
    // debugPrint(
    //     'hasRequested.value=${hasRequested.value} / nextPageNum=$nextPageNum / wasPageNum=$wasPageNum / isLastPage=${isLastPage.value}');
    if (nextPageNum > wasPageNum && hasRequested.value) {
      if (nextPageNum == 1) {
        isInitLoading.value = true;
      } else {
        isLoading.value = true;
      }
      var data = await ApiServices.getListData(
        pageType: pageType.value,
        cursor: nextCursor,
        s_cur: nextSortCursor,
        ca: selectedCategoryNum.value,
      );
      //debugPrint('data = $data');
      isLoading.value = false;
      isInitLoading.value = false;
      if (data.result > 0) {
        int nowCount = data.rows!.length;
        //nowCount = 8;
        if (data.lastId > 0) {
          nextCursor = data.lastId;
        }
        if (data.lastS > 0) {
          nextSortCursor = data.lastS;
        }
        if (nowCount > 0) {
          if (data.pageSize > 0) {
            pageSize = data.pageSize;
          }
          if (pageSize > nowCount) {
            isLastPage.value = true;
          }
          data.rows!.forEach(
            (key, value) {
              dataList.add(value);
            },
          );
        } else {
          isLastPage.value = true;
        }
        wasPageNum++;
      }
      //debugPrint('dataListh = $dataList');
      // debugPrint(
      //     'data.result=${data.result} / rows length = ${data.rows?.length}');
      // if (pageType.value == 'h') {
      //   debugPrint('dataList = ${dataList[0].subCaseList.length}');
      //   for (var entry in dataList[0].subCaseList.entries) {
      //     debugPrint(
      //         "Expert key = ${entry.key} / entry.value title=${entry.value.title}/ entry.value img=${entry.value.imgs[0]}");
      //   }
      // }
      // if (pageType.value == 'e') {
      //   debugPrint('dataList = ${dataList[0].subCaseList.length}');
      //   for (var entry in dataList[0].subCaseList.entries) {
      //     debugPrint(
      //         "Expert key = ${entry.key} / entry.value title=${entry.value.title} / entry.value txt=${entry.value.txt} / entry.value img=${entry.value.imgs[0]}");
      //   }
      // }
      if (pageType.value == 'i') {
        //debugPrint('dataList summary = ${dataList[0].summary}');
      }
      if (data.result < 1 && data.message.isNotEmpty) {
        errMsg.value = data.message;
      }
    }
  }

  Future<void> onRefresh() async {
    isRefreshLoading = true;
    initVar();
    await fetchData();
  }

  void reloadPage({
    String reloadType = 'new',
    int pageIndex = 0,
  }) {
    initVar();
    dataList.clear();
    if (reloadType == 'self') {
      fetchData(); //상단 SliverAppBar 이 부분이 안보여 페이지 이동처리했음
    } else {
      selectedCategoryNum.value = 0;
      Get.off(
        preventDuplicates: false,
        () => ListMain(),
      );

      BottomNavigationController.to
          .changeBottomNavigation(pageIndex: pageIndex);
    }
  }

  void setRequestedValues({
    required bool boolValue,
    required String pageType,
  }) {
    // debugPrint(
    //     'setRequestedValues => pageType=$pageType / nextPageNum=$nextPageNum>wasPageNum=$wasPageNum / isLastPage=${isLastPage.value}');
    if (nextPageNum > wasPageNum && !isLastPage.value) {
      hasRequested.value = boolValue;
      this.pageType.value = pageType;
      if (hasRequested.value) {
        fetchData();
      }
    }
  }
}
