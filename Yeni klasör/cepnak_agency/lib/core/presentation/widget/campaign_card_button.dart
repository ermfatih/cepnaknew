/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:shafak_donor/theme.dart';

import '../../../../../gen/assets.gen.dart';


enum ButtonType { applied, accepted, completed, apply, rejected }

class CampaignCardButton extends StatelessWidget {
  const CampaignCardButton({
    super.key,
    required this.buttonType,
    this.onPressed,
    required this.appColor,
  });
  final AppColor appColor;
  final ButtonType buttonType;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButtonTheme(
      data: ElevatedButtonThemeData(
          style: ButtonStyle(
              padding: const MaterialStatePropertyAll(EdgeInsets.zero),
              backgroundColor: buttonType == ButtonType.accepted
                  ? MaterialStatePropertyAll(appColor.whiteish)
                  : buttonType == ButtonType.completed
                      ? MaterialStatePropertyAll(appColor.greenish)
                      : MaterialStatePropertyAll(appColor.orangish))),
      child: SizedBox(
          height: 30.h,
          child: buttonType == ButtonType.completed ||
                  buttonType == ButtonType.applied
              ? ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      elevation: 0,
                      backgroundColor: buttonType == ButtonType.applied
                          ? appColor.orangish
                          : appColor.orangish,
                      foregroundColor: appColor.orangish),
                  icon: buttonType == ButtonType.applied
                      ? Assets.png.like.image(width: 10.67.w, height: 9.62.h)
                      : Assets.png.completed.image(),
                  onPressed: onPressed,
                  label: Text(
                    buttonType == ButtonType.completed
                        ? 'Completed'.i18n
                        : 'Applied'.i18n,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: appColor.whiteish),
                  ))
              : ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    side: BorderSide(width: 1, color: appColor.orangish),
                    backgroundColor: appColor.orangish,
                    foregroundColor: appColor.orangish,
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                  ),
                  child: Text(
                    buttonType == ButtonType.accepted
                        ? 'Accepted'.i18n
                        : 'Apply'.i18n,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: buttonType == ButtonType.accepted
                            ? appColor.orangish
                            : appColor.whiteish),
                  ))),
    );
  }
}
*/