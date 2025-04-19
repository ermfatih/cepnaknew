// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../authentication/provider/auth_notifier.dart';
// import '../data/currency_repository.dart';


// final convertCurrencyProvider=FutureProvider.autoDispose((ref)async{
//   final beneficiaryCurrency=ref.watch(authNotifierProvider).value?.beneficiary?.bankInformation?.currencyType ?? 'USD';
//   final currencyRepo=ref.watch(currencyRepositoryProvider);
//   return await currencyRepo.convertCurrencies(currencyFrom: 'USD', currencyTo: beneficiaryCurrency);
// });