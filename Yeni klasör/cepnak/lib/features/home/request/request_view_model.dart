import 'package:cepnak/features/home/request/request_service.dart';
import 'package:cepnak/product/base/base_controller.dart';
import 'package:cepnak/product/models/agent_model.dart';
import 'package:cepnak/product/models/carrier_model.dart';
import 'package:cepnak/product/models/request_model.dart';
import 'package:cepnak/product/service/agent_service.dart';
import 'package:cepnak/product/service/carrier_service.dart';
import 'package:cepnak/product/utils/dialog_functions.dart';
import 'package:reactive_forms/reactive_forms.dart';


class RequestViewModel extends BaseController{

  RequestService _requestService=RequestService();
  AgentService _agentService=AgentService();
  CarrierService _carrierService=CarrierService();
  Future<List<RequestModel?>?>? future;
  @override
  void onInit() {
    super.onInit();
    future=getRequestList();
  }
  final form=FormGroup({
    'phone':FormControl<String>(value: '+90',validators: [Validators.required]),
    'message':FormControl<String>(validators: [Validators.required,]),
      },);

  Agent? _agentModel;
  Carrier? _carrierModel;

  void sendRequest()async{
    if(form.valid){
      DialogFunctions.showCircular(context);
      try{
        _agentModel=await _agentService.getAgentByPhoneNumber(form.value['phone'].toString());
        _carrierModel=await _carrierService.getCurrentCarrier();
        if(_agentModel!=null && _carrierModel!=null){
          await _requestService.sendRequest(agentId: _agentModel!,carrierId: _carrierModel!.objectId!, message: form.value['message'].toString());
          closePage();
          DialogFunctions.showInfo(context, 'Talep Gönderildi');
        }
      }catch(e){
        closePage();
        DialogFunctions.showError(context, e.toString());
      }
    }
    form.markAllAsTouched();
  }
  Future<List<RequestModel>?> getRequestList()async{
    _carrierModel=await _carrierService.getCurrentCarrier();
    return await _requestService.getRequest(_carrierModel?.objectId ?? '');
  }
  Future<Agent?> getAgentById(Agent? agentId)async{
    return await _agentService.getAgent(agentId?.objectId);
  }

}




