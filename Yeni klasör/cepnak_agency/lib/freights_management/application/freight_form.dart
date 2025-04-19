import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

import '../../authentication/provider/auth_notifier.dart';

final sourceLocationProvider = StateProvider<LatLng?>((ref) => null);
final destinationLocationProvider = StateProvider<LatLng?>((ref) => null);
final createFreightForm=Provider((ref) {
  final location=ref.read(authNotifierProvider).value?.agent?.location ?? ParseGeoPoint(longitude:0,latitude: 0);
  Future(() async {
    ref.read(sourceLocationProvider.notifier).state =
        LatLng(location.latitude, location.longitude);
  });
  Future(() async {
    ref.read(destinationLocationProvider.notifier).state =
        LatLng(location.latitude, location.longitude);
  });
  return FormGroup({
    'name':FormControl<String>(validators: [Validators.required]),
    'distance':FormControl<double>(validators: [Validators.required]),
    'cargoType':FormControl<String>(validators: [Validators.required]),
    'deliveryDate':FormControl<DateTime>(validators: [Validators.required]),
    'startDate':FormControl<DateTime>(validators: [Validators.required]),
    'price':FormControl<double>(validators: [Validators.required]),
    'commission':FormControl<double>(validators: [Validators.required]),
    'weight':FormControl<double>(validators: [Validators.required]),
    'destination':FormGroup({
      'location':FormControl<ParseGeoPoint>(),
      'locationText':FormControl<String>(),
      "address": FormGroup({
        "country": FormControl<String>(
          validators: [Validators.required],),
        "city": FormControl<String>(
            validators: [Validators.required]),
        "district": FormControl<String>(validators: [
          Validators.required,
          Validators.maxLength(15),
          Validators.minLength(4)
        ]),
        "description": FormControl<String>(
          validators: [Validators.maxLength(30), Validators.minLength(4)],
        ),
      }),
      'picture':FormControl<ParseFileBase>(),
      'name':FormControl<String>(),
      'phone1':FormControl<PhoneNumber>(),
    }),
    'source':FormGroup({
      'location':FormControl<ParseGeoPoint>(),
      'locationText':FormControl<String>(),
      "address": FormGroup({
        "country": FormControl<String>(
          validators: [Validators.required],),
        "city": FormControl<String>(
            validators: [Validators.required]),
        "district": FormControl<String>(validators: [
          Validators.required,
          Validators.maxLength(15),
          Validators.minLength(4)
        ]),
        "description": FormControl<String>(
          validators: [Validators.maxLength(30), Validators.minLength(4)],
        ),
      }),
      'picture':FormControl<ParseFileBase>(),
      'name':FormControl<String>(),
      'phone1':FormControl<PhoneNumber>(),
    })
  });
});
