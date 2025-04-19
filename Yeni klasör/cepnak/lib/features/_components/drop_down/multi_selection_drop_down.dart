import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MultiSelectionDropDown extends StatelessWidget {
  const MultiSelectionDropDown({super.key, required this.formControlName, required this.label, required this.searchText, required this.items,});
  final String formControlName;
  final String label;
  final String searchText;
  final List<String> items;
  @override
  Widget build(BuildContext context) {
    return ReactiveDropdownSearchMultiSelection<String, String>(
      validationMessages: {
        ValidationMessage.required:(error) => 'Bu alan boş bırakılamaz'
      },
      formControlName: formControlName,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            labelText: label,
            helperText: ' ',
            filled: true,
            fillColor:const Color(0xffF0EBEB)
        ),
      ),
      popupProps: PopupPropsMultiSelection.menu(
        searchFieldProps: TextFieldProps(decoration: InputDecoration(
          prefixIcon:const Icon(Icons.search),
          hintText: searchText,
        )),
        showSelectedItems: true,
        showSearchBox: true,
      ),
      items: items,
      showClearButton: true,
    );
  }
}
