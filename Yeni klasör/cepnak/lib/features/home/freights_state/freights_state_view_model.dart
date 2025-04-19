import 'package:cepnak/features/home/freights/freights_model.dart';
import 'package:cepnak/features/home/freights/freights_service.dart';
import 'package:cepnak/product/base/base_controller.dart';
import 'package:cepnak/product/constant/freights_states_list.dart';

class FreightsStateViewModel extends BaseController{
  FreightService _service=FreightService();
  Freight? freightsModel;
  String? lastState;
  List<String> list=[];

  Future<Freight?> getFreightState()async{
    return _service.getFreightContinue();
  }

  Future<List<String>> findIndex()async{
    list.clear();
    freightsModel=await getFreightState();
    int whereCount=FreightsStatesConstant.stateList.indexWhere((element) => element==freightsModel?.lastState);
    list.addAll(FreightsStatesConstant.stateList.sublist(0,whereCount+1));
    return list;
  }

  void changeState()async{
    if(list.length != FreightsStatesConstant.stateList.length){
      int count=list.length;
      list.add(FreightsStatesConstant.stateList.sublist(count,count+1).first);
      _service.changeFreightState(freightsModel?.objectId, FreightsStatesConstant.stateList.sublist(count,count+1).first);
    }
  }
}






