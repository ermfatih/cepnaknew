/*import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../application/providers.dart';

class ImageProfileWidget extends ConsumerWidget {
  const ImageProfileWidget({super.key,
        this.url,
        this.isEdit = false,
        this.control,
        this.isUser = true,
        this.size,
        required this.isView});
  final bool isEdit;
  final bool isView;
  final bool isUser;
  final String? url;
  final String? control;
  final double? size;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    XFile img = ref.watch(imageProvider);

    return Stack(
      children: [
        SizedBox(
          width: size ?? 150,
          height: size ?? 150,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 100,
            foregroundImage: img.path == ''
                ? null
                : kIsWeb
                ? Image.network(img.path).image
                : (Image.file(File(img.path), fit: BoxFit.cover).image),
            backgroundImage: (url != null && url != "")
                ? Image.network(
              url!,
            ).image
                : Image.asset('assets/images/profile.png').image,
          ),
        ),
        if (!isView && isUser)
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90.r),
                  border: Border.all(
                    width: 1.5,
                    color: Colors.white,
                  ),
                  color: isEdit == false
                      ? const Color.fromARGB(255, 30, 122, 45)
                      : const Color.fromARGB(200, 10, 200, 0),
                ),
                width: 29,
                height: 29,
                child: ReactiveFormConsumer(
                  builder: (context, formGroup, child) {
                    return InkWell(
                      onTap: () async {
                        final img =
                        await ref.read(imageProvider.notifier).pic();

                        formGroup.control(control ?? 'image').value = img;
                      },
                      child: Icon(
                        isEdit == false ? Icons.add : Icons.edit,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: isEdit == false ? 22 : 20,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}*/