import 'package:beauty_buyfine_net/model/detail_data.dart';
import 'package:beauty_buyfine_net/model/services/api_services.dart';
import 'package:beauty_buyfine_net/model/storage_viewed_detail.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final String initPageType;

  DetailController({
    required this.initPageType,
  });

  static DetailController toHospital() {
    return Get.find<DetailController>(tag: 'DetailHospitalController');
  }

  static DetailController toCase() {
    return Get.find<DetailController>(tag: 'DetailCaseController');
  }

  static DetailController toExperts() {
    return Get.find<DetailController>(tag: 'DetailExpertsController');
  }

  static DetailController toInfo() {
    return Get.find<DetailController>(tag: 'DetailInfoController');
  }

  //final Rx<ScrollController> scrollController = ScrollController().obs;
  final Rx<DetailData> dataInfo = DetailData().obs;
  //final RxList<dynamic> dataInfo = <dynamic>[].obs;
  final RxInt uid = 0.obs;
  final RxString pageType = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool isRefreshLoading = false.obs;
  final RxString errMsg = ''.obs;

  StorageViewedDetail viewedPrefs = StorageViewedDetail();

  @override
  void onInit() {
    super.onInit();
    initPrefs();
  }

  Future<void> initPrefs() async {
    await viewedPrefs.initPrefs();
  }

  void initVar() {
    isLoading.value = false;
    dataInfo.value = DetailData();
    //dataInfo.clear();
    errMsg.value = '';
  }

  Future<void> fetchData({
    required int uid,
    required String arguPageType,
  }) async {
    this.uid.value = uid;
    pageType.value = arguPageType;

    isLoading.value = true;
    var data = await ApiServices.getDetailData(
      pageType: arguPageType,
      uid: uid,
    );
    isLoading.value = false;
    isRefreshLoading.value = false;
    //debugPrint('data=${data.toString()}');
    //debugPrint('data.result=${data.result}');
    if (data.result > 0) {
      if (data.detailInfos != null) {
        await viewedPrefs.addData(
            key: pageType.value, value: data.detailInfos!.uid);
        //debugPrint('viewed : ${viewedPrefs.getData()}');
      }
      //debugPrint('data.result=${data.detailInfos}');
      dataInfo.value = data; //dataInfo.add(data.detailInfos);
      if (dataInfo.value.detailInfos is InfoDetailInfos) {
        //debugPrint(dataInfo.value.detailInfos?.uid);
        //debugPrint('info - ${dataInfo.value.detailInfos?.uid}');
      } else if (dataInfo.value.detailInfos is HospitalDetailInfos) {
        //debugPrint('Hospital - ${dataInfo.value.detailInfos?.uid}');
      } else if (dataInfo.value.detailInfos is ExpertsDetailInfos) {
        //debugPrint('Experts - ${dataInfo.value.detailInfos?.uid}');
      } else if (dataInfo.value.detailInfos is CaseDetailInfos) {
        //debugPrint('case - ${dataInfo.value.detailInfos?.uid}');
      } else {
        //debugPrint('detailInfos 타입이 예상과 다릅니다.');
        dataInfo.value = DetailData();
        errMsg.value = '데이터타입에 문제가 발생하였습니다';
      }
      //debugPrint('${dataInfo.value.detailInfos?.uid}');
    }
    if (data.result < 1 && data.message.isNotEmpty) {
      errMsg.value = data.message;
    }
  }

  Future<void> onRefresh() async {
    isRefreshLoading.value = true;
    initVar();
    await fetchData(uid: uid.value, arguPageType: pageType.value);
  }

  void reloadPage() {
    initVar();
    fetchData(uid: uid.value, arguPageType: pageType.value);
    // Get.off(
    //   preventDuplicates: false,
    //   () => DetailCase(uid: uid.value),
    // );
  }
}
