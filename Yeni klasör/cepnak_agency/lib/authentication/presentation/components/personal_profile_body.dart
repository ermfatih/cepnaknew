import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../theme.dart';
import '../../../core/domain/countries_cities_list.dart';
import '../../../core/presentation/component/profile_picture_widget.dart';
import '../../../core/presentation/widget/dynamic_button.dart';
import '../../../core/presentation/widget/dynamic_input.dart';
import '../../../core/presentation/widget/main_drop_down_search_widget.dart';
import '../../application/image_file_provider.dart';
import '../../application/register_form_provider.dart';
import '../../domain/agent.dart';
import '../../provider/auth_notifier.dart';

class CreatePersonalProfileBody extends ConsumerWidget {
  const CreatePersonalProfileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    FormGroup form = ref.watch(registerFormProvider);
    ref.watch(imageFileProvider);
    final appColor = ref.watch(appColorLightProvider);
    return Column(
      children: [
        ProfilePictureWidget(
          isProfile: true,
          imagUrl: form.control("image").value != null
              ? (form.control("image").value as ParseFileBase).url
              : null,
          onChange: (image) async {
            late ParseFileBase parseFile;

            if (kIsWeb) {
              parseFile =
                  ParseWebFile(await image.readAsBytes(), name: "profile");
            } else {
              parseFile = ParseFile(File(image.path));
            }
            form.control("image").value = parseFile;
          },
        ),
        DynamicInput(
          control: 'fullname',
          placeholder: "",
          title: "Full Name".i18n,
          fieldType: "full Name",
          height: 40.h,
          width: 1.sw,
        ),
        SizedBox(height: 10.h),
        DynamicInput(
          control: 'userName',
          placeholder: "",
          title: "User Name".i18n,
          fieldType: "user Name",
          height: 40.h,
          width: 1.sw,
        ),
        SizedBox(height: 10.h),
        if (form.control("isEmail").value)
          DynamicInput(
            type: Type.phoneNumber,
            control: 'phone',
            placeholder: '905XXXXXXXX',
            title: "Phone Number".i18n,
            height: 40.h,
          ),
        SizedBox(height: 10.h),
        if (!form.control("isEmail").value)
          DynamicInput(
            type: Type.text,
            control: 'email',
            placeholder: 'example@email.com',
            title: "email".i18n,
            height: 40.h,
          ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ReactiveRadioListTile(
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
                contentPadding: EdgeInsets.zero,
                activeColor: appColor.blackish,
                formControlName: "gender",
                value: Gender.male,
                title: Text(
                  "Male".i18n,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: ReactiveRadioListTile(
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
                contentPadding: EdgeInsets.zero,
                formControlName: "gender",
                activeColor: appColor.blackish,
                value: Gender.female,
                title: Text(
                  "Female".i18n,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        DynamicInput(
          type: Type.date,
          control: 'birthdate',
          placeholder: "",
          title: "Birth Date".i18n,
          height: 40.h,
        ),
        SizedBox(height: 10.h),
        MainDropdownSearchWidget(
          width: 1.sw,
          title: "Country".i18n,
          formControlName: "address.country",
          placeholderIcon: Container(
            padding: EdgeInsets.all(10.r),
          ),
          placeholder: "Country".i18n,
          item: countriesCitiesList.keys
              .map(
                (key) => key,
              )
              .toList(),
        ),
        SizedBox(
          height: 15.h,
        ),
        ReactiveFormConsumer(
          builder: (context, formGroup, child) => MainDropdownSearchWidget(
            width: 1.sw,
            title: "City".i18n,
            formControlName: "address.city",
            placeholderIcon: Container(
              padding: EdgeInsets.all(10.r),
              child: SvgPicture.asset(
                "assets/svg/Buildings.svg",
                fit: BoxFit.fill,
              ),
            ),
            placeholder: "City".i18n,
            item: formGroup.control("address.country").value != null
                ? countriesCitiesList[
                        formGroup.control("address.country").value] ??
                    []
                : [],
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        DynamicInput(
          title: "District".i18n,
          placeholderIcon: Container(
            padding: EdgeInsets.all(20.r),
            child: SvgPicture.asset(
              "assets/svg/map.svg",
              fit: BoxFit.fill,
            ),
          ),
          placeholder: "District".i18n,
          control: 'address.district',
        ),
        SizedBox(height: 19.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ReactiveCheckbox(
              fillColor: MaterialStatePropertyAll(appColor.whiteish),
              formControlName: "agreement",
            ),
            Expanded(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'I agree to all '.i18n,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: appColor.blackish)),
                  TextSpan(
                      text: 'Terms and Conditions'.i18n,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: appColor.blackish,
                            decoration: TextDecoration.underline,
                          )),
                  TextSpan(
                      text: ' and '.i18n,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: appColor.blackish)),
                  TextSpan(
                      text: 'privacy policy'.i18n,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: appColor.blackish,
                            decoration: TextDecoration.underline,
                          )),
                ]),
              ),
            ),
          ],
        ),
        SizedBox(height: 5.h),
        InkWell(
            onTap: () {
              // context.pushNamed(PolicyPage.routeName,
              //     pathParameters: {"path": "PDP"});
            },
            child: Text("View the privacy policy".i18n,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: appColor.orangish,
                    decoration: TextDecoration.underline,
                    decorationColor: appColor.orangish))),
        SizedBox(height: 20.h),
        ReactiveFormConsumer(builder:
            (BuildContext context, FormGroup formGroup, Widget? child) {
          return DynamicButton(
            height: 40.h,
            width: 300.w,
            title: 'Create account'.i18n,
            onPressed: () async {
              await ref
                  .read(authNotifierProvider.notifier)
                  .createAccount(form)
                  .then((value) {
                if (value) {}
              });
            },
            isDisabled: formGroup.valid ? false : true,
          );
        }),
        SizedBox(
          height: 19.h,
        ),
      ],
    );
  }
}
