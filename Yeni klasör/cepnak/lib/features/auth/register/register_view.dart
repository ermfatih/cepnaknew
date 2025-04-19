import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/blue_text_button.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/text_field/custom_form_field.dart';
import 'package:cepnak/features/auth/register/register_view_model.dart';
import 'package:cepnak/product/constant/cities.dart';
import 'package:cepnak/product/constant/png_items.dart';
import 'package:cepnak/product/i18n/strings.g.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}
class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _registerController=Get.put(RegisterViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: context.paddingLowAll,
            child: ReactiveForm(
              formGroup: _registerController.form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 110.h,),
                  Text(createAccount.i18n,style: context.myTheme.textTheme.headlineLarge,),
                  SizedBox(height: 30.h,),
                  CustomReactiveField(formControlName: 'name',prefixIconName:PngItems.man,label: name.i18n),
                  buildSizedBox(),
                  CustomReactiveField(formControlName: 'phone',prefixIconName:PngItems.phone,label:phoneNumber.i18n,textInputType: TextInputType.number),
                  buildSizedBox(),
                  const DropDownSearchCustom(formControlName: 'menu'),
                  buildSizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(haveAccount.i18n,style: context.myTextTheme.headlineSmall,),
                      BlueTextButton(text: login.i18n,onPressed: () {
                        NavigatorManager.instance.pushReplacement(NavigatesRoutes.login);
                      },),
                    ],
                  ),
                  Center(child: GreenElevatedButton(text: createAccount.i18n,onPressed:_registerController.onPressed,)),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

  SizedBox buildSizedBox() => SizedBox(height: 5.h,);
}

class DropDownSearchCustom extends StatelessWidget {
  const DropDownSearchCustom({super.key, required this.formControlName,});
  final String formControlName;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: ReactiveDropdownSearch<String,String>(
        validationMessages: {
          ValidationMessage.required:(error) => notEmpty.i18n
        },
        dropdownButtonProps:const DropdownButtonProps(icon: MyIcon(name: PngItems.down,)),
        formControlName: formControlName,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.h),
            counterText:' ',
            //isCollapsed: true,
            labelText: selectCity.i18n,
            labelStyle: context.myTextTheme.bodySmall,
            prefixIcon: Padding(
              padding: EdgeInsets.all(10.h),
              child: MyIcon(name: PngItems.map),
            ),

          ),
        ),
        popupProps:PopupProps.menu(
          showSelectedItems: true,
          showSearchBox: true,
          searchFieldProps: TextFieldProps(decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: searchCity.i18n
          ))
        ),
        items: CityConstant.city,
      ),
    );
  }
}

class MyIcon extends StatelessWidget {
  const MyIcon({super.key, required this.name });
  final PngItems name;
  @override
  Widget build(BuildContext context) {
    return Image.asset(name.pngPath,height: 20.h,width: 20.w,);
  }
}