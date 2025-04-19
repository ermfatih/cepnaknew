import 'package:cepnak/features/home/freights/freights_model.dart';
import 'package:cepnak/features/home/freights/freights_service.dart';
import 'package:cepnak/product/models/agent_model.dart';
import 'package:get/get.dart';


class HomeViewModel extends GetxController{
  Rx<Future<Freight?>?>? future;
  @override
  void onInit() {
    super.onInit();
    future=getFreightContinue().obs;
  }
  FreightService _service=FreightService();

  Agent? _agentModel;
  Freight? _freightsModel;


  Future<Freight?> getFreightContinue()async{
    return await _service.getFreightContinue();
  }

}


class AgentWithFreight{
  final Agent? agentModel;
  final Freight? freightsModel;

  AgentWithFreight(this.agentModel, this.freightsModel);
}

