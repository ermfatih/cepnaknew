import 'package:app_settings/app_settings.dart';
import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/pink_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';


class CustomReactiveImage extends StatelessWidget {
  const CustomReactiveImage({super.key,});
  @override
  Widget build(BuildContext context) {
    return ReactiveImagePicker(
      validationMessages: {
        ValidationMessage.required:(error) => 'Bu alan boş bırakılamaz'
      },
      selectedValueBuilder: (image, handleDelete, handleChange) {
        return SizedBox(
          height: 300.h,
          width: 1.sw,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: image.map((e) =>
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectedFileView(
                      file: e,
                      changeIcon: Icon(Icons.edit),
                      onChange: handleChange,
                      deleteIcon: Icon(Icons.delete),
                      onDelete: handleDelete,
                    ),
                  ),
                ),).toList(),
          ),
        );
      },
      formControlName: 'image',
      decoration:  InputDecoration(
          contentPadding: EdgeInsets.zero,
          label:Text('Araç Fotoğrafları',style: context.myTextTheme.headlineSmall,) ,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          helperText: ' '),
      preprocessError: (e) async {
        if (e is PlatformException) {
          switch (e.code) {
            case 'photo_access_denied':
              await photoDenied(context);
              break;
            case 'camera_access_denied':
              await cameraDenied(context);
              break;
          }
        }
      },
      inputBuilder: (onPressed) => Center(child: PinkElevatedButton(onPressed:onPressed,isMini: true,text: 'Fotoğraf Yükle')),
    );
  }
  Future<void> photoDenied(BuildContext context) async =>
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Photo access required'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Open settings to allow access',
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('Settings'),
                onPressed: () async {
                  await AppSettings.openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
  Future<void> cameraDenied(BuildContext context) async =>
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Camera access required'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Open settings to allow access',
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('Settings'),
                onPressed: () async {
                  await AppSettings.openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
}