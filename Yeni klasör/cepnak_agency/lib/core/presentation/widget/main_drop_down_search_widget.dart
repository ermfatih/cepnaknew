import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../theme.dart';

// ignore: must_be_immutable
class MainDropdownSearchWidget extends ConsumerWidget {
  MainDropdownSearchWidget(
      {Key? key,
        required this.formControlName,
        this.onSaved,
        this.placeholderIcon,
        this.popupPropsIsMenu,
        this.onDismissed,
        this.prefixIcon,
        this.radius = 12,
        this.textAlign,
        required this.placeholder,
        this.width = 325,
        this.height = 61,
        this.maxheight = 350,
        required this.item,
        this.search = true,
        this.validationMessages,
        this.border,
        this.title,
        this.readOnly = false,
        this.scale = 1,
        this.description,
        this.descriptionStartPadding,
        this.descriptionStyle,
        this.isPopUpDialog,
        this.itemBuilder})
      : super(key: key);
  final String formControlName;
  final Widget? placeholderIcon;
  final Map<String, String Function(Object)>? validationMessages;
  final double radius;
  final String placeholder;
  final List<String> item;
  final double? maxheight;
  final bool? search;
  final String? title;
  final double width;
  final double height;
  final bool readOnly;
  final Function(String?)? onSaved;
  final bool? popupPropsIsMenu;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  final void Function()? onDismissed;
  final InputBorder? border;
  final double? scale;
  final String? description;
  final double? descriptionStartPadding;
  final TextStyle? descriptionStyle;
  final bool? isPopUpDialog;
  Widget Function(BuildContext, String, bool)? itemBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorProvider = ref.read(appColorLightProvider);
    return Transform.scale(
        scale: scale,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 12.sp),
              ),
            SizedBox(height: 2.h),
            Container(
              constraints: BoxConstraints(maxHeight: height.h + 20.h),
              width: width,
              child: ReactiveDropdownSearch<String, String>(
                onSaved: onSaved,
                formControlName: formControlName,
                validationMessages: validationMessages ??
                    {
                      ValidationMessage.required: (error) => 'Required'.i18n,
                    },
                dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      prefixIcon: prefixIcon,
                      suffixIconColor: colorProvider.blackish,
                      hintText: placeholder,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(
                          fontSize: 11.sp,
                          color: colorProvider.greyish.shade100),
                      floatingLabelStyle: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(
                          fontSize: 12.sp,
                          color: colorProvider.greyish.shade100),

                      contentPadding: EdgeInsets.symmetric(
                          vertical: 5.0.h, horizontal: 10.w),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixStyle: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: colorProvider.blackish),
                      suffixIcon: placeholderIcon,
                      border: border ??
                          OutlineInputBorder(
                              borderSide:
                              BorderSide(color: colorProvider.blackish),
                              borderRadius:
                              BorderRadius.all(Radius.circular(radius))),
                      enabledBorder: border ??
                          OutlineInputBorder(
                              borderSide:
                              BorderSide(color: colorProvider.blackish),
                              borderRadius: BorderRadius.circular(
                                radius,
                              )),
                      focusedBorder: border ??
                          OutlineInputBorder(
                              borderSide:
                              BorderSide(color: colorProvider.blackish),
                              borderRadius: BorderRadius.circular(
                                radius,
                              )),
                      // fillColor: colorProvider.primaryLight,
                      filled: true,
                    ),
                    textAlign: textAlign),
                popupProps: isPopUpDialog == true
                    ? PopupProps.dialog(
                  fit: FlexFit.loose,
                  itemBuilder: itemBuilder,
                  containerBuilder: (context, popupWidget) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: popupWidget,
                      ),
                    );
                  },
                )
                    : (popupPropsIsMenu ?? false)
                    ? PopupProps.menu(
                    onDismissed: onDismissed,
                    showSearchBox: search ?? true,
                    searchFieldProps: TextFieldProps(
                      autofocus: true,
                      decoration: InputDecoration(
                        suffixStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                            color: colorProvider.greyish.shade100),
                        errorMaxLines: 1,
                        fillColor: colorProvider.whiteish,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0.h, horizontal: 10.w),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: colorProvider.whiteish),
                            borderRadius: BorderRadius.circular(
                              radius,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: colorProvider.blackish),
                            borderRadius: BorderRadius.circular(
                              radius,
                            )),
                        filled: true,
                        hintText: placeholder,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                            fontSize: 12.sp,
                            color: colorProvider.greyish.shade100),
                      ),
                    ),
                    menuProps: MenuProps(
                        backgroundColor: colorProvider.whiteish))
                    : PopupProps.bottomSheet(
                  onDismissed: onDismissed,
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    autofocus: true,
                    decoration: InputDecoration(
                      suffixStyle: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: colorProvider.blackish),
                      errorMaxLines: 1,
                      fillColor: colorProvider.whiteish,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 5.0.h, horizontal: 10.w),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: colorProvider.greyish),
                          borderRadius: BorderRadius.circular(
                            radius,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: colorProvider.blackish),
                          borderRadius: BorderRadius.circular(
                            radius,
                          )),
                      filled: true,
                      hintText: placeholder,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(
                          fontSize: 12.sp,
                          color: colorProvider.greyish.shade100),
                    ),
                  ),
                  bottomSheetProps: BottomSheetProps(
                    backgroundColor: colorProvider.whiteish,
                    constraints: const BoxConstraints(maxHeight: 300),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                  ),
                ),
                items: item,
                focusNode: FocusNode(),
                showClearButton: true,
                dropdownSearchTextStyle: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: colorProvider.orangish),
              ),
            ),
            description != null
                ? Padding(
              padding: EdgeInsetsDirectional.only(
                  top: 5.h, start: descriptionStartPadding ?? 0),
              child: Text(
                description ?? '',
                style: descriptionStyle ??
                    Theme.of(context).textTheme.labelSmall,
              ),
            )
                : const SizedBox()
          ],
        ));
  }
}
