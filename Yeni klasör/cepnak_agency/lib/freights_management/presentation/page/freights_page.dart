import 'package:cepnak_agency/authentication/provider/auth_notifier.dart';
import 'package:cepnak_agency/core/presentation/widget/dynamic_button.dart';
import 'package:cepnak_agency/core/presentation/widget/dynamic_input.dart';
import 'package:cepnak_agency/freights_management/application/get_freights_provider.dart';
import 'package:cepnak_agency/freights_management/presentation/page/create_field_form_page.dart';
import 'package:cepnak_agency/freights_management/presentation/widget/freight_card.dart';
import 'package:cepnak_agency/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:segmented_button_slide/segmented_button_slide.dart';


final freightsFilterForm=Provider((ref) {
  return FormGroup({
    'search':FormControl<String>(),
    'selectedEntry':FormControl<int>(value: 0),
  });
});
class FreightsPage extends ConsumerWidget {
  const FreightsPage({super.key});
  static String get routeName => "freights-page";
  static String get routePath => "/$routeName";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterForm=ref.watch(freightsFilterForm);
    final colors=ref.read(appColorLightProvider);
    //String id=ref.watch(authNotifierProvider).value?.agent?.objectId ??'';
    return Container(
      padding: EdgeInsets.all(15.sp),
      child: ReactiveForm(
        formGroup: filterForm,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DynamicInput(onchange: (p0) {
                    ref.refresh(getFreightsProvider);
                  },width: 0.6,autoFoucs: false,radius: 15.r,placeholderIconPosition: IconPosition.end,placeholderIcon:const Icon(Icons.search),filled: false,control: 'search',placeholder: 'Ara'),
                  DynamicButton(
                      height: 25.h,
                      radius: 12.r,
                      title: 'İş Oluştur',
                      type: ButtonTypes.Natural,
                      onPressed: (){
                        context.pushNamed(CreateFreightFormField.routeName);
                      })
                ],
              ),
              CustomFreightSlideButton(form: filterForm),
              Consumer(builder: (context, ref, child) {
                return ref.watch(getFreightsProvider).when(data: (freights) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: freights?.length??0,
                    itemBuilder: (context, index) {
                    return FreightCard(freight: freights?[index]);
                  },);
                }, error: (error, stackTrace) => Text('error'), loading: () => Center(child: CircularProgressIndicator(),),);
              },)
            ],
          ),
        ),
      ),
    );
  }
}
class CustomFreightSlideButton extends ConsumerWidget {
  const CustomFreightSlideButton({super.key,required this.form});
  final FormGroup form;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color=ref.watch(appColorLightProvider);
    return ReactiveFormConsumer(
      builder: (context, formGroup, child) => SegmentedButtonSlide(
        animationDuration:const Duration(milliseconds: 350),
        curve: Curves.easeInBack,
        entries: const [
          SegmentedButtonSlideEntry(label: "Bekleyen"),
          SegmentedButtonSlideEntry( label: "Yolda"),
          SegmentedButtonSlideEntry( label: "Tamamlanan"),
        ],
        selectedEntry: form.control('selectedEntry').value,
        onChange: (selected) {
          form.control('selectedEntry').value=selected;
          ref.refresh(getFreightsProvider);
        },
        colors: SegmentedButtonSlideColors(
            barColor: color.greyish.shade500.withOpacity(0.2),
            backgroundSelectedColor: color.indigo,
            foregroundSelectedColor: color.whiteish,
            foregroundUnselectedColor: color.indigo,
            hoverColor: color.indigo
        ),
        slideShadow: [
          BoxShadow(
              color: color.greyish,
              blurRadius: 5,
              spreadRadius: 1
          )
        ],
        margin: EdgeInsets.symmetric(vertical: 10.h),
        height: 30.h,
      ),);
  }
}


