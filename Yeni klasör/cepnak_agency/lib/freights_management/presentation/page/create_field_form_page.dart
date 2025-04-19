import 'package:cepnak_agency/core/presentation/widget/dynamic_button.dart';
import 'package:cepnak_agency/core/presentation/widget/dynamic_input.dart';
import 'package:cepnak_agency/core/presentation/widget/main_drop_down_search_widget.dart';
import 'package:cepnak_agency/freights_management/application/create_freight_provider.dart';
import 'package:cepnak_agency/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../core/domain/countries_cities_list.dart';
import '../../application/freight_form.dart';
import '../component/google_maps_component.dart';
class LoadConstant{
  static List<String> items=[
    'Sıvı',
    'Dökme Yük',
    'Ev Eşyası',
    'Ahşap',
    'Mobilya',
    'Endüstriyel',
    'Kimyasal',
    'Elektronik',
    'Hassas'
  ];
}

class CreateFreightFormField extends ConsumerWidget {
  const CreateFreightFormField({super.key});
  static String get routeName => 'freight_form_page';
  static String get routeLocation => '$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color=ref.read(appColorLightProvider);
    final form=ref.watch(createFreightForm);
    return ReactiveForm(
      formGroup: form,
      child: Container(
        margin: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: color.purpleish,
          borderRadius: BorderRadius.all(Radius.circular(5.r))
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bigText('Freight Name', context),
              DynamicInput(fillColor: color.whiteish,filled: true,placeholder: 'Freight Name',control: 'name'),
              buildSizedBox(),
              bigText('Cargo Type ', context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MainDropdownSearchWidget(width: 0.4.sw,isPopUpDialog: true,search: false,formControlName: 'cargoType', placeholder: 'type', item:LoadConstant.items),
                  DynamicInput(width: 0.4,fillColor: color.whiteish,filled: true,placeholder: 'Weight',control: 'weight',type: Type.number,),
                ],
              ),
              buildSizedBox(),
              bigText('Distance', context),
              DynamicInput(fillColor: color.whiteish,filled: true,placeholder: 'Distance/ Km',control: 'distance',type: Type.double,),
              buildSizedBox(),
              bigText('Date ', context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DynamicInput(title: 'Start',width: 0.4,type: Type.date,fillColor: color.whiteish,filled: true,placeholder: 'Freight Name',control: 'startDate'),
                  const Icon(Icons.arrow_forward),
                  DynamicInput(title: 'End',width: 0.4,type: Type.date,fillColor: color.whiteish,filled: true,placeholder: 'Freight Name',control: 'deliveryDate'),
                ],
              ),
              buildSizedBox(),
              bigText('Price', context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DynamicInput(title: 'Price',width: 0.4,type: Type.double,fillColor: color.whiteish,filled: true,placeholder: 'Freight Price',control: 'price'),
                  DynamicInput(title: 'Commission',width: 0.4,type: Type.double,fillColor: color.whiteish,filled: true,placeholder: 'Freight Commission',control: 'commission'),
                ],
              ),
              buildSizedBox(),
              bigText('Location', context),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
                  color: color.greyish
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final location = ref.watch(sourceLocationProvider);
                        if (location != null) {
                          form.control("source.locationText").value = "(${location.latitude},${location.longitude})";
                          form.control("source.location").value = ParseGeoPoint(latitude: location.latitude, longitude: location.longitude);
                          return DynamicInput(
                            type: Type.text,
                            control: 'source.locationText',
                            placeholder: 'example@email.com',
                            title: "Source Location",
                            height: 40.h,
                            readOnly: true,
                            placeholderIcon: TextButton(
                              child: Text('Click',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                      fontSize: 12.sp, color: color.orangish)),
                              onPressed: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.zero,
                                        content: SizedBox(
                                          height: 500.h,
                                          width: 400.w,
                                          child: GoogleMapsComponent(
                                            isDestination: false,
                                              latitude: location.latitude,
                                              longitude: location.longitude),
                                        ),
                                      );
                                    });
                              },
                            ),
                          );
                        } else {
                          return DynamicInput(
                            type: Type.text,
                            control: 'source.locationText',
                            placeholder: 'example@email.com',
                            title: "Location",
                            height: 40.h,
                            readOnly: false,
                          );
                        }
                      },
                    ),
                    MainDropdownSearchWidget(
                      popupPropsIsMenu: true,
                      width: 1.sw,
                      title: "Country",
                      formControlName: "source.address.country",
                      placeholderIcon: Container(
                        padding: EdgeInsets.all(10.r),
                      ),
                      placeholder: "Select your country",
                      item: countriesCitiesList.keys
                          .map(
                            (key) => key,
                      )
                          .toList(),
                    ),
                    ReactiveFormConsumer(
                      builder: (context, formGroup, child) =>
                          MainDropdownSearchWidget(
                            popupPropsIsMenu: true,
                            width: 1.sw,
                            title: "City",
                            formControlName: "source.address.city",
                            placeholderIcon: Container(
                              padding: EdgeInsets.all(10.r),
                              child: const Icon(Icons.map),
                            ),
                            placeholder: "Select your city",
                            item: formGroup.control("source.address.country").value != null
                                ? countriesCitiesList[
                            formGroup.control("source.address.country").value] ??
                                []
                                : [],
                          ),
                    ),
                    SizedBox(height: 5.h),
                    DynamicInput(
                      title: "District",
                      placeholderIcon: Container(
                        padding: EdgeInsets.all(10.r),
                        child: const Icon(Icons.map),
                      ),
                      placeholder: "Insert your district",
                      control: 'source.address.district',
                    ),
                    SizedBox(height: 5.h),
                    DynamicInput(
                      title: "Description",
                      placeholderIcon: Container(
                        padding: EdgeInsets.all(10.r),
                        child: const Icon(Icons.map),
                      ),
                      placeholder: "Insert your description",
                      control: 'source.address.description',
                    ),
                    DynamicInput(
                      title: "People Name",
                      placeholder: "Insert your Source People Name",
                      control: 'source.name',
                    ),
                    DynamicInput(
                      type: Type.phoneNumber,
                      title: "People Number",
                      placeholder: "5550000000",
                      control: 'source.phone1',
                    ),
                  ],
                ),
              ),
              buildSizedBox(),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.r)),
                    color: color.orangish
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final location = ref.watch(destinationLocationProvider);
                        if (location != null) {
                          form.control("destination.locationText").value = "(${location.latitude},${location.longitude})";
                          form.control("destination.location").value = ParseGeoPoint(latitude: location.latitude, longitude: location.longitude);
                          return DynamicInput(
                            type: Type.text,
                            control: 'destination.locationText',
                            placeholder: 'example@email.com',
                            title: "Destination Location",
                            height: 40.h,
                            readOnly: true,
                            placeholderIcon: TextButton(
                              child: Text('Click',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                      fontSize: 12.sp, color: color.orangish)),
                              onPressed: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.zero,
                                        content: SizedBox(
                                          height: 500.h,
                                          width: 400.w,
                                          child: GoogleMapsComponent(
                                              isDestination: true,
                                              latitude: location.latitude,
                                              longitude: location.longitude),
                                        ),
                                      );
                                    });
                              },
                            ),
                          );
                        } else {
                          return DynamicInput(
                            type: Type.text,
                            control: 'destination.locationText',
                            placeholder: 'example@email.com',
                            title: "Location",
                            height: 40.h,
                            readOnly: false,
                          );
                        }
                      },
                    ),
                    MainDropdownSearchWidget(
                      popupPropsIsMenu: true,
                      width: 1.sw,
                      title: "Country",
                      formControlName: "destination.address.country",
                      placeholderIcon: Container(
                        padding: EdgeInsets.all(10.r),
                      ),
                      placeholder: "Select your country",
                      item: countriesCitiesList.keys
                          .map(
                            (key) => key,
                      )
                          .toList(),
                    ),
                    ReactiveFormConsumer(
                      builder: (context, formGroup, child) =>
                          MainDropdownSearchWidget(
                            popupPropsIsMenu: true,
                            width: 1.sw,
                            title: "City",
                            formControlName: "destination.address.city",
                            placeholderIcon: Container(
                              padding: EdgeInsets.all(10.r),
                              child: const Icon(Icons.map),
                            ),
                            placeholder: "Select your city",
                            item: formGroup.control("destination.address.country").value != null
                                ? countriesCitiesList[
                            formGroup.control("destination.address.country").value] ??
                                []
                                : [],
                          ),
                    ),
                    SizedBox(height: 5.h),
                    DynamicInput(
                      title: "District",
                      placeholderIcon: Container(
                        padding: EdgeInsets.all(10.r),
                        child: const Icon(Icons.map),
                      ),
                      placeholder: "Insert your district",
                      control: 'destination.address.district',
                    ),
                    SizedBox(height: 5.h),
                    DynamicInput(
                      title: "Description",
                      placeholderIcon: Container(
                        padding: EdgeInsets.all(10.r),
                        child: const Icon(Icons.map),
                      ),
                      placeholder: "Insert your description",
                      control: 'destination.address.description',
                    ),
                    DynamicInput(
                      title: "People Name",
                      placeholder: "Insert your Destination People Name",
                      control: 'destination.name',
                    ),
                    DynamicInput(
                      type: Type.phoneNumber,
                      title: "People Number",
                      placeholder: "5550000000",
                      control: 'destination.phone1',
                    ),
                  ],
                ),
              ),
              buildSizedBox(),
              Align(
                alignment: Alignment.center,
                child: DynamicButton(
                    width: 200.w,
                    type: ButtonTypes.Natural,
                    title: 'Create Freight',
                    onPressed: () async{
                      await ref.read(createFreightProvider.future).then((value) {
                        context.pop();
                      });
                    }),
              ),
              SizedBox(height: 150.h,)
            ],
          ),
        ),
      ),
    );
  }
  bigText(String text,BuildContext context){
    return Text(text,style: Theme.of(context).textTheme.headlineLarge?.copyWith(
      fontWeight: FontWeight.bold
    ));
  }
  buildSizedBox(){
    return SizedBox(height: 20.h);
  }
}
