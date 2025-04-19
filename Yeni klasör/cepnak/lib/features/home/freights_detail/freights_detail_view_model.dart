import 'package:cepnak/features/_components/dialog/agent_info_dialog.dart';
import 'package:cepnak/features/_components/dialog/source_info_alert.dart';
import 'package:cepnak/features/_components/dialog/destination_info_alert.dart';
import 'package:cepnak/features/home/freights/freights_view_model.dart';
import 'package:cepnak/product/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreightDetailViewModel extends BaseController{
  final FreightsViewModel _freightsViewModel=Get.find();
  late BuildContext context;

  void setContext(BuildContext context){
    this.context=context;
  }

  void showSourceButton(){
      showDialog(context: context, builder: (context) {
        String? address= (_freightsViewModel.freightModel?.source?.address?.city?? '')
            + '/'+ (_freightsViewModel.freightModel?.source?.address?.district?? '')+'\n'
            +(_freightsViewModel.freightModel?.source?.address?.description?? '')+' '
            +(_freightsViewModel.freightModel?.source?.address?.country?? '');
        return ReceiverInfoAlert(name: _freightsViewModel.freightModel?.source?.name,phone: _freightsViewModel.freightModel?.source?.phone1,address:address ,);
      },);
  }
  void showDestinationButton(){
    showDialog(context: context, builder: (context) {
      return SourceInfoAlert(phone: _freightsViewModel.freightModel?.destination?.phone1,name:_freightsViewModel.freightModel?.destination?.name ,);
    },);
  }
  void showAgentDetailDialogButton(){
    showDialog(context: context, builder: (context) {
      return AgentInfoDialog(phone: _freightsViewModel.agentModel?.phone,name:_freightsViewModel.agentModel?.name ,);
    },);
  }
}