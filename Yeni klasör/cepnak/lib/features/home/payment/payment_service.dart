import 'package:cepnak/features/home/freights/freights_model.dart';
import 'package:cepnak/product/models/card_model.dart';
import 'package:cepnak/product/models/carrier_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class PaymentService{
  ParseUser? currentUser;
  final QueryBuilder<ParseObject> carrierQuery = QueryBuilder<Carrier>(Carrier.clone());
  final QueryBuilder<ParseObject> creditQuery = QueryBuilder<ParseObject>(ParseObject('creditCards'));
  final QueryBuilder<Freight> freightQuery = QueryBuilder<Freight>(Freight.clone());
  final creditCards=ParseObject('creditCards');
  final freight=ParseObject('freights');


  Future addCart(CardModel model)async{
    creditCards..set('cvvCode', model.cvvCode)
    ..set('expiryDate', model.expiryDate)
    ..set('cardHolderName', model.cardHolderName)
    ..set('cardNumber', model.cardNumber);
    await creditCards.save();
    currentUser = await ParseUser.currentUser() as ParseUser?;
    carrierQuery..whereEqualTo('userId', currentUser?.objectId);
    final response=await carrierQuery.query();
    if (response.success && response.results != null) {
      for(var carrier in (response.results! as List<ParseObject>)){
        carrier..addRelation('creditCards',[creditCards]);
        await carrier.save();
      }
    }
  }
  Future<Carrier?> getCarrierByCurrentUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser != null) {
      carrierQuery..whereEqualTo('userId', currentUser!.objectId);
      final response=await carrierQuery.query();
      if (response.success && response.results != null){
        return response.results?.first as Carrier;
      }
    }
    return null;
  }

  Future<List<CardModel>?> getCards()async{
    ParseObject? carrier=await getCarrierByCurrentUser();
    creditQuery..whereRelatedTo('creditCards', 'carriers', carrier?.objectId ?? '');
    final response=await creditQuery.query();
    if (response.success && response.results != null) {
      return (response.results! as List<ParseObject>).map((e) => CardModel.fromParseObject(e)).toList();
    }
    return null;
  }
  Future<void> setFreightCarrierId(Freight? freightModel)async{
    Carrier? carrier=await getCarrierByCurrentUser();
    freightQuery..whereEqualTo('objectId', freightModel?.objectId);
    final freight=ParseObject('freights');
    freight.objectId=freightModel?.objectId;
    freight.set('lastState', 'İş Alındı');
    freight.set('carrierId', carrier);
    await freight.update();
  }
}








