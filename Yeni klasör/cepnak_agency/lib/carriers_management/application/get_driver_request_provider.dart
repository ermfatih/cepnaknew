import 'package:cepnak_agency/authentication/provider/auth_notifier.dart';
import 'package:cepnak_agency/carriers_management/data/parse_request_repository.dart';
import 'package:cepnak_agency/carriers_management/domain/request_model.dart';
import 'package:cepnak_agency/carriers_management/presentation/page/carriers_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getRequestProvider=FutureProvider.autoDispose<List<RequestModel>?>((ref) async{
  final agentId=ref.watch(authNotifierProvider).value?.agent?.objectId;
  final form=ref.watch(requestStatusForm);
  RequestStatus status=form.control('selectedEntry').value==0 ? RequestStatus.waiting: form.control('selectedEntry').value==1 ? RequestStatus.accepted:RequestStatus.rejected;
  final repo=ref.read(parseRequestRepositoryProvider);
  return await repo.getRequestByAgentId(agentId: agentId ?? '',status:status,searchText: form.control('search').value);
});