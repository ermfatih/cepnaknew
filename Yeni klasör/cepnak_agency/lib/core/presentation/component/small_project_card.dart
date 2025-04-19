/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shafak_donor/src/core/presentation/component/project_card_cached_network_image.dart';
import 'package:shafak_donor/theme.dart';

import '../widget/campaign_card_button.dart';

class SmallProjectCard extends ConsumerWidget {
  const SmallProjectCard(
      {super.key,
      required this.title,
      this.subtitle,
      this.onTapButton,
      this.buttonType,
      this.projectType,
      this.imageUrl});
  final String title;
  final String? subtitle;
  final void Function()? onTapButton;
  final ButtonType? buttonType;
  final String? projectType;
  final String? imageUrl;
  @override
  Widget build(BuildContext context, ref) {
    final themeColors = ref.read(appColorLightProvider);

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r))),
      color: themeColors.whiteish,
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: themeColors.greyish,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(12.r))),
              height: 80.h,
              width: 80.w,
              child: ProjectCachedNetworkImage(
                imageUrl: imageUrl,
                projectType: projectType,
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                            maxLines: 1),
                        if (subtitle != null)
                          Column(
                            children: [
                              SizedBox(height: 4.h),
                              Text(
                                subtitle!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontSize: 11),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  if (buttonType != null)
                    Visibility(
                        visible: buttonType != null,
                        child: CampaignCardButton(
                            appColor: themeColors,
                            buttonType: buttonType!,
                            onPressed: onTapButton)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/