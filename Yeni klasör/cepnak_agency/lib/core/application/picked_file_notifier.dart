import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

final pickedFileProvider = StateNotifierProvider.autoDispose<PickedFileNotifier,dynamic>((ref) {
  return PickedFileNotifier();
});
class PickedFileNotifier extends StateNotifier<dynamic> {
  PickedFileNotifier() : super(null);
  Future<void> pickFileFromFilePicker(BuildContext context) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'gif','png'],
    );
    if(mounted && !Platform.isAndroid){
      context.pop();
    }
    if (result != null){
      state =result.files.single;
    }
  }
  Future<void> picFileFromImagePicker(BuildContext context)async{
    final result=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(mounted){
      context.pop();
    }
    if(result!=null){
      state=result;
    }
  }
  void deleteFile(){
    state=null;
  }
}