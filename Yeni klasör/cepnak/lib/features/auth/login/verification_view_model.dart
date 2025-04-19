import 'dart:async';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class VerificationViewModel extends GetxController{
  late Timer _timer;
  late RxInt remainingTime;

  final form=FormGroup({'code':FormControl<String>(validators: [Validators.required]),});

  void startTimer(){
    remainingTime=10.obs;
    _timer=Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
      } else {
        timer.cancel();
      }
    });
  }
  void resetTime(){
    _timer.cancel();
    remainingTime.value=10;
  }
  void closeTimer(){
    _timer.cancel();
  }
}
