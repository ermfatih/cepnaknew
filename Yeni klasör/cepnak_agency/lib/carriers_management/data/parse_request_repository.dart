import 'package:cepnak_agency/authentication/domain/agent.dart';
import 'package:cepnak_agency/carriers_management/data/request_repository.dart';
import 'package:cepnak_agency/carriers_management/domain/carrier_model.dart';
import 'package:cepnak_agency/carriers_management/domain/request_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';


final parseRequestRepositoryProvider=Provider.autoDispose((ref) => ParseRequestRepository());

class ParseRequestRepository implements RequestRepository{

  @override
  Future<bool> updateCarrierStatus({required String requestId,required String status}) async{
    try{
      final request=ParseObject('request');
      request.objectId=requestId;
      request.set('requestState',status);
      final response=await request.update();
      return response.success;
    }catch(e){
      return false;
    }
  }
  @override
  Future<List<RequestModel>?> getRequestByAgentId({required String agentId,RequestStatus? status,String? searchText}) async{
    final query=QueryBuilder<RequestModel>(RequestModel.clone())..includeObject(["carrierId"]);
    query.whereMatchesQuery('agentId', QueryBuilder<Agent>(Agent.clone())..whereEqualTo('objectId', agentId));
    if(status!=null){
      query.whereEqualTo('requestState', status.name);
    }
    if(searchText!=null && searchText!=''){
      query.whereMatchesQuery('carrierId', QueryBuilder<Carrier>(Carrier.clone())..whereContains('name', searchText));
    }
    final response = await query.query();
    return response.results?.map((e) => e as RequestModel).toList();
  }

  @override
  Future<int> getTotalCarriers({required String agentId}) async{
    final query=QueryBuilder<RequestModel>(RequestModel.clone());//..includeObject(["carrierId"]);
    query.whereMatchesQuery('agentId', QueryBuilder<Agent>(Agent.clone())..whereEqualTo('objectId', agentId));
    query.whereValueExists('carrierId', true);
    query.whereEqualTo('requestState', RequestStatus.accepted.name);
    final response=await query.query();
    return response.count;
  }
}