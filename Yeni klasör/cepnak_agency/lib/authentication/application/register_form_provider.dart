import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

import '../domain/agent.dart';
import '../provider/auth_notifier.dart';

bool isEmail(String email) {
  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);
  return regExp.hasMatch(email);
}

final registerFormProvider = StateProvider<FormGroup>((ref) {
  final authState = ref.watch(authNotifierProvider).value;
  final iEmail = isEmail(authState?.username ?? "");
  return FormGroup({
    'fullname': FormControl<String>(validators: [
      Validators.required,
    ]),
    'userName': FormControl<String>(validators: [
      Validators.required,
    ]),
    'birthdate': FormControl<DateTime>(
        value: DateTime.now().subtract(const Duration(days: 365*18)),
        validators: [
          Validators.required,
          //Validators.max<DateTime>(DateTime.now()),
          Validators.max<DateTime>(DateTime.now().subtract(const Duration(days: 365*18)))
        ]),
    "isEmail": FormControl<bool>(value: iEmail),
    "phone": FormControl<PhoneNumber>(validators: []),
    "email": FormControl<String>(validators: [Validators.email]),
    "gender": FormControl<Gender>(
        value: Gender.male, validators: [Validators.required]),
    'image': FormControl<ParseFileBase?>(validators: []),
    "agreement": FormControl<bool>(
        validators: [Validators.required, Validators.equals(true)]),
    "address": FormGroup({
      "country": FormControl<String>(validators: [Validators.required]),
      "city": FormControl<String>(validators: [Validators.required]),
      "district": FormControl<String>(validators: [Validators.required]),
    })
  });
});
