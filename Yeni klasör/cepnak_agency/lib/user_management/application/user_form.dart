import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

final userFormProvider=Provider((ref) {
  return FormGroup({
    'image': FormControl<XFile>(),
  });
});