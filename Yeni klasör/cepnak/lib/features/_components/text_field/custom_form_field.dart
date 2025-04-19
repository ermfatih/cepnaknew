import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/auth/register/register_view.dart';
import 'package:cepnak/product/constant/png_items.dart';
import 'package:cepnak/product/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomReactiveField<T> extends StatelessWidget {
  const CustomReactiveField({super.key, required this.formControlName, this.prefixIconName, this.label, this.textInputType, this.textEditingController, this.formControl,});
  final String formControlName;
  final PngItems? prefixIconName;
  final String? label;
  final TextInputType? textInputType;
  final TextEditingController? textEditingController;
  final FormControl<T>? formControl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      //height: 65.h,
      child: ReactiveTextField<T>(
        keyboardType: textInputType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.h),
          //isDense: true,
          counterText: ' ',
          prefixIcon:prefixIconName==null ? null:
          Padding(
            padding: EdgeInsets.all(10.h),
            child: MyIcon(name:prefixIconName! ),
          ),
          label: Text(label ?? '',style: context.myTextTheme.bodySmall),
        ),
        formControlName: formControlName,
        formControl: formControl,
        validationMessages:  {
          ValidationMessage.required:(error) =>notEmpty.i18n,
          ValidationMessage.equals:(error) => 'Geçerli bir numara giriniz'
          //ValidationMessage.email:(error) =>shouldEmail.i18n,
        },
      ),
    );
  }
}
