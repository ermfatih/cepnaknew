import 'package:cepnak/features/home/freights/freights_model.dart';
import 'package:cepnak/features/home/freights/freights_service.dart';
import 'package:cepnak/product/base/base_controller.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';

class LoadInfoViewModel extends BaseController{
  FreightService _service=FreightService();

  Future<Freight?> getSelectedFreight(String freightId)async{
    return await _service.getSelectedFreight(freightId);
  }
  void showMapButton(){
    NavigatorManager.instance.pushToPage(NavigatesRoutes.loadInfoMapView);
  }
}