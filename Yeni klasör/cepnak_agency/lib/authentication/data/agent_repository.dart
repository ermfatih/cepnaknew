import 'package:cepnak_agency/authentication/domain/agent.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../domain/document.dart';

abstract class AgentRepository {
  Future<void> createAgent({required Agent agent});
  Future<void> updateAgent({required Agent agent});
  Future<Agent> getAgent({required String id});


  Future<Agent> getAgentByOwner({required ParseUser user});
}
