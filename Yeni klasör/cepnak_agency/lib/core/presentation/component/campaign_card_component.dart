// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shafak_donor/src/core/presentation/component/big_project_card.dart';
// import 'package:shafak_donor/src/core/presentation/component/project_card_list_tile.dart';
// import 'package:shafak_donor/src/core/presentation/component/small_project_card.dart';
// import 'package:shafak_donor/theme.dart';
// import '../widget/campaign_card_button.dart';

// class CampaignCard extends ConsumerWidget {
//   const CampaignCard(
//       {super.key,
//       this.isSmall = false,
//       this.imageUrl,
//       required this.caseStatus,
//       required this.title,
//       this.subtitle,
//       this.currentAmount,
//       this.targetAmount,
//       this.onTapCard,
//       this.onTapButton,
//       this.buttonType,
//       this.isApplicationCard = false,
//       required this.projectType});
//   final bool isSmall;
//   final String? imageUrl;
//   final String caseStatus;
//   final String title;
//   final String? subtitle;
//   final double? currentAmount;
//   final double? targetAmount;
//   final String projectType;
//   final void Function()? onTapCard;
//   final void Function()? onTapButton;
//   final ButtonType? buttonType;
//   final bool isApplicationCard;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

//     return SizedBox(
//       child: GestureDetector(
//         onTap: onTapCard,
//         child: isSmall
//             ? SmallProjectCard(
//                 title: title,
//                 subtitle: subtitle,
//                 onTapButton: onTapButton,
//                 buttonType: getButtonType(caseStatus, isApplicationCard),
//                 projectType: projectType,
//               )
//             : BigProjectCard(
//                 title: title,
//                 subtitle: subtitle,
//                 onTapButton: onTapButton,
//                 projectType: projectType,
//                 caseStatus: caseStatus,
//                 targetAmount: targetAmount,
//                 currentAmount: currentAmount,
//                 buttonType: getButtonType(caseStatus, isApplicationCard),
//                 onTapCard: onTapCard,
//                 imageUrl: imageUrl,
//               ),
//       ),
//     );
//   }
// }

// Container buildContainer(String text, BuildContext context, AppColor color) {
//   return Container(
//     // height: 20.h,
//     margin: EdgeInsets.only(right: 7.w),
//     padding: EdgeInsets.symmetric(horizontal: 10.h),
//     decoration: BoxDecoration(
//         color: color.whiteish,
//         borderRadius: BorderRadius.all(Radius.circular(10.r))),
//     child: Center(
//         child: Text(text,
//             style: Theme.of(context)
//                 .textTheme
//                 .labelSmall
//                 ?.copyWith(color: color.blackish))),
//   );
// }
