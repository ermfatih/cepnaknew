import 'package:cepnak/features/home/profile/profile_service.dart';
import 'package:cepnak/product/constant/cache_enums.dart';
import 'package:cepnak/product/init/cache/cache_manager.dart';
import 'package:cepnak/product/models/carrier_model.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfileViewModel extends GetxController{
  ProfileService _service=ProfileService();
  //burada sadece ara verme butonu tamamlandı

  Future<Carrier?> getCarrier()async{
    return await _service.getCarrier();
  }
  @override
  void onInit() {
    super.onInit();
    giveToFormValues();
  }


  Carrier? carrierModel;
  final form= FormGroup({
    'notification':FormControl<bool>(validators: [Validators.required]),
    'showExpensive':FormControl<bool>(validators: [Validators.required,]),
    'darkTheme':FormControl<bool>(validators: [Validators.required]),
    'isBreak':FormControl<bool>(validators: [Validators.required,]),
  });


  void changeShowExpensive(){
    CacheManager.instance.setBoolValue(CacheKeys.showExpensive,form.value['showExpensive'] as bool);
  }
  void giveToFormValues()async{
    carrierModel=await _service.getCarrier();
    form.value = {
      'notification': false,
      'showExpensive':CacheManager.instance.getBoolValue(CacheKeys.showExpensive),
      'darkTheme':false,
      'isBreak':carrierModel?.isBreak,
    };
  }

  void changeBreak(){
    _service.changeBreak();
  }
}