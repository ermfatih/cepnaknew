import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/drop_down/multi_selection_drop_down.dart';
import 'package:cepnak/features/_components/image_picker_reactive.dart';
import 'package:cepnak/features/_components/text_field/custom_form_field.dart';
import 'package:cepnak/features/_components/text_field/reactive_field_collapsed.dart';
import 'package:cepnak/features/home/car/car_model.dart';
import 'package:cepnak/features/home/car/car_update/car_update_view_model.dart';
import 'package:cepnak/features/home/car/car_view/car_view_model.dart';
import 'package:cepnak/product/constant/load_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CarUpdateView extends StatefulWidget {
  const CarUpdateView({super.key});
  @override
  State<CarUpdateView> createState() => _CarUpdateViewState();
}

class _CarUpdateViewState extends State<CarUpdateView> {
  final CarUpdateViewModel _carUpdateController=Get.put(CarUpdateViewModel());
  final carUpdate='Aracı Güncelle';
  final carPlate='Aracın Plakası';
  final cargoCapacity='Aracın Yük Taşıma Kapasitesi';
  final carProperties='Bu alana aracın özelliklerini giriniz';
  CarWithPictures? carWithPicture;
  final CarViewModel _carViewModel=Get.find();
  @override
  void initState() {
    super.initState();
    giveToValues();
  }

  giveToValues()async{
    carWithPicture=await _carUpdateController.getVehicle(_carViewModel.vehicleId.value);
    _carUpdateController.giveToFormValues(carWithPicture);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(carUpdate),),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingLowAll,
          child: ReactiveForm(
              formGroup: _carUpdateController.form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomReactiveField<String>(label: carPlate,formControlName: 'plate'),
                  CustomReactiveField(label: cargoCapacity,formControlName: 'capacity',textInputType: TextInputType.number),
                  CustomReactiveField(label: 'Yakıt Tüketimi',formControlName: 'fuelConsumption',),
                  buildSizedBox(),
                  Text(carProperties),
                  buildSizedBox(),
                  ReactiveFieldCollapsed(formControlName:'properties'),
                  buildSizedBox(),
                  CustomReactiveImage(),
                  buildSizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 0.43.sw,child: CustomReactiveDate(formControlName: 'registrationDate',label: 'Araç Kayıt Tarihi')),
                      SizedBox(width: 0.43.sw,child: CustomReactiveDate(formControlName: 'inspectionDate',label: 'Muayene Tarihi')),
                    ],),
                  MultiSelectionDropDown(formControlName: 'cargoSelections', label: 'Taşıyabileceği Yükler Seçimi', searchText: 'Yük Türü Arayın', items: LoadConstant.items),
                  Center(child: GreenElevatedButton(onPressed: (){
                    _carUpdateController.onPressedUpdate(_carViewModel.vehicleId.value);
                  },text: 'Güncelle',)),
                ],
              )
          )
        ),
      ),
    );
  }
  SizedBox buildSizedBox() => SizedBox(height: 10.h,);
}

class CustomReactiveDate extends StatelessWidget {
  const CustomReactiveDate({super.key, required this.formControlName, required this.label,});
  final String formControlName;
  final String label;
  @override
  Widget build(BuildContext context) {
    return ReactiveDateTimePicker(
      validationMessages: {
        ValidationMessage.required:(error) => 'Bu alan bırakılamaz'
      },
      formControlName: formControlName,
      type: ReactiveDatePickerFieldType.date,
      decoration: InputDecoration(
        //labelText: label,
        label: Text(label,style: context.myTextTheme.bodySmall),
        helperText: ' ',
        suffixIcon: Icon(Icons.calendar_today),
      ),
    );
  }
}


/*
*
*/