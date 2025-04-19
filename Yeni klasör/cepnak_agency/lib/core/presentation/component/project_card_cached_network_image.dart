/*import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectCachedNetworkImage extends ConsumerWidget {
  const ProjectCachedNetworkImage({
    super.key,
    this.projectType,
    this.imageUrl,
    this.borderRadius,
  });
  final String? projectType;
  final String? imageUrl;

  final BorderRadiusGeometry? borderRadius;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Settings? settings = ref.read(authNotifierProvider).value?.settings;
    String? defaultImage;
    if (settings != null) {
      for (int i = 0; i < settings.sysProjects.length; i++) {
        if (projectType == settings.sysProjects[i].name) {
          defaultImage = settings.sysProjects[i].defaultPic.file?.url;
        }
      }
    }
    return ClipRRect(
      borderRadius:
          borderRadius ?? BorderRadius.horizontal(left: Radius.circular(12.r)),
      child: CachedNetworkImage(
        placeholder: (context, url) => Container(
            decoration: BoxDecoration(
          borderRadius: borderRadius ??
              BorderRadius.horizontal(left: Radius.circular(12.r)),
          color: Colors.grey,
        )),
        errorWidget: (context, url, error) => Container(
            decoration: BoxDecoration(
          borderRadius: borderRadius ??
              BorderRadius.horizontal(left: Radius.circular(12.r)),
          image: DecorationImage(image: NetworkImage(defaultImage ?? url)),
          color: Colors.grey,
        )),
        imageUrl: imageUrl ?? defaultImage ?? '',
        fit: BoxFit.fill,
      ),
    );
  }
}
*/