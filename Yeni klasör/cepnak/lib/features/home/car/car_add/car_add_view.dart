import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/drop_down/multi_selection_drop_down.dart';
import 'package:cepnak/features/_components/image_picker_reactive.dart';
import 'package:cepnak/features/_components/text_field/custom_form_field.dart';
import 'package:cepnak/features/_components/text_field/reactive_field_collapsed.dart';
import 'package:cepnak/features/home/car/car_add/car_add_view_model.dart';
import 'package:cepnak/features/home/car/car_update/car_update_view.dart';
import 'package:cepnak/product/constant/load_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CarAddView extends StatefulWidget {
  const CarAddView({super.key});

  @override
  State<CarAddView> createState() => _CarAddViewState();
}

class _CarAddViewState extends State<CarAddView> {
  final carDetail='Araç Detayları';
  final carPlate='Aracın Plakası';
  final cargoCapacity='Aracın Yük Taşıma Kapasitesi';
  final carProperties='Bu alana aracın özelliklerini giriniz';
  final _controller=Get.put(CarAddViewModel());

  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Araç Ekle'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingLowAll,
          child: ReactiveForm(
            formGroup: _controller.form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomReactiveField(label: carPlate,formControlName: 'plate'),
                CustomReactiveField(label: cargoCapacity,textInputType: TextInputType.number,formControlName: 'capacity'),
                SizedBox(height: 10.h,),
                Text(carProperties),
                SizedBox(height: 10.h,),
                ReactiveFieldCollapsed(formControlName: 'properties' ),
                SizedBox(height: 10.h,),
                CustomReactiveField(label: 'Yakıt Tüketimi',formControlName: 'fuelConsumption',textInputType: TextInputType.number),
                SizedBox(height: 10.h,),
                CustomReactiveImage(),
                SizedBox(height: 10.h,),
                CustomReactiveDate(formControlName: 'registrationDate',label: 'Araç Kayıt Tarihi'),
                CustomReactiveDate(formControlName: 'inspectionDate',label: 'Muayene Tarihi'),
                MultiSelectionDropDown(formControlName: 'cargoSelections', label: 'Taşıyabileceği Yükler Seçimi', searchText: 'Yük Türü Arayın', items: LoadConstant.items),
                Center(child: GreenElevatedButton(onPressed: _controller.onPressedAdd,text: 'Araç Ekle',))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
