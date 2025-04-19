import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final connectivityStateProvider=AsyncNotifierProvider<ConnectivityNotifier,bool>((){
  return ConnectivityNotifier(Connectivity());
});
class ConnectivityNotifier extends AsyncNotifier<bool>{

  final Connectivity connectivity;

  ConnectivityNotifier(this.connectivity);
  @override
  FutureOr<bool> build() async{
    connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        state=const AsyncData(false);
      }else{
        state=const AsyncData(true);
      }
    });
    final connectivityStatus=await connectivity.checkConnectivity();
    if (connectivityStatus == ConnectivityResult.none){
      return false;
    }else{
      return true;
    }
  }
  Future<void>checkConnect()async{
    final connectivityStatus=await connectivity.checkConnectivity();
    if (connectivityStatus == ConnectivityResult.none){
      state=const AsyncData(false);
    }else{
      state=const AsyncData(true);
    }
  }

}