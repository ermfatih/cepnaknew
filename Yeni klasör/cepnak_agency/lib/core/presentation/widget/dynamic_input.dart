// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';
import '../../../theme.dart';
import 'dynamic_button.dart';

class ToggleState extends StateNotifier<bool> {
  ToggleState() : super(true);

  void toggle() {
    state = !state;
  }
}

final toggleProvider =
StateNotifierProvider<ToggleState, bool>((ref) => ToggleState());

enum Type {
  text,
  number,
  double,
  phoneNumber,
  date,
}

class DynamicInput extends ConsumerWidget {
  DynamicInput(
      {super.key,
        this.title,
        this.placeholderIcon,
        this.placeholderIconPosition = IconPosition.start,
        this.iconPosition = IconPosition.end,
        this.radius = 12,
        this.width = 1,
        this.height = 40,
        this.titleIcon,
        this.filled,
        this.titleIconPosition = IconPosition.start,
        required this.placeholder,
        this.description,
        this.control,
        this.numreicFormat,
        this.dateFormat,
        this.multiLine = false,
        this.type = Type.text,
        this.obscure = false,
        this.textInputAction = TextInputAction.next,
        this.crossAxisAlignment,
        this.autoFoucs = true,
        this.onchange,
        this.validationMessages,
        this.fieldType = "تكون كلمة المرور",
        this.lastDate,
        this.firstDate,
        this.readOnly = false,
        this.onTap,
        this.scale = 1,
        this.enabledBorder,
        this.placeHolderStyle,
        this.prefixIcon,
        this.descriptionStartPadding,
        this.descriptionStyle,
        this.removeTopPadding,
        this.showClearIconForDate,
        this.fillColor,
        this.inputFormatters});
  final double? scale;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String fieldType;
  final String? control;
  final String? title;
  final Widget? titleIcon;
  final Widget? placeholderIcon;
  final Map<String, String Function(Object)>? validationMessages;
  final double radius;
  final double width;
  final double height;
  final IconPosition titleIconPosition;
  final IconPosition placeholderIconPosition;
  final String placeholder;
  final String? description;
  final TextStyle? descriptionStyle;
  final double? descriptionStartPadding;
  final intl.NumberFormat? numreicFormat;
  final intl.DateFormat? dateFormat;
  final bool? multiLine;
  final Type type;
  final IconPosition iconPosition;
  final bool obscure;
  final TextInputAction? textInputAction;
  final CrossAxisAlignment? crossAxisAlignment;
  final void Function(FormControl<Object?>)? onchange;
  final bool autoFoucs;
  final bool readOnly;
  final void Function()? onTap;
  final InputBorder? enabledBorder;
  final TextStyle? placeHolderStyle;
  final Widget? prefixIcon;
  final bool? removeTopPadding;
  final bool? showClearIconForDate;
  final bool? filled;
  final Color? fillColor;
  List<TextInputFormatter>? inputFormatters;

  // PhoneNumberInputValidator? _getValidator() {
  //   List<PhoneNumberInputValidator> validators = [];
  //   validators.add(PhoneValidator.validMobile());
  //   validators.add(PhoneValidator.valid());
  //   return validators.isNotEmpty ? PhoneValidator.compose(validators) : null;
  // }

  final phoneKey = GlobalKey<FormFieldState<PhoneNumber>>();

  @override
  Widget build(BuildContext context, ref) {
    final colorProvider = ref.read(appColorLightProvider);
    return SizedBox(
      width: width.sw,
      child: Transform.scale(
          scale: scale,
          child: ReactiveFormConsumer(
            builder:
                (BuildContext context, FormGroup formGroup, Widget? child) {
              bool enable = ref.watch(toggleProvider);

              return Column(
                crossAxisAlignment:
                crossAxisAlignment ?? CrossAxisAlignment.start,
                children: [
                  removeTopPadding == true
                      ? Container()
                      : Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Row(
                        children: [
                          if (titleIconPosition == IconPosition.start &&
                              titleIcon != null)
                            titleIcon!,
                          Text(
                            title ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(fontSize: 12.sp),
                          ),
                          if (titleIconPosition == IconPosition.end &&
                              titleIcon != null)
                            titleIcon!,
                        ],
                      )),
                  type == Type.phoneNumber
                      ? Directionality(
                      textDirection: TextDirection.ltr,
                      child: ReactivePhoneFormField<PhoneNumber>(
                        countryCodeStyle: const TextStyle(),
                        defaultCountry: IsoCode.TR,
                        formControlName: control,
                        readOnly: readOnly,
                        enabled: false,
                        decoration: InputDecoration(
                            errorMaxLines: 1,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(radius),
                                )),
                            filled: filled??true,
                            fillColor: fillColor,
                            hintText: placeholder,
                            hintStyle: placeHolderStyle ??
                                Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                    color: colorProvider
                                        .greyish.shade100)),
                        cursorColor:
                        Theme.of(context).colorScheme.onPrimary,
                        //cursorHeight: 30.h,
                      ))
                      : type == Type.date
                      ? ReactiveDateTimePicker(
                    showClearIcon: showClearIconForDate ?? true,
                    validationMessages: validationMessages,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: colorProvider.blackish),
                    formControlName: control,
                    lastDate: lastDate,
                    firstDate: firstDate,
                    decoration: InputDecoration(
                      prefixIcon: prefixIcon,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0.w, horizontal: 10.h),
                      hintText:
                      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                      hintStyle: placeHolderStyle ??
                          Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                              color: colorProvider.greyish),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: colorProvider.orangish),
                          borderRadius: BorderRadius.all(
                            Radius.circular(radius),
                          )),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer),
                          borderRadius: BorderRadius.all(
                              Radius.circular(radius))),
                      filled: filled??true,
                      fillColor: fillColor,
                    ),
                  )
                      : InkWell(
                    onTap: onTap,
                    child: ReactiveTextField(
                      inputFormatters: inputFormatters,
                      onChanged: onchange,
                      autofocus: autoFoucs,
                      readOnly: readOnly,
                      cursorColor:
                      Theme.of(context).colorScheme.onPrimary,
                      cursorHeight: 17.h,
                      maxLines: multiLine == true ? 5 : 1,
                      style: Theme.of(context).textTheme.labelSmall,
                      formControlName: control,
                      keyboardType: type == Type.text
                          ? TextInputType.text
                          : TextInputType.number,
                      obscureText: obscure ? enable : false,
                      decoration: InputDecoration(
                          hintText: placeholder,
                          hintStyle: placeHolderStyle ??
                              Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                  color: colorProvider
                                      .greyish.shade100),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          floatingLabelBehavior:
                          FloatingLabelBehavior.never,
                          suffixIcon: placeholderIconPosition ==
                              IconPosition.start
                              ? placeholderIcon
                              : null,
                          prefixIcon: prefixIcon ??
                              (placeholderIconPosition ==
                                  IconPosition.end
                                  ? obscure
                                  ? GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(
                                        toggleProvider
                                            .notifier)
                                        .state =
                                    !ref
                                        .read(
                                        toggleProvider
                                            .notifier)
                                        .state;
                                  },
                                  child: enable
                                      ? const Icon(
                                      Icons.visibility)
                                      : const Icon(Icons
                                      .visibility_off))
                                  : placeholderIcon
                                  : null),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: colorProvider.orangish),
                              borderRadius: BorderRadius.all(
                                Radius.circular(radius),
                              )),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: colorProvider.redish),
                              borderRadius: BorderRadius.all(
                                Radius.circular(radius),
                              )),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onError),
                              borderRadius:
                              BorderRadius.all(Radius.circular(radius))),
                          filled: filled?? true,
                          fillColor: fillColor,
                          enabledBorder: enabledBorder),
                      validationMessages: validationMessages ??
                          {
                            ValidationMessage.required: (error) =>
                            'Please enter this field'.i18n,
                            ValidationMessage.mustMatch: (error) =>
                            'Password and confirmation must match'
                                .i18n,
                            ValidationMessage.minLength: (error) =>
                            '$fieldType must be more than 3 characters long'
                                .i18n,
                            ValidationMessage.email: (error) =>
                            'Please enter a valid email address',
                          },
                      textInputAction: textInputAction,
                      textAlign: TextAlign.start,
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
              );
            },
          )),
    );
  }
}
