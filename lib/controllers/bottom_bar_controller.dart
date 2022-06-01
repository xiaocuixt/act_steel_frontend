import 'package:get/get.dart';

class BottomBarController extends GetxController {
  var tabIndex = 0;

  void changeTabIndex(int index) {
    print(index);
    tabIndex = index;
    update();
  }
}
