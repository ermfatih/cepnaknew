import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../theme.dart';

class DropDownCurrencyWidget extends ConsumerWidget {
  const DropDownCurrencyWidget({
    super.key,
    required this.formControlName,
  });
  final String formControlName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Row(
              children: [
                Text(
                  'العملة'.i18n,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            )),
        SizedBox(
          height: 50,
          child: ReactiveDropdownField(
            validationMessages: {
              ValidationMessage.required: (error) => "يرجى إختيار العملة".i18n
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: appColor.whiteish,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.r),
                    borderSide: BorderSide(color: appColor.greyish)),
                counterStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(height: 1.42.sp),
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: appColor.blackish, height: 1.42.sp)),
            formControlName: formControlName,
            icon: Icon(
              Icons.arrow_drop_down,
              size: 5.sp,
            ),
            items: Currency.values
                .map((e) => DropdownMenuItem(
                      value: e.name,
                      child: Row(
                        children: [
                          // _getCurrecyIcon(e),
                          // SizedBox(
                          //   width: 5.w,
                          // ),
                          Text(
                            _getCurrecyName(e),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Text(
            "يرجى تحديد العملة التي تريد أستخدامها داخل التطبيق".i18n,
            style: Theme.of(context).textTheme.labelSmall,
            textDirection: TextDirection.rtl,
          ),
        )
      ],
    );
  }

  String _getCurrecyName(Currency currency) {
    switch (currency) {
      case Currency.TRY:
        return "الليرة التركية".i18n;
      case Currency.USD:
        return "الدولار الأمريكي".i18n;
      case Currency.Euro:
        return "اليورو الأوربي".i18n;
      case Currency.SYP:
        return "الليرة السورية".i18n;
    }
  }

  Widget _getCurrecyIcon(Currency currency) {
    switch (currency) {
      case Currency.TRY:
        return Image.asset(
          "assets/png/turckey.png",
          width: 30,
          height: 20,
          fit: BoxFit.fill,
        );
      case Currency.USD:
        return Image.asset("assets/png/usa.png",
            width: 20, height: 20, fit: BoxFit.fill);
      case Currency.Euro:
        return Image.asset("assets/png/europa.png",
            width: 20, height: 20, fit: BoxFit.fill);
      case Currency.SYP:
        return Image.asset("assets/png/sy.png",
            width: 20, height: 20, fit: BoxFit.fill);
    }
  }
}
enum Currency{TRY,USD,Euro,SYP}
