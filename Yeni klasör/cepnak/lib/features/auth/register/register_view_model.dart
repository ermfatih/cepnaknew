import 'package:cepnak/features/auth/register/register_service.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterViewModel extends GetxController{
  final RegisterService _registerService=RegisterService();

  final form=FormGroup({
    'menu':FormControl<String>(validators: [Validators.required]),
    'name':FormControl<String>(validators: [Validators.required,]),
    'phone':FormControl<String>(value:'+90',validators: [Validators.required]),
  });
  String get _name=> form.value['name'].toString();
  String get _menu=> form.value['menu'].toString();
  String get _phone=> form.value['phone'].toString();

  void onPressed()async{

    if(form.valid){
      await _registerService.createUser(userName: _name,phoneNumber:_phone,city:_menu);
      NavigatorManager.instance.pushNamedAndUntil(NavigatesRoutes.request);
    }
    form.markAllAsTouched();
  }
}
