/*import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/home/freights/freights_view_model.dart';
import 'package:cepnak/features/home/freights_filter/widgets/filter_slider.dart';
import 'package:cepnak/features/home/freights_filter/widgets/filter_tonnage.dart';
import 'package:cepnak/features/home/freights_filter/widgets/reactive_date_filter.dart';
import 'package:cepnak/features/home/freights_filter/widgets/reactive_time_filter.dart';
import 'package:cepnak/product/constant/cities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../_components/drop_down/multi_selection_drop_down.dart';

class FreightsFilterView extends StatefulWidget {
  const FreightsFilterView({super.key});
  @override
  State<FreightsFilterView> createState() => _FreightsFilterViewState();
}

class _FreightsFilterViewState extends State<FreightsFilterView> with SingleTickerProviderStateMixin{
  final FreightsViewModel _viewModel=Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Taşıma Seçenekleri'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingLowAll,
          child: ReactiveForm(
            formGroup: _viewModel.form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(context,'Yükleme konumunun şu anki bulunduğun konuma maximum uzaklığı'),
                ReactiveFilterSlider(formControlName: 'sliderNow'),
                buildText(context, 'Yükleme-Boşaltma konumları arasındaki minimum mesafe'),
                ReactiveFilterSlider(formControlName: 'sliderMin'),
                buildText(context, 'Yükleme-Boşaltma konumları arasındaki maksimum mesafe'),
                ReactiveFilterSlider(formControlName: 'sliderMax'),
                FilterTonnage(formControlName: 'minTonnage',text: 'En az yük tonajı'),
                FilterTonnage(formControlName: 'maxTonnage',text: 'En fazla yük tonajı'),
                buildSizedBox(),
                MultiSelectionDropDown(formControlName: 'menuMultiple',searchText: 'Şehir İsmini Yazınız',label: 'Taşıma İllerini Seçiniz',items: CityConstant.city),
                buildSizedBox(),
                buildText(context, 'Bir Tarih Aralığı Seçin'),
                buildSizedBox(),
                ReactiveDateFilter(formControlName: 'date'),
                buildSizedBox(),
                buildText(context, 'Saat aralıkları seçin'),
                buildSizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReactiveTimeFilter(formControlName: 'timeFirst',label: 'Başlangıç '),
                    ReactiveTimeFilter(formControlName: 'timeSecond',label: 'Bitiş',)
                  ],
                ),
                buildSizedBox(),
                Center(child: GreenElevatedButton(text: 'Filtreleri Sıfırla',onPressed: _viewModel.resetFilter,color: Color(0xff72AFD3),)),
                buildSizedBox(),
                Center(child: GreenElevatedButton(text: 'Değişiklikleri Kaydet',onPressed: _viewModel.saveChanges,)),
              ],
            ),
          ),
        ),
      ),
    );
  }
  SizedBox buildSizedBox() =>  SizedBox(height: 10.h,);
  Text buildText(BuildContext context,String text) => Text(text,style: context.myTextTheme.headlineSmall,);
}



*/