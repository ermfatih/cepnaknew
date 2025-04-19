// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:frontend/src/chat_management/application/start_chat_provider.dart';
// import 'package:frontend/src/core/data/parse_manager_repository.dart';
// import 'package:shafak_donor/src/core/data/parse_manager_repository.dart';

// final startChatWithHelpDesk=FutureProvider.autoDispose((ref) async{
//   final manager=await ref.read(parseManagerRepositoryProvider).getManagerByRole(role: 'helpDesk');
//   await ref.read(startChatProvider(manager).future);
// });