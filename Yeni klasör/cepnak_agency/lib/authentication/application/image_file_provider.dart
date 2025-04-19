
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImageFileNotifier extends StateNotifier<XFile?> {
  ImageFileNotifier() : super(null);

  void setImageFile(XFile file) {
    state = file;
  }

  void clearImageFile() {
    state = null;
  }
}

final imageFileProvider = StateNotifierProvider<ImageFileNotifier, XFile?>(
    (ref) => ImageFileNotifier());
