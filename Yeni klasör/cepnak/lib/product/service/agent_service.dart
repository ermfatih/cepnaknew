import 'package:cepnak/product/models/agent_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class AgentService{
  final QueryBuilder<Agent> agentsQuery = QueryBuilder<Agent>(Agent.clone());

  Future<Agent?> getAgent(String? agentId)async{
    agentsQuery..whereMatchesQuery('objectId', QueryBuilder<Agent>(Agent.clone())..whereEqualTo('objectId', agentId));
    final response=await agentsQuery.query();
    if (response.success && response.results != null){
      return response.results?.first as Agent;
    }
    return null;
  }
  Future<Agent?> getAgentByPhoneNumber(String? phone)async{
    agentsQuery..whereEqualTo('phone', phone);
    final response=await agentsQuery.query();
    if (response.success && response.results != null){
      return response.results?.first as Agent;
    }
    else if(!response.success && response.results == null){
      throw 'Bu numaraya ait acenta bulunmamaktadır';
    }
    else{
      return null;
    }
  }

}