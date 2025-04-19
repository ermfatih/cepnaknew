import 'package:cepnak_agency/freights_management/domain/freight.dart';

import '../application/get_freights_provider.dart';

abstract class FreightsRepository{
  Future<List<Freight>?> getFreightsByAgentId({required String agentId,String? searchText,required FreightsState state});
  Future<void> createFreights({required Freight freightModel});
  Future<double> getTotalFreightsEarning({required String agentId});
  Future<List<Freight>?> getFreightsTypesByAgentId({required String agentId});
}