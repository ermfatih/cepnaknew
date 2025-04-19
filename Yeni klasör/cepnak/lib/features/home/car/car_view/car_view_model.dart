import 'package:cepnak/features/home/car/car_model.dart';
import 'package:cepnak/features/home/car/car_service.dart';
import 'package:cepnak/product/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class CarViewModel extends BaseController{
  RxString vehicleId=''.obs;
  CarService _service=CarService();
  Future<List<Vehicle>> getVehicles(String carrierId)async{
    return await _service.getVehicles(carrierId);
  }
  Future<ParseObject?> getCarrier() async{
    return await _service.getCarrierByCurrentUser();
  }


}