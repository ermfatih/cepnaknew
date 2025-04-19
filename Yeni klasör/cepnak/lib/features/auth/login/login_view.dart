import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/text_field/custom_form_field.dart';
import 'package:cepnak/features/auth/login/login_view_model.dart';
import 'package:cepnak/product/constant/png_items.dart';
import 'package:cepnak/product/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:reactive_forms/reactive_forms.dart';



class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _loginController=Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    _loginController.setContext(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingLowAll,
          child: ReactiveForm(
            formGroup:_loginController.form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h,),
                Image.asset(PngItems.carlogo.pngPath,width: context.myWidth*.5),
                Image.asset(PngItems.cepnaktext.pngPath,width: context.myWidth*.3),
                SizedBox(height: 20.h,),
                Text(welcome.i18n,style: context.myTextTheme.headlineLarge,),
                SizedBox(height: 20.h,),
                CustomReactiveField(

                  formControlName: 'phone',
                  prefixIconName: PngItems.phone,
                  textInputType: TextInputType.phone,
                  label: phoneNumber.i18n,
                ),
                GreenElevatedButton(text: buttonText.i18n, onPressed:_loginController.onPressed),
              ],
            )
          ),
        ),
      ),
    );
  }

}
