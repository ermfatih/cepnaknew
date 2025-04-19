import 'package:cepnak/product/models/carrier_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class CarrierService{
  final QueryBuilder<Carrier> carriersQuery = QueryBuilder<Carrier>(Carrier.clone());
  ParseUser? currentUser;
  Future<Carrier?> getCurrentCarrier()async{
    currentUser = await ParseUser.currentUser() as ParseUser?;
    carriersQuery..whereEqualTo('userId', currentUser?.objectId);
    //carriersQuery..whereEqualTo('owner', currentUser);
    final carrierResponse=await carriersQuery.query();
    if (carrierResponse.success && carrierResponse.results != null){
      return carrierResponse.results?.first as Carrier;
    }
    return null;
  }
}