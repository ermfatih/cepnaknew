
import 'package:cepnak_agency/carriers_management/domain/request_model.dart';

abstract class RequestRepository{
  Future<List<RequestModel>?> getRequestByAgentId({required String agentId});
  Future<bool> updateCarrierStatus({required String requestId,required String status});
  Future<int> getTotalCarriers({required String agentId});
}