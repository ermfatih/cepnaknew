// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shafak_donor/src/authentication/provider/auth_notifier.dart';
// import 'package:shafak_donor/src/core/presentation/component/campaign_card_component.dart';
// import 'package:shafak_donor/src/core/presentation/component/project_card_cached_network_image.dart';
// import 'package:shafak_donor/src/core/presentation/component/project_card_list_tile.dart';
// import 'package:shafak_donor/theme.dart';

// import '../../../../../gen/assets.gen.dart';
// import '../widget/campaign_card_button.dart';

// class BigProjectCard extends ConsumerWidget {
//   const BigProjectCard({
//     super.key,
//     this.imageUrl,
//     required this.caseStatus,
//     required this.title,
//     required this.buttonType,
//     this.subtitle,
//     this.currentAmount,
//     this.targetAmount,
//     required this.projectType,
//     this.onTapCard,
//     this.onTapButton,
//   });
//   final String? imageUrl;
//   final String caseStatus;
//   final String title;
//   final String? subtitle;
//   final double? currentAmount;
//   final double? targetAmount;
//   final String projectType;
//   final void Function()? onTapCard;
//   final void Function()? onTapButton;
//   final ButtonType buttonType;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final themeColors = ref.read(appColorLightProvider);
//     // final currencySymbol = ref
//     //     .watch(authNotifierProvider)
//     //     .value
//     //     ?.donor
//     //     ?.bankInformation
//     //     ?.currencyType
//     //     ?.getSymbolByCurrencyType();

//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 5.h),
//       child: Card(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(24.r))),
//         elevation: 3,
//         color: themeColors.whiteish,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   SizedBox(
//                       height: 120.34.h,
//                       width: double.infinity,
//                       child: ProjectCachedNetworkImage(
//                         imageUrl: imageUrl,
//                         projectType: projectType,
//                         borderRadius: BorderRadius.all(Radius.circular(24.r)),
//                       )),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Align(
//                           alignment: Alignment.bottomLeft,
//                           child: Transform.scale(
//                             scale: 1.h,
//                             child: Assets.png.ornament
//                                 .image(width: 68.w, height: 51.h),
//                           )),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           buildContainer(caseStatus, context, themeColors),
//                           SizedBox(height: 5.h),
//                           buildContainer(projectType, context, themeColors),
//                         ],
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Visibility(
//               visible: targetAmount != null || currentAmount != null,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 child: Column(
//                   children: [
//                     LinearProgressIndicator(
//                       value: (currentAmount ?? 0) / (targetAmount ?? 0),
//                       color: themeColors.orangish,
//                       backgroundColor: themeColors.greyish,
//                     ),
//                     SizedBox(
//                       height: 2.h,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('$currencySymbol ${currentAmount.toString()}',
//                             style: Theme.of(context).textTheme.bodySmall),
//                         Text('$currencySymbol ${targetAmount.toString()}',
//                             style: Theme.of(context).textTheme.bodySmall),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 15),
//               child: ProjectCardListTile(
//                   onTapButton: onTapButton,
//                   color: themeColors,
//                   title: title,
//                   buttonType: buttonType,
//                   subtitle: subtitle,
//                   caseStatus: caseStatus),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
