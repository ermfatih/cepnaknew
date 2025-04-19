import 'package:cepnak/product/base/base_controller.dart';
import 'package:get/get.dart';

class TabViewModel extends BaseController{
  RxInt selectedPage=2.obs;
  @override
  void onInit() {
    super.onInit();
  }
  void changeTab(int index){
    selectedPage.value=index;
  }
}