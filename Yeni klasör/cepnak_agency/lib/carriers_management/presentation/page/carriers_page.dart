import 'package:cepnak_agency/carriers_management/application/get_driver_request_provider.dart';
import 'package:cepnak_agency/carriers_management/presentation/component/update_carrier_status_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:segmented_button_slide/segmented_button_slide.dart';
import '../../../core/presentation/widget/dynamic_button.dart';
import '../../../core/presentation/widget/dynamic_input.dart';
import '../../../theme.dart';


final requestStatusForm=Provider((ref) {
  return FormGroup({
    'search':FormControl<String>(),
    'selectedEntry':FormControl<int>(value: 0),
  });
});
class CarriersPage extends ConsumerWidget {
  const CarriersPage({super.key});
  static String get routeName => 'carriers_page';
  static String get routeLocation => '/$routeName';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestForm=ref.watch(requestStatusForm);
    final colors=ref.read(appColorLightProvider);
    //String id=ref.watch(authNotifierProvider).value?.agent?.objectId ??'';
    final text=Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(15.sp),
      child: ReactiveForm(
        formGroup: requestForm,
        child: Column(
          children: [
            DynamicInput(
              autoFoucs: false, onchange: (p0) {
              ref.refresh(getRequestProvider);
            },radius: 15.r,placeholderIconPosition: IconPosition.end,placeholderIcon:const Icon(Icons.search),filled: false,control: 'search',placeholder: 'Ara'),
            CustomSlideButton(form: requestForm),
            Consumer(builder: (context, ref, child) {
              return ref.watch(getRequestProvider).when(data: (request) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: request?.length??0,
                  itemBuilder: (context, index) {
                    final url=request?[index].carrierId.profilePicture?.url;
                    final carrier=request?[index].carrierId;
                    return ReactiveFormConsumer(builder: (context, formGroup, child) {
                      int value=formGroup.control('selectedEntry').value;
                      return InkWell(
                        onTap: () {
                          UpdateCarrierDialog().showDialog(context,carrier,colors,ref,request?[index].objectId??'');
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            color:colors.blueish.shade100,
                            borderRadius: BorderRadius.all(Radius.circular(15.r)),),
                          child: ListTile(
                              titleTextStyle: text.headlineMedium,
                              subtitleTextStyle: text.bodyLarge,
                              leading:buildImageContainer(url, colors),
                              title: Text(carrier?.name??''),
                              subtitle:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Telefon:'),
                                  Text(carrier?.phoneNumber ?? ''),
                                ],
                              )
                          ),
                        ),
                      );
                    },);
                  },);
              }, error: (error, stackTrace) => throw Exception(error), loading: () => Center(child: CircularProgressIndicator(),),);
            },)
          ],
        ),
      ),
    );
  }
  Widget buildImageContainer(String? url,AppColor color){
    return Container(
      decoration: BoxDecoration(
        image: url !=null ?DecorationImage(fit: BoxFit.fill,image: Image.network(url).image):null,
        color: color.greyish,
        borderRadius: BorderRadius.all(Radius.circular(12.r))
      ),
        width: 60.w,height: 100.h);
  }
}

class CustomSlideButton extends ConsumerWidget {
  const CustomSlideButton({super.key,required this.form});
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
        SegmentedButtonSlideEntry( label: "Onaylanan"),
        SegmentedButtonSlideEntry( label: "Reddedilen"),
      ],
      selectedEntry: form.control('selectedEntry').value,
      onChange: (selected) {
        form.control('selectedEntry').value=selected;
        ref.refresh(getRequestProvider);
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
