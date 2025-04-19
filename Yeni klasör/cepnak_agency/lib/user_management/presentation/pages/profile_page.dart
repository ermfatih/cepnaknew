import 'dart:io';
import 'package:cepnak_agency/authentication/provider/auth_notifier.dart';
import 'package:cepnak_agency/core/presentation/widget/dynamic_button.dart';
import 'package:cepnak_agency/core/presentation/widget/dynamic_input.dart';
import 'package:cepnak_agency/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';
import '../../../core/presentation/component/profile_picture_widget.dart';

final userUpdateForm=Provider((ref){
  final agent=ref.read(authNotifierProvider).value?.agent;
  return FormGroup({
    'name':FormControl<String>(value:agent?.fullName ),
    'email':FormControl<String>(value:agent?.fullName),
    'phone':FormControl<String>(value:agent?.phone),
    'newPhone':FormControl<PhoneNumber>(),
    'switch':FormControl<bool>(value: false),
    'image':FormControl<ParseFileBase?>(value:agent?.logo),
  });
});


class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});
  static String get routeName => "profile";
  static String get routePath => "/$routeName";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agent=ref.read(authNotifierProvider).value?.agent;
    final textTheme=Theme.of(context).textTheme;
    final colors=ref.watch(appColorLightProvider);
    final form=ref.watch(userUpdateForm);
    return Container(
      margin: EdgeInsets.all(15.sp),
      child: SingleChildScrollView(
        child: ReactiveForm(
          formGroup:form ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Container(
                width: 1.sw,
                decoration: BoxDecoration(
                  color: colors.greyish.shade400,
                  borderRadius: BorderRadius.all(Radius.circular(16.r))
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: () {
                          ref.read(authNotifierProvider.notifier).logout();
                        }, icon: const Icon(Icons.logout_outlined)),
                        ReactiveSwitch(formControlName: 'switch',),
                      ],
                    ),
                    ReactiveFormConsumer(builder: (context, formGroup, child) {
                      bool value=formGroup.control('switch').value;
                      return  ProfilePictureWidget(
                        readOnly: !value,
                        imagUrl: form.control("image").value != null
                            ? (form.control("image").value as ParseFileBase).url
                            : null,
                        onChange: (image) async {
                          late ParseFileBase parseFile;
                          if (kIsWeb) {
                            parseFile = ParseWebFile(await image.readAsBytes(), name: "profile");
                          } else {
                            parseFile = ParseFile(File(image.path));
                          }
                          form.control("image").value = parseFile;
                        },
                      );
                    },),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      padding: EdgeInsets.symmetric(vertical: 6.h,horizontal: 20.w),
                        decoration: BoxDecoration(
                      color: colors.purpleish,
                      borderRadius: BorderRadius.all(Radius.circular(16.r))
                    ),child: Text(agent?.fullName ?? 'FullName'))
                  ],
                ),
              ),

              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: ReactiveFormConsumer(
                  builder: (context, formGroup, child) {
                    bool value=formGroup.control('switch').value;
                    return Column(
                      children: [
                        DynamicInput(readOnly: !value,placeholderIconPosition: IconPosition.end,placeholderIcon: const Icon(Icons.business),filled: false,radius: 3.r,title: 'Şirket Adı',placeholder: 'Company Name',control: 'name',type: Type.text,),
                        SizedBox(height: 10.h),
                        DynamicInput(readOnly: !value,placeholderIconPosition: IconPosition.end,placeholderIcon: const Icon(Icons.email),filled: false,radius: 3.r,title: 'Email',placeholder: 'Email',control: 'email',type: Type.text,),
                        SizedBox(height: 10.h),
                        !value
                            ?DynamicInput(readOnly: !value,placeholderIconPosition: IconPosition.end,placeholderIcon: const Icon(Icons.phone),filled: false,radius: 3.r,title: 'Telefon Numarası',placeholder: 'Phone',control: 'phone',type: Type.text)
                            :DynamicInput(readOnly: !value,placeholderIconPosition: IconPosition.end,placeholderIcon: const Icon(Icons.phone),filled: false,radius: 3.r,title: 'Telefon Numarası',placeholder: 'Phone',control: 'newPhone',type: Type.phoneNumber),
                        SizedBox(height: 10.h),
                      ],
                    );
                  },
                )
              ),
              ReactiveFormConsumer(builder: (context, formGroup, child) {
                bool value=formGroup.control('switch').value;
                return value?DynamicButton(
                    width: 200.w,
                    title: 'Kaydet',
                    type: ButtonTypes.Natural,
                    onPressed: ()async{
                      await ref.read(authNotifierProvider.notifier).updateUser(form, context);
                      ref.refresh(authNotifierProvider);
                      formGroup.control('switch').value=false;
                    }):const SizedBox.shrink();
              },)
            ],
          ),
        ),
      ),
    );
  }
}
