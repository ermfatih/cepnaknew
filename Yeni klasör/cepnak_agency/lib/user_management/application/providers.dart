import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageProvider = StateNotifierProvider.autoDispose<ImagePic, XFile>((ref) {
  return ImagePic();
});

class ImagePic extends StateNotifier<XFile> {
  ImagePic() : super(XFile(''));

  Future<XFile?> pic() async {
    final ImagePicker picker = ImagePicker();
    XFile? img = await picker.pickImage(source: ImageSource.camera);
    if (img != null) {
      state = img;
    }
    return img;
  }

  void setImageFile(XFile newFile) {
    state = newFile;
  }
}