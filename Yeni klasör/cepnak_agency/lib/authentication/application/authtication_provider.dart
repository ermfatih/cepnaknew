
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';
final refreshProvider = StateProvider((ref) => 0);

final authFormProvider = StateProvider<FormGroup>((ref) {
  return FormGroup(
    {
      'phone': FormControl<PhoneNumber>(validators: [
        PhoneValidators.validMobile,
        PhoneValidators.required,
      ]),
    },
  );
});