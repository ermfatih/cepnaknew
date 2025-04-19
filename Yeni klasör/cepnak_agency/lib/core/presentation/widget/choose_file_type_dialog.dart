import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:i18n_extension/default.i18n.dart';

import '../../application/picked_file_notifier.dart';
import '../widget/dynamic_button.dart';
class ChooseFileTypeDialog extends ConsumerWidget {
  const ChooseFileTypeDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      alignment: Alignment.center,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.all(20.h),
      content: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Select File Type'.i18n,
                style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 5.h),
            Text('Choose one of them.\n File or image'.i18n,
                style: Theme.of(context).textTheme.labelMedium),
            SizedBox(height: 10.h),
            DynamicButton(
              title: 'File',
              width: double.infinity,
              onPressed: () async {
                ref
                    .read(pickedFileProvider.notifier)
                    .pickFileFromFilePicker(context);
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            DynamicButton(
              title: 'Image',
              width: double.infinity,
              onPressed: () {
                ref
                    .read(pickedFileProvider.notifier)
                    .picFileFromImagePicker(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
