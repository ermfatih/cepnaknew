import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme.dart';

class DynamicButton extends ConsumerWidget {
  const DynamicButton(
      {super.key,
      this.title,
      this.icon,
      this.iconPosition = IconPosition.end,
      required this.onPressed,
      this.radius = 8,
      this.width = 100,
      this.height = 37,
      this.type = ButtonTypes.Secondary,
      this.isDisabled = false,
      this.style,
      this.fontSize});

  final String? title;
  final Widget? icon;
  final VoidCallback onPressed;
  final double radius;
  final double width;
  final double height;
  final ButtonTypes type;
  final IconPosition iconPosition;
  final bool isDisabled;
  final TextStyle? style;
  final double? fontSize;

  @override
  Widget build(BuildContext context, ref) {
    final colorProvider = ref.read(appColorLightProvider);
    return SizedBox(
      height: height.h,
      width: width.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          //fixedSize: Size(width, height),
          elevation: 4,
          backgroundColor:
              customButtonColor(colorProvider) ?? colorProvider.orangish,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: greyish.shade200,
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(radius),
              )),
        ),
        onPressed: isDisabled ? null : onPressed,
        child: title != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (iconPosition == IconPosition.start && icon != null) icon!,
                  if (iconPosition == IconPosition.start && icon != null)
                    SizedBox(width: 4.w),
                  Text(
                    title ?? '',
                    style: style ??
                        Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: fontSize,
                              fontWeight: FontWeight.w600,
                              color: type == ButtonTypes.Primary
                                  ? colorProvider.orangish
                                  : colorProvider.whiteish,
                            ),
                    textAlign: TextAlign.center,
                  ),
                  if (iconPosition == IconPosition.end && icon != null)
                    SizedBox(width: 4.w),
                  if (iconPosition == IconPosition.end && icon != null) icon!,
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Expanded(child: icon ?? const SizedBox())],
              ),
      ),
    );
  }

  Color? customButtonColor(AppColor colorProvider) {
    switch (type) {
      case ButtonTypes.Primary:
        return Colors.white;
      case ButtonTypes.Secondary:
        return colorProvider.orangish;
      case ButtonTypes.Success:
        return colorProvider.greenish.shade100;
      case ButtonTypes.Natural:
        return colorProvider.indigo;
      case ButtonTypes.Warning:
        return colorProvider.whiteish;
      case ButtonTypes.Danger:
        return colorProvider.redish;
      case ButtonTypes.Alternative:
        return colorProvider.blackish;
      case ButtonTypes.onPrimary:
        return colorProvider.whiteish;
    }
  }
}

enum ButtonTypes {
  Primary,
  Secondary,
  Success,
  Natural,
  Warning,
  Danger,
  Alternative,
  onPrimary,
}

enum IconPosition {
  end,
  start,
}
