import 'package:cepnak_agency/authentication/provider/auth_notifier.dart';
import 'package:cepnak_agency/freights_management/data/parse_freights_repository.dart';
import 'package:cepnak_agency/freights_management/domain/freight.dart';
import 'package:cepnak_agency/freights_management/presentation/page/freights_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FreightsState{
  completed,
  waiting,
  onTheWay,
}

final getFreightsProvider=FutureProvider.autoDispose<List<Freight>?>((ref) async{
  final agentId=ref.watch(authNotifierProvider).value?.agent?.objectId;
  final form=ref.watch(freightsFilterForm);
  final repo=ref.read(parseFreightRepositoryProvider);
  final FreightsState state=form.control('selectedEntry').value==2?FreightsState.completed:form.control('selectedEntry').value==1?FreightsState.onTheWay:FreightsState.waiting;
  return await repo.getFreightsByAgentId(state: state,searchText: form.control('search').value,agentId: agentId ?? '');
});
final getWaitingFreightsProvider=FutureProvider.autoDispose<List<Freight>?>((ref) async{
  final agentId=ref.watch(authNotifierProvider).value?.agent?.objectId;
  final form=ref.watch(freightsFilterForm);
  final repo=ref.read(parseFreightRepositoryProvider);
  const FreightsState state=FreightsState.waiting;
  return await repo.getFreightsByAgentId(state: state,searchText: form.control('search').value,agentId: agentId ?? '');
});