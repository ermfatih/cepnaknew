// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:i18n_extension/default.i18n.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import '../../../theme.dart';

class ProfilePictureWidget extends ConsumerStatefulWidget {
  const ProfilePictureWidget(
      {super.key,
      this.imagUrl,
      this.onChange,
      this.isProfile = false,
      this.description,
        this.readOnly=false,
      });
  final void Function(CroppedFile image)? onChange;
  final String? imagUrl;
  final bool isProfile;
  final String? description;
  final bool? readOnly;

  @override
  ConsumerState<ProfilePictureWidget> createState() => _ProfilePicWidgetState();
}

class _ProfilePicWidgetState extends ConsumerState<ProfilePictureWidget> {
  String? _imagePath;

  @override
  void initState() {
    _imagePath;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appColor = ref.watch(appColorLightProvider);
    return Stack(
      alignment: const AlignmentDirectional(-1.6, -0.7),
      children: [
        //Icon(Icons.person),
        //SvgPicture.asset(Assets.svg.profileStars),
        Stack(alignment: const AlignmentDirectional(1.2, -0.75), children: [
          buildImage(),
          SizedBox(
            height: 3.h,
          ),
          if(widget.readOnly!=true)InkWell(
            onTap: () async => await getImage(appColor, context),
            child: CircleAvatar(
              backgroundColor: appColor.whiteish.shade200,
              radius: 18.r,
              child: Icon(
                Icons.camera_alt,
                size: 15.0.h,
              ),
            ),
          )
        ])
      ],
    );
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(AppColor appColor, BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      compressFormat: ImageCompressFormat.png,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            hideBottomControls: false,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          minimumAspectRatio: 1.5,
          rotateButtonsHidden: true,
          aspectRatioLockDimensionSwapEnabled: true,
          showActivitySheetOnDone: false,
          title: 'Cropper',
        ),
        WebUiSettings(
          enableResize: true,
          enableOrientation: true,
          enableZoom: true,
          context: context,
          customDialogBuilder: (cropper, crop, rotate) => Dialog(
              backgroundColor: appColor.whiteish,
              child: Builder(builder: (context) {
                return Container(
                  width: 600,
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 10, bottom: 10),
                  color: appColor.whiteish,
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: cropper,
                    ),
                    Positioned(
                      bottom: 0,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await crop().then(
                                  (value) => Navigator.of(context).pop(value));
                            },
                            child: Text("Crop Picture".i18n),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(appColor.redish)),
                            onPressed: () async {
                              /// it is important to call crop() function and return
                              /// result data to plugin, for example:
                              Navigator.of(context).pop(null);
                            },
                            child: Text('Cancel'.i18n),
                          ),
                        ],
                      ),
                    )
                  ]),
                );
              })),
        ),
      ],
    );
    if (croppedFile?.path.isNotEmpty ?? false) {
      _imagePath = croppedFile!.path;
      widget.onChange?.call(croppedFile);
      setState(() {});
    } else {
      _imagePath = image.path;
    }
  }

  Widget buildImage() {
    if (kIsWeb) {
      if (widget.imagUrl != null && _imagePath == null) {
        return CircleAvatar(
          radius: 65.r,
          backgroundImage: NetworkImage(widget.imagUrl!),
        );
      }
      if (_imagePath == null) {
        return CircleAvatar(
          radius: 65.0.r,
          child: const Icon(Icons.camera_alt, size: 30.0),
        );
      }

      if (_imagePath != null) {
        return CircleAvatar(
          radius: 65.r,
          backgroundImage: NetworkImage(_imagePath!),
        );
      }
    } else {
      if (widget.imagUrl != null && _imagePath == null) {
        return CircleAvatar(
          radius: 65.r,
          backgroundImage: NetworkImage(widget.imagUrl!),
        );
      }
      if (_imagePath == null) {
        return CircleAvatar(
          radius: 65.0.r,
          child: const Icon(Icons.camera_alt, size: 30.0),
        );
      }

      if (_imagePath != null) {
        return CircleAvatar(
          radius: 65.r,
          backgroundImage: FileImage(File(_imagePath!)),
        );
      }
    }
    return const SizedBox();
  }
}
