import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final verificationFormProvider = StateProvider<FormGroup>((ref) {
  return FormGroup({
    'verification': FormControl<String>(validators: [
      Validators.minLength(6),
      Validators.required,
    ]),
  });
});

final visitVerificationFormProvider = StateProvider<FormGroup>((ref) {
  return FormGroup({
    'verification': FormControl<String>(validators: [
      Validators.minLength(4),
      Validators.required,
    ]),
  });
});
