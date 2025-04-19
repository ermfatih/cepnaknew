import 'package:cepnak_agency/authentication/domain/agent.dart';
import 'package:cepnak_agency/freights_management/application/get_freights_provider.dart';
import 'package:cepnak_agency/freights_management/data/freights_repository.dart';
import 'package:cepnak_agency/freights_management/domain/freight.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

final parseFreightRepositoryProvider=Provider.autoDispose((ref) => ParseFreightsRepository());

class ParseFreightsRepository implements FreightsRepository{
  @override
  Future<List<Freight>?> getFreightsByAgentId({required String agentId,String? searchText,required FreightsState state}) async {
    final query=QueryBuilder<Freight>(Freight.clone())..whereMatchesQuery('agentId', QueryBuilder<Agent>(Agent.clone())..whereEqualTo('objectId', agentId));
    query.includeObject(["*"]);
    if(searchText !=null && searchText!=''){
      query.whereContains('name', searchText);
    }
    if(state==FreightsState.completed){
      query.whereEqualTo('isCompleted', true);
    }
    if(state==FreightsState.onTheWay){
      query.whereValueExists('carrierId', true);
      query.whereEqualTo('isCompleted', false);
    }
    if(state==FreightsState.waiting){
      query.whereValueExists('carrierId', false);
    }

   final response=await query.query();
    return response.results?.map((e) => e as Freight).toList();
  }

  @override
  Future<void> createFreights({required Freight freightModel})async {
    await freightModel.destination?.create();
    await freightModel.source?.create();
    await freightModel.create();
  }

  @override
  Future<double> getTotalFreightsEarning({required String agentId}) async{
    final query=QueryBuilder<Freight>(Freight.clone());
    query.whereMatchesQuery('agentId', QueryBuilder<Agent>(Agent.clone()));
    final response=await query.query();
    final totalCountList= response.results?.map((e) => e as Freight).map((e) => e.price).toList() ?? [];
    double value=0;
    totalCountList.forEach((element) {
      value+=element;
    });
    return value;
  }

  @override
  Future<List<Freight>?> getFreightsTypesByAgentId({required String agentId}) async {
    final query=QueryBuilder<Freight>(Freight.clone())..whereMatchesQuery('agentId', QueryBuilder<Agent>(Agent.clone())..whereEqualTo('objectId', agentId));
    final response=await query.query();
    return response.results?.map((e) => e as Freight).toList();
  }
}