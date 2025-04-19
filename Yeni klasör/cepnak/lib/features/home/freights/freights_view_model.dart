import 'dart:async';
import 'package:cepnak/features/home/freights/freights_model.dart';
import 'package:cepnak/features/home/freights/freights_service.dart';
import 'package:cepnak/product/base/base_controller.dart';
import 'package:cepnak/product/models/agent_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FreightsViewModel extends BaseController{
  final QueryBuilder<ParseObject> freightsQuery = QueryBuilder<ParseObject>(ParseObject('freights'));

  final FreightService _service=FreightService();
  Rx<Future<List<Freight>?>?>? future;
  @override
  void onInit() {
    super.onInit();
    future=getFreights().obs;
  }
  final form=FormGroup({
    'minTonnage':FormControl<String>(validators: []),
    'maxTonnage':FormControl<String>(validators: []),
    'menuMultiple':FormControl<List<String>>(validators: []),
    'timeFirst':FormControl<DateTime>(validators: []),
    'timeSecond':FormControl<DateTime>(validators: []),
    'date':FormControl<DateTimeRange>(validators: []),
    'sliderNow':FormControl<num>(validators: []),
    'sliderMin':FormControl<num>(validators: []),
    'sliderMax':FormControl<num>(validators: []),
  });

  RxString freightId=''.obs;
  ParseUser? currentUser;
  Freight? freightModel;
  Agent? agentModel;
  /*void saveChanges() {
    future?.value=getFreightByFilter();
    NavigatorManager.instance.pop();
  }*/
  void resetFilter(){

  }
//form.value['minTonnage'] as double, form.value['maxTonnage'] as double,form.value['menuMultiple'] as List<String>
  /*Future<List<Freight>?> getFreightByFilter()async{
    return await _service.getFreightsByFilter(cities: ['Gaziantep']);
  }*/
  Future<List<Freight>?> getFreights()async{
    return await _service.getFreights();
  }




  Future<Agent?> getAgent(String? agentId)async{
    return await _service.getAgent(agentId);
  }
  //late Subscription<ParseObject> subscription;
  //final streamController=StreamController<List<ParseObject>>();
  //final liveQuery=LiveQuery();
  /*void startLiveQuery()async{
    subscription=await liveQuery.client.subscribe(freightsQuery);
    subscription.on(LiveQueryEvent.enter, (value){
      streamController.add(value);
    });
  }*/



}
