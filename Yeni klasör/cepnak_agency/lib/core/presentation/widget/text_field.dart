import 'package:cepnak_agency/core/application/string_extension.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:flutter/material.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';
import '../../../../../theme.dart';

class MainTextFieldWidget extends ConsumerWidget {
  MainTextFieldWidget( {
    super.key,
    this.urlList,
    this.fillColor,
    this.placeholderIcon,
    this.radius = 10,
    this.width = 335,
    this.height = 38,
    required this.placeholder,
    this.control,
    this.multiLine = false,
    this.type = Type.text,
    this.obscure = false,
    this.textInputAction = TextInputAction.next,
    this.autoFoucs = false,
    this.isDisabled = false,
    this.onchange,
    this.validationMessages,
    this.readOnly = false,
    this.keyboardType,
    this.style,
    this.isRequired = false,
    this.inputFormatters,
    this.suffixIcon,
    this.prefixIcon,
    this.reactiveDatePickerFieldType = ReactiveDatePickerFieldType.date,
    this.onSubmitted,
    this.focusNode,
    this.dropDownIdList,
    this.border,
  });
  final String? control;

  final Widget? placeholderIcon;
  final Map<String, String Function(Object)>? validationMessages;
  final double radius;
  final double width;
  final double height;
  final String placeholder;
  final bool? multiLine;
  final Type type;
  final bool obscure;
  final TextInputAction? textInputAction;
  final void Function(FormControl)? onchange;
  final bool autoFoucs;
  final bool readOnly;
  final phoneKey = GlobalKey<FormFieldState<PhoneNumber>>();
  final TextInputType? keyboardType;
  final bool isDisabled;
  final TextStyle? style;
  final bool isRequired;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ReactiveDatePickerFieldType reactiveDatePickerFieldType;
  final void Function(FormControl<dynamic>)? onSubmitted;
  final FocusNode? focusNode;
  final List<String>? urlList;
  final List<String>? dropDownIdList;
  final Color? fillColor;
  final InputBorder? border;
  @override
  Widget build(BuildContext context, ref) {
    final colorProvider = ref.read(appColorLightProvider);

    return SizedBox(
      //padding: EdgeInsets.only(top: 10.h),
      // constraints: BoxConstraints(maxHeight: height.h + 20.h),
        height:height,
        width: width,
        child:urlList==null? ReactiveFormConsumer(
          builder: (BuildContext context, FormGroup formGroup, Widget? child) {
            bool enable = ref.watch(toggleProvider);
            return ReactiveTextField(
              readOnly: readOnly,
              onChanged: onchange,
              autofocus: autoFoucs,
              focusNode:focusNode ,
              onSubmitted: onSubmitted,
              inputFormatters: inputFormatters,
              maxLines: multiLine == true ? 4 : 1,
              style: style ?? Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: colorProvider.greyish,
                  ),
              formControlName: control,
              keyboardType: keyboardType ??
                  (type == Type.text
                      ? TextInputType.text
                      : TextInputType.number),
              decoration: InputDecoration(
                prefixIcon:prefixIcon,
                errorStyle: const TextStyle(
                    height: 0.05,
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                    fontSize: 10),
                isDense: true,
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                hintText: placeholder,
                hintStyle:
                Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: colorProvider.blackish,
                  height: enable
                      ? null
                      : multiLine == true
                      ? 4
                      : 1,
                ),
                contentPadding:const EdgeInsets.all(12),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0,color: colorProvider.greyish),
                    borderRadius: BorderRadius.circular(
                      radius,
                    )),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0,color: colorProvider.redish),
                    borderRadius: BorderRadius.circular(
                      radius,
                    )),
                enabledBorder:border?? OutlineInputBorder(
                    borderSide: BorderSide(width: 0,color: colorProvider.greyish),
                    borderRadius: BorderRadius.circular(
                      radius,
                    )),
                focusedBorder:border?? OutlineInputBorder(
                    borderSide: BorderSide(width: 0,color: colorProvider.greyish),
                    borderRadius: BorderRadius.circular(radius,)),
                fillColor: fillColor ??Colors.grey[200],
                filled: true,
              ),
              validationMessages: validationMessages ??
                  {
                    ValidationMessage.required: (error) =>
                    "required".i18n,
                  },
              textInputAction: textInputAction,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
            );
          },
        ):ReactiveDropdownField(
          validationMessages: validationMessages ??
              {
                ValidationMessage.required: (error) =>
                "required".i18n,
              },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            filled: true,
            fillColor: Colors.white,
            hintText: placeholder,
            hintStyle: Theme.of(context).textTheme.labelSmall,
            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
            errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 0,color: colorProvider.redish), borderRadius: BorderRadius.circular(radius)),
            enabledBorder: OutlineInputBorder(borderSide:const BorderSide(), borderRadius: BorderRadius.circular(radius,)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: colorProvider.greyish), borderRadius: BorderRadius.circular(radius)),
          ),
          formControlName: control,
          focusNode: focusNode,
          items: List.generate(urlList?.length ??0, (index) => DropdownMenuItem(value: dropDownIdList?[index],child: Text(urlList?[index].truncate(12) ??'',style: Theme.of(context).textTheme.labelSmall,))),
        ));
  }
}

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