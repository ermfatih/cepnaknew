/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:i18n_extension/default.i18n.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../theme.dart';
import '../../application/documents_provider.dart';

class FileListTile extends ConsumerWidget {
  const FileListTile({
    super.key,
    this.parseFileBase,
    this.error,
    this.values,
    this.description,
    required this.size,
  });
  final ParseFileBase? parseFileBase;
  final String? error;
  final double? values;
  final String? description;
  final int size;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColors = ref.read(appColorLightProvider);
    FileMimeType fileType = parseFileBase.getMimeType();

    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: fileType == FileMimeType.pdf
            ? Image.asset(
                Assets.png.pdf.path,
                width: 20.w,
                height: 20.h,
              )
            : fileType == FileMimeType.gif
                ? Image.asset(
                    Assets.png.gif.path,
                    width: 20.w,
                    height: 20.h,
                  )
                : Image.asset(
                    Assets.png.jpg.path,
                    width: 20.w,
                    height: 20.h,
                  ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: Text(parseFileBase?.name ?? 'null',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontSize: 12.sp),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1)),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
                child: Text(size.getByteType(),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontSize: 10.sp)))
          ],
        ),
        subtitle: values == 1
            ? Text(
                "Description: $description",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontSize: 10.sp),
              )
            : error != null
                ? Text(
                    error!,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: themeColors.redish, fontSize: 10.sp),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(
                          borderRadius: BorderRadius.all(Radius.circular(12.r)),
                          color: themeColors.greenish,
                          backgroundColor: themeColors.greyish,
                          value: values),
                      Text('${(values ?? 0).toInt()}%''Completed'.i18n),
                    ],
                  ),
        trailing: SizedBox(
          width: 40.w,
          child: values == 1
              ? Row(
                  children: [
                    InkWell(
                        onTap: () async {
                          ref
                              .read(myDocumentsProvider.notifier)
                              .downloadFile(parseFileBase);
                        },
                        child: Assets.png.download.image(width: 16.w)),
                    SizedBox(
                      width: 5.w,
                    ),
                    InkWell(
                        onTap: () async {
                          ref
                              .read(myDocumentsProvider.notifier)
                              .removeFile(parseFileBase);
                        },
                        child: Assets.png.remove.image()),
                  ],
                )
              : (error != null)
                  ? const Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox.shrink())
                  : Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: () {
                            parseFileBase?.cancel();
                          },
                          child: Assets.png.cancel.image())),
        ));
  }
}

enum FileMimeType { jpg, gif, pdf }

extension ParseFileMimeType on ParseFileBase? {
  FileMimeType getMimeType() {
    final extension = (this?.name ?? '').split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
        return FileMimeType.jpg;
      case 'gif':
        return FileMimeType.gif;
      case 'pdf':
        return FileMimeType.pdf;
      default:
        return FileMimeType.jpg;
    }
  }
}
*/