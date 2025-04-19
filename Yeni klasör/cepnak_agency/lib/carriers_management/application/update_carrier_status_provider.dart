import 'package:bot_toast/bot_toast.dart';
import 'package:cepnak_agency/carriers_management/data/parse_request_repository.dart';
import 'package:cepnak_agency/carriers_management/domain/request_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final acceptCarrierStatusProvider=FutureProvider.autoDispose.family<void,String>((ref,id) async{
  BotToast.showLoading();
  final repo=ref.read(parseRequestRepositoryProvider);
  await repo.updateCarrierStatus(requestId: id, status: RequestStatus.accepted.name);
  BotToast.closeAllLoading();
});
final rejectCarrierStatusProvider=FutureProvider.autoDispose.family<void,String>((ref,id) async{
  BotToast.showLoading();
  final repo=ref.read(parseRequestRepositoryProvider);
  await repo.updateCarrierStatus(requestId: id, status: RequestStatus.rejected.name);
  BotToast.closeAllLoading();
});