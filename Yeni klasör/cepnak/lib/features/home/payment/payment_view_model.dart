import 'package:cepnak/features/home/freights/freights_view_model.dart';
import 'package:cepnak/features/home/payment/payment_service.dart';
import 'package:cepnak/product/models/card_model.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PaymentViewModel extends GetxController{

  RxInt selectedValue=1.obs;
  var isSelected=false.obs;
  final FreightsViewModel _freightsViewModel=Get.find();
  final PaymentService _service=PaymentService();

  final formCard=FormGroup({
  'cardNumber':FormControl<String>(validators: [Validators.required]),
  'expiryDate':FormControl<String>(validators: [Validators.required]),
  'cvvCode':FormControl<String>(validators: [Validators.required]),
  'cardHolderName':FormControl<String>(validators: [Validators.required]),
  });

  void onPressedCard()async{
    if(formCard.valid){
      var model=CardModel(cardNumber: formCard.value['cardNumber'].toString(), expiryDate: formCard.value['expiryDate'].toString(), cardHolderName:formCard.value['cardHolderName'].toString(),cvvCode: formCard.value['cvvCode'].toString());
      await _service.addCart(model);
      NavigatorManager.instance.pop();
    }
    formCard.markAllAsTouched();
  }
  void onPressedApprove()async{
    await _service.setFreightCarrierId(_freightsViewModel.freightModel);
    NavigatorManager.instance.pushNamedAndUntil(NavigatesRoutes.freightsDetail,arguments: _freightsViewModel.freightId);
  }
  Future<List<CardModel>?> getCards()async{
    return await _service.getCards();
  }
}