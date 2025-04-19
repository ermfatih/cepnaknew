/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shafak_donor/src/authentication/domain/beneficiary.dart';
import 'package:shafak_donor/theme.dart';

import '../widget/campaign_card_button.dart';

class ProjectCardListTile extends StatelessWidget {
  const ProjectCardListTile({
    super.key,
    required this.color,
    required this.title,
    this.subtitle,
    this.onTapButton,
    required this.caseStatus,
    required this.buttonType,
  });
  final AppColor color;
  final String title;
  final String? subtitle;
  final void Function()? onTapButton;
  final String caseStatus;
  final ButtonType buttonType;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500, color: color.blackish),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null) SizedBox(height: 2.w),
              if (subtitle != null)
                Text(
                  subtitle!,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 11.sp,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
        SizedBox(width: 20.w),
        CampaignCardButton(
            appColor: color, buttonType: buttonType, onPressed: onTapButton),
      ],
    );
  }
}

ButtonType getButtonType(String status, bool isApplicationCard) {
  if (AppStatus.inProgress.name == status) {
    return isApplicationCard ? ButtonType.applied : ButtonType.apply;
  } else if (AppStatus.acceptedInProgress.name == status) {
    return ButtonType.accepted;
  } else if (AppStatus.acceptedCompleted.name == status) {
    return ButtonType.completed;
  } else if (AppStatus.rejected.name == status) {
    return ButtonType.rejected;
  } else {
    return ButtonType.apply;
  }
}
*/