import 'package:cepnak_agency/authentication/provider/auth_notifier.dart';
import 'package:cepnak_agency/home/application/providers.dart';
import 'package:cepnak_agency/home/presentation/component/custom_pie_chart.dart';
import 'package:cepnak_agency/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../freights_management/application/get_freights_provider.dart';



class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  static String get routeName => "home-page";
  static String get routePath => "/$routeName";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String id=ref.watch(authNotifierProvider).value?.agent?.objectId ??'';
    final colors=ref.watch(appColorLightProvider);
    final text=Theme.of(context).textTheme;
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ref.watch(getTotalValueProvider).when(data: (data) =>
                    GradientContainer(colors: colors,title: '$data TL',subtitle: 'Toplam Komisyon',iconData: Icons.money),
                    error: (error, stackTrace) => const Text('Hata'),
                    loading: () => GradientContainer(colors: colors,title: '',subtitle: '',iconData: Icons.money)),
                ref.watch(getTotalCarrierProvider).when(data: (data) =>
                    GradientContainer(colors: colors,title: data.toString(),subtitle: 'Toplam Şoför',iconData: Icons.fire_truck_rounded),
                  error: (error, stackTrace) =>const Text('data'), loading: () =>GradientContainer(colors: colors,title: '',subtitle: 'Total Carriers',iconData: Icons.fire_truck_rounded))
              ],
            ),
            SizedBox(height: 20.h),
            ref.watch(getFreightsForChart).when(data: (data) => const CustomPieChart(), error: (error, stackTrace) => Text('Error'), loading: () => Text('data')),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Onay Bekleyen Şoförler',
                style: text.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.greyish
                ),
              ),
            ),
            ref.watch(getWaitingCarriers).when(data: (data) {
              return SizedBox(
                height: 100.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: data?.length ??0,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 300.w,
                      child: Card(
                        color: colors.purpleish,
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 20.w),
                          minVerticalPadding: 30,
                          leading: const Icon(Icons.person,size: 30,),
                          title: Text(data?[index].carrierId.name ??''),
                          subtitle: Text(data?[index].carrierId.phoneNumber ??''),
                        ),
                      ),
                    );
                  },),
              );
            }, error: (error, stackTrace) =>const Text('hata'), loading: () => SizedBox(
              height: 100.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 300.w,
                    child: const Card(
                      child: ListTile(
                        minVerticalPadding: 30,
                        leading: Icon(Icons.add),
                        title: Text('Loading'),
                        subtitle: Text('Loading'),
                      ),
                    ),
                  );
                },),
            )),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Beklemede Olan Yükler',
                style: text.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.greyish
                ),
              ),
            ),
            ref.watch(getWaitingFreightsProvider).when(data: (data) {
              return SizedBox(
                height: 100.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: data?.length ??0,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 180.w,
                      child: Card(
                        color: colors.blueish,
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 20.w),
                          minVerticalPadding: 30,
                          //leading: const Icon(Icons.person,size: 30,),
                          title: Text(data?[index].name ??''),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(data?[index].source?.address?.city ??''),
                                  SizedBox(width: 10.w,),
                                  const Icon(Icons.arrow_forward),
                                  SizedBox(width: 10.w,),
                                  Text(data?[index].destination?.address?.city ??''),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Yük Tipi: '),
                                  Text(data?[index].cargoType ??''),
                                ],
                              ),
                            ],
                          ),

                        ),
                      ),
                    );
                  },),
              );
            }, error: (error, stackTrace) =>const Text('hata'), loading: () => SizedBox(
              height: 100.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 300.w,
                    child: const Card(
                      child: ListTile(
                        minVerticalPadding: 30,
                        leading: Icon(Icons.add),
                        title: Text('Loading'),
                        subtitle: Text('Loading'),
                      ),
                    ),
                  );
                },),
            )),
            SizedBox(height: 150.h)
          ],
        ),
      ),
    );
  }
}
/* */

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    super.key,
    required this.colors,
    this.title,
    this.subtitle,
    required this.iconData,
  });

  final AppColor colors;
  final String? title;
  final String? subtitle;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    final text=Theme.of(context).textTheme;
    return Container(
      height: 80.h,
      width: 160.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        gradient: LinearGradient(colors: [colors.greyish,colors.indigo,colors.blackish,],transform: const GradientRotation(50)),
      ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.ce,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title??'',style: text.headlineSmall?.copyWith(fontSize: 18.sp,color: colors.whiteish)),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(subtitle??'',style: text.bodyLarge?.copyWith(color: colors.whiteish)),
              SizedBox(width: 5.w),
              Icon(iconData,color: colors.whiteish,)
            ],
          ),
        ],
      ),
    );
  }
}


