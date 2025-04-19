/*import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:i18n_extension/default.i18n.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shafak_donor/src/core/application/string_extension.dart';
import '../../../../../theme.dart';

class DocumentDropDownWidget extends ConsumerWidget {
    const DocumentDropDownWidget( {
    super.key,
    this.urlList,
    this.placeholderIcon,
    this.radius = 10,
    this.width = 335,
    this.height = 38,
    required this.placeholder,
    this.control,
    this.validationMessages,
    this.dropDownIdList,
  });
  final String? control;
  final Widget? placeholderIcon;
  final Map<String, String Function(Object)>? validationMessages;
  final double radius;
  final double width;
  final double height;
  final String placeholder;
  final List<String>? urlList;
  final List<String>? dropDownIdList;
  @override
  Widget build(BuildContext context, ref) {
    final colorProvider = ref.read(appColorLightProvider);
    return SizedBox(
      height:height,
      width: width,
      child: ReactiveFormConsumer(
        builder: (BuildContext context, FormGroup formGroup, Widget? child) {
          return ReactiveDropdownField(
            validationMessages: validationMessages ??
                {
                  ValidationMessage.required: (error) =>
                  "required".i18n,
                },
            dropdownColor: colorProvider.whiteish,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              filled: true,
              fillColor: Colors.white,
              hintText: placeholder,
              hintStyle: Theme.of(context).textTheme.labelSmall,
              errorStyle:const TextStyle(fontSize: 3),
              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
              errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 0,color: colorProvider.redish), borderRadius: BorderRadius.circular(radius)),
              enabledBorder: OutlineInputBorder(borderSide:const BorderSide(), borderRadius: BorderRadius.circular(radius,)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: colorProvider.greyish), borderRadius: BorderRadius.circular(radius)),
            ),
            formControlName: control,
            focusNode: FocusNode(),
            items: List.generate(urlList?.length ??0, (index) => DropdownMenuItem(value: dropDownIdList?[index],child: Text(urlList?[index].truncate(12) ??'',style: Theme.of(context).textTheme.labelSmall,))),
          );
        },
      ));
  }
}


*/