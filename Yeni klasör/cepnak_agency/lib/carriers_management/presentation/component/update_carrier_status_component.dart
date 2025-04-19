import 'package:cepnak_agency/carriers_management/application/get_driver_request_provider.dart';
import 'package:cepnak_agency/carriers_management/application/update_carrier_status_provider.dart';
import 'package:cepnak_agency/carriers_management/domain/carrier_model.dart';
import 'package:cepnak_agency/core/presentation/widget/dynamic_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../theme.dart';

class UpdateCarrierDialog{
  Future<void> showDialog(BuildContext context,Carrier? carrier,AppColor color,WidgetRef ref,String requestId)async{
    showAdaptiveDialog(context: context, builder: (context) => AlertDialog(
      content: Container(
        width: 1.sw,
        height: 60.h,
        child: Column(
          children: [
            Text(carrier?.name ?? '',style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: color.greyish),),
            Text(carrier?.phoneNumber ?? '',style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: color.greyish),),
          ],
        ),
      ),
      actions: [
        DynamicButton(
          height: 25.h,
          type: ButtonTypes.Success,
          title: 'Accept',
            onPressed: ()async{
            await ref.read(acceptCarrierStatusProvider(requestId).future).then((value) {
              context.pop();
            });
            ref.refresh(getRequestProvider);
            }),
        DynamicButton(
          height: 25.h,
          type: ButtonTypes.Danger,
            title: 'Reject',
            onPressed: ()async{
              await ref.read(rejectCarrierStatusProvider(requestId).future).then((value) {
                context.pop();
              });
              ref.refresh(getRequestProvider);
          })
      ],
    ),);
  }
}