import 'package:cepnak/features/auth/register/register_service.dart';
import 'package:cepnak/product/models/carrier_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class ProfileService{
  final carrier=ParseObject('carriers');
  final QueryBuilder<Carrier> carriersQuery = QueryBuilder<Carrier>(Carrier.clone());

  RegisterService _registerService=RegisterService();
  ParseUser? _user;
  Carrier? _carrierModel;

  Future<Carrier?> getCarrier()async{
    _user=await _registerService.getUser();
    carriersQuery..whereEqualTo('userId', _user?.objectId);
    final response=await carriersQuery.query();
    if (response.success && response.results != null){
      return response.results?.first as Carrier;
    }
    return null;
  }
  void changeBreak()async{
    _carrierModel=await getCarrier();
    carrier..objectId=_carrierModel?.objectId;
    if(_carrierModel?.isBreak==false){
      carrier..set('isBreak', true);
      await carrier.update();
    }
    if(_carrierModel?.isBreak==true){
      carrier..set('isBreak', false);
      await carrier.update();
    }
  }


}