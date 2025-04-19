import 'package:cepnak_agency/authentication/provider/auth_notifier.dart';
import 'package:cepnak_agency/carriers_management/data/parse_request_repository.dart';
import 'package:cepnak_agency/carriers_management/domain/request_model.dart';
import 'package:cepnak_agency/freights_management/data/parse_freights_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getTotalValueProvider=FutureProvider.autoDispose((ref) async{
  final repo=ref.watch(parseFreightRepositoryProvider);
  final id=ref.watch(authNotifierProvider).value?.agent?.objectId;
  return await repo.getTotalFreightsEarning(agentId: id??'');
});
final getTotalCarrierProvider=FutureProvider.autoDispose((ref) async{
  final repo=ref.watch(parseRequestRepositoryProvider);
  final id=ref.watch(authNotifierProvider).value?.agent?.objectId;
  return await repo.getTotalCarriers(agentId: id??'');
});
final getFreightsForChart=FutureProvider.autoDispose((ref)async{
  final repo=ref.watch(parseFreightRepositoryProvider);
  final id=ref.watch(authNotifierProvider).value?.agent?.objectId;
  return await repo.getFreightsTypesByAgentId(agentId: id??'');
});
final getWaitingCarriers=FutureProvider.autoDispose((ref)async{
  final repo=ref.watch(parseRequestRepositoryProvider);
  final id=ref.watch(authNotifierProvider).value?.agent?.objectId;
  return await repo.getRequestByAgentId(agentId: id??'',status: RequestStatus.waiting);
});

