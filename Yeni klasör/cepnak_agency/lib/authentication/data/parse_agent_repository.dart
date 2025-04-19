import 'package:cepnak_agency/authentication/data/agent_repository.dart';
import 'package:cepnak_agency/authentication/domain/agent.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';

final parseAgentRepositoryProvider=Provider.autoDispose((ref) => ParseAgentRepository());

class ParseAgentRepository implements AgentRepository{
  @override
  Future<void> createAgent({required Agent agent}) async{
    await agent.create();
  }
  @override
  Future<Agent> getAgent({required String id}) async{
    final agent = QueryBuilder(Agent.clone())..whereEqualTo('objectId', id);
    final response = await agent.find();
    return response.first;
  }
  @override
  Future<Agent> getAgentByOwner({required ParseUser user})async {
    final agent = QueryBuilder(Agent.clone())..whereEqualTo('owner', user);
    final response = await agent.find();
    return response.first;
  }
  @override
  Future<bool?> updateAgent({required Agent? agent}) async {
    try {
      final respone = await agent?.update();
      return respone?.success;
    } catch (e) {
      throw false;
    }
  }


 

}