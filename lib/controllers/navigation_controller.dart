import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NavigationController extends GetxController{
  final RxInt currentIndex = 0.obs;

  void changeIndex(int index){
    currentIndex.value =index;
  }

}