import 'dart:async';

import 'package:cepnak/features/home/freights/freights_model.dart';
import 'package:cepnak/product/constant/cities.dart';
import 'package:cepnak/product/models/agent_model.dart';
import 'package:cepnak/product/models/carrier_model.dart';
import 'package:cepnak/product/models/request_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class FreightService{
  final QueryBuilder<Agent> agentsQuery = QueryBuilder<Agent>(Agent.clone());
  final QueryBuilder<Freight> freightsQuery = QueryBuilder<Freight>(Freight.clone());

  final QueryBuilder<Carrier> carriersQuery = QueryBuilder<Carrier>(Carrier.clone());
  final QueryBuilder<ParseObject> destinationsQuery = QueryBuilder<ParseObject>(ParseObject('destination'));
  final QueryBuilder<ParseObject> addressQuery = QueryBuilder<ParseObject>(ParseObject('address'));
  var agents=ParseObject('agents');
  var freights=ParseObject('freights');
  var contactPerson=ParseObject('contactPerson');
  var source=ParseObject('source');
  var destination=ParseObject('destination');
  var invoice=ParseObject('invoice');
  ParseUser? currentUser;
  Carrier? _carrierModel;
  void addRelationsAgent()async{
    final String? name;
    final String? tc;
    final String? phone;
    final String? picture;
    contactPerson..set('name', 'Ali Murat')
    ..set('tc', '11111111111')
    ..set('phone', '05553333223')
    ..set('picture', 'şimdilik boş resim');
    await contactPerson.save();
    agents
        ..set('name', 'Logo Taşımacılık')
        ..set('logo', 'şimdilik null')
        ..set('address', 'şimdilik boş bi adres bilgisi')
        ..set('city', 'Gaziantep')
        ..set('phone', '05511544545')
        ..set('contactPerson', contactPerson);
    await agents.save();
  }
  Future<List<Freight>?> getFreights()async{
    freightsQuery..whereEqualTo('isCompleted', false);
    freightsQuery..whereValueExists('carrierId', false);
    freightsQuery..includeObject(['*']);

    final ParseResponse response=await freightsQuery.query();
    if (response.success && response.results != null) {
      return response.results?.map((e) => e as Freight).toList();
    }
    return [];
  }
  Future<List<Freight>?> getOldFreights()async{
    freightsQuery..whereEqualTo('isCompleted', true);
    freightsQuery..includeObject(['destination','invoice','source','destination.address','source.address']);
    final ParseResponse response=await freightsQuery.query();
    if (response.success && response.results != null) {
      return response.results?.map((e) => e as Freight).toList();
    }
    return [];
  }
  Future<Freight?> getSelectedFreight(String freightId)async{
    freightsQuery..whereEqualTo('objectId', freightId);
    freightsQuery..includeObject(['destination','invoice','source','destination.address','source.address']);

    final ParseResponse response=await freightsQuery.query();
    if (response.success && response.results != null) {
      return response.results?.first as Freight;
    }
    return null;
  }
  Future<void> changeFreightState(String? freightId,String lastState)async{
    final freight=ParseObject('freights');
    freight.set('lastState', lastState);
    await freight.update();
  }
  Future<String?> getFreightState(String? freightId)async{
    freightsQuery..whereEqualTo('objectId', freightId);
    final response=await freightsQuery.query();
    if (response.success && response.results != null){
      return (response.results!.first as ParseObject).get<String>('lastState');
    }
    return null;
  }
  Future<Agent?> getAgent(String? agentId)async{
    agentsQuery..whereEqualTo('objectId', agentId);
    agentsQuery..includeObject(['contactPerson']);
    final response=await agentsQuery.query();
    if (response.success && response.results != null){
      return response.results?.first as Agent;
    }
    return null;
  }


  Future<Carrier?> getCurrentCarrier()async{
    currentUser = await ParseUser.currentUser() as ParseUser?;
    carriersQuery..whereEqualTo('userId', currentUser?.objectId);
    final carrierResponse=await carriersQuery.query();
    if (carrierResponse.success && carrierResponse.results != null){
      return carrierResponse.results?.first as Carrier;
    }
    return null;
  }

  Future<Freight?> getFreightContinue()async{
    _carrierModel=await getCurrentCarrier();
    freightsQuery..whereEqualTo('carrierId', _carrierModel)..whereEqualTo('isCompleted', false)..orderByDescending('createdAt');
    freightsQuery..includeObject(['*']);
    final ParseResponse response=await freightsQuery.query();
    if (response.success && response.results != null) {
      return response.results?.first as Freight;
    }
    return null;
  }
  Future<void> updateFreightsCompleteStateById(String id)async{
    freights.objectId=id;
    freights.set('isCompleted', true);
    await freights.update();
  }



  Future<List<Freight>?> getFreightsByFilter({double? minTonnage,double? maxTonnage,List<String>? cities})async{
    freightsQuery..whereEqualTo('isCompleted', false);
    freightsQuery..includeObject(['destination','invoice','source','destination.address','source.address']);
    freightsQuery..whereGreaterThanOrEqualsTo('weight', minTonnage ?? 0);
    freightsQuery..whereLessThanOrEqualTo('weight', maxTonnage ?? 30000);
    addressQuery..whereContainedIn('city', cities ?? CityConstant.city.map((e) => capitalizeFirstLetter(e)).toList());
    destinationsQuery..whereMatchesQuery('address', addressQuery);
    freightsQuery..whereMatchesQuery('destination', destinationsQuery);

    final ParseResponse response=await freightsQuery.query();
    if (response.success && response.results != null) {
      return response.results?.map((e) => e as Freight).toList();
    }
    return [];
  }
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  Future<bool> checkUserPermission({required String carrierId,required String agentId})async{
    final query=QueryBuilder<RequestModel>(RequestModel.clone());
    query.includeObject(["*"]);
    query.whereMatchesQuery('carrierId', QueryBuilder<Carrier>(Carrier.clone())..whereEqualTo('objectId', carrierId));
    query.whereMatchesQuery('agentId', QueryBuilder<Agent>(Agent.clone())..whereEqualTo('objectId', agentId));
    final response=await query.query();
    final request=response.results?.first as RequestModel?;
    bool value=request?.requestState==RequestStatus.accepted.name;
    return value;
  }

}