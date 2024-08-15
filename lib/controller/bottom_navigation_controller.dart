import 'package:beauty_buyfine_net/controller/list_controller.dart';
import 'package:get/get.dart';

enum PageName { hospital, cases, experts, info, mypage }

class BottomNavigationController extends GetxController {
  static BottomNavigationController get to => Get.find();
  RxInt selectedIndex = 0.obs;
  List<int> bottomHistory = [0];

  void changeBottomNavigation({
    required int pageIndex,
    bool hasGesture = true,
  }) {
    //debugPrint('pageIndex= $pageIndex / hasGesture=$hasGesture');
    var page = PageName.values[pageIndex];
    switch (page) {
      case PageName.hospital:
      case PageName.cases:
      case PageName.experts:
      case PageName.info:
      case PageName.mypage:
        _changePage(pageIndex: pageIndex, hasGesture: hasGesture);
    }
  }

  void _changePage({
    required int pageIndex,
    bool hasGesture = true,
  }) {
    selectedIndex.value = pageIndex; //또는 selectedIndex(value); 이렇게 작성 해도 됨
    var page = PageName.values[pageIndex];
    //위에 컨트롤러를 인스턴스화 하지 않고 ListController.toCase() 이걸 사용한 이유는
    //main.dart > main() 함수하에서 컨트롤러 만드는 순서가
    //BottomNavigationController -> ListHospitalController, ListController... 이다보니
    //이 파일 위에서 Get.find로 ListController를 찾을수 없어서이다
    switch (page) {
      case PageName.cases:
        ListController.toCase()
            .setRequestedValues(boolValue: true, pageType: 'c');
      case PageName.hospital:
        ListController.toHospital()
            .setRequestedValues(boolValue: true, pageType: 'h');
      case PageName.experts:
        ListController.toExperts()
            .setRequestedValues(boolValue: true, pageType: 'e');
      case PageName.info:
        ListController.toInfo()
            .setRequestedValues(boolValue: true, pageType: 'i');
      case PageName.mypage:
        null;
    }

    if (!hasGesture) return;
    if (bottomHistory.last != pageIndex) {
      bottomHistory.add(pageIndex);
    }
  }
}
