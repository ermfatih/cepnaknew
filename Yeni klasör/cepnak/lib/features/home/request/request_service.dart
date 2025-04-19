import 'package:cepnak/product/constant/request_states_list.dart';
import 'package:cepnak/product/models/agent_model.dart';
import 'package:cepnak/product/models/carrier_model.dart';
import 'package:cepnak/product/models/request_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
enum RequestState{
  waiting,
  accepted,
  rejected
}
class RequestService{
  final QueryBuilder<Carrier> carriersQuery = QueryBuilder<Carrier>(Carrier.clone());
  final QueryBuilder<RequestModel> requestsQuery = QueryBuilder<RequestModel>(RequestModel.clone());
  final QueryBuilder<Agent> agentsQuery = QueryBuilder<Agent>(Agent.clone());

  final request = ParseObject('request');
  final carriers=ParseObject('carriers');
  Future<void> sendRequest({required Agent agentId,required String carrierId,required String message})async{
    carriers.objectId==carrierId;
    carriersQuery..whereEqualTo('objectId', carrierId);

    final response=await carriersQuery.query();
    if (response.success && response.results != null){
      final request=RequestModel(agentId: agentId, carrierId: response.results?.first,message: message,requestState: RequestStatus.waiting.name);
      //request..set('agentId', agentId)..set('code', '')..set('carrierId', carriers)..set('message',message)..set('requestState', RequestStatesConstant.requestStatesList.first);
      await request.create();
    }
  }
  Future<List<RequestModel>?> getRequest(String carrierId)async{
    requestsQuery..whereMatchesQuery('carrierId',QueryBuilder<Carrier>(Carrier.clone())..whereEqualTo('objectId', carrierId));
    final response=await requestsQuery.query();
    if (response.success && response.results != null){
      return response.results?.map((e) => e as RequestModel).toList();
    }
    return null;
  }

}


