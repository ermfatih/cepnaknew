import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final fileFormProvider = Provider((ref) => FormGroup({
      "description": FormControl<String>(validators: [Validators.required]),
      "profileDocument": FormControl<String>(validators: [Validators.required]),
      "type": FormControl<String>()
    }));
