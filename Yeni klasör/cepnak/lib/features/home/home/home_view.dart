import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/pink_elevated_button.dart';
import 'package:cepnak/features/_components/dialog/agent_info_dialog.dart';
import 'package:cepnak/features/_components/dialog/destination_info_alert.dart';
import 'package:cepnak/features/_components/future_builder_items/custom_future_builder.dart';
import 'package:cepnak/features/home/freights/freights_model.dart';
import 'package:cepnak/features/home/freights/freights_view.dart';
import 'package:cepnak/features/home/home/home_view_model.dart';
import 'package:cepnak/product/constant/freights_states_list.dart';
import 'package:cepnak/product/constant/png_items.dart';
import 'package:cepnak/product/i18n/strings.g.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeViewModel _viewModel=Get.put(HomeViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Image.asset(PngItems.cepnaktext.pngPath,height: 50.h),actions: [
          Padding(
            padding: EdgeInsets.all(6.r),
            child: InkWell(onTap: () {
              NavigatorManager.instance.pushToPage(NavigatesRoutes.request);
            },child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(PngItems.request.pngPath,height: 20.h),
                Text(sendRequest.i18n,style: context.myTextTheme.bodySmall?.copyWith(fontSize: 8.sp,fontWeight: FontWeight.bold,color: Colors.black),)
              ],
            )),
          )
        ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: context.paddingLowHorizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FreightsRequestCount(text: 'Yeni Gelen İş Talepleri',onTap: () {
                  NavigatorManager.instance.pushToPage(NavigatesRoutes.tabs,arguments: 1);
                },),
                //FreightsRequestCount(text: 'Size Uygun İşlerin Sayısı',),
                //FreightsRequestCount(text: 'filtrenize göre işlerin sayısı',),
                Divider(),
                buildSizedBox(),
                CustomFutureBuilder<Freight?>(
                  future: _viewModel.getFreightContinue(),
                  dataWidget: (snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Devam Eden Yükünüz Var',style: context.myTextTheme.headlineMedium,),
                        buildSizedBox(),
                        FreightPosting(
                          agentName: snapshot.data?.agentId.name,
                          deliveryDate: snapshot.data?.deliveryDate,
                          price: snapshot.data?.price.toString(),
                          destinationName: snapshot.data?.destination?.address?.city,
                          sourceName: snapshot.data?.source?.address?.city,
                        ),
                        FrightsState(lastState: snapshot.data?.lastState ?? ''),
                        buildSizedBox(),
                        PinkElevatedButton(text: 'Yük Durumunu Güncelle',onPressed: () {
                          NavigatorManager.instance.pushToPage(NavigatesRoutes.freightsStateView);
                        },),
                        buildSizedBox(),
                        PinkElevatedButton(text: 'Acenta Bilgilerini Görüntüle',onPressed: () {
                          showDialog(context: context, builder: (context) {
                            return AgentInfoDialog(name: snapshot.data?.agentId.name,
                              phone: snapshot.data?.agentId.phone,);
                          },);
                        },),
                        buildSizedBox(),
                        PinkElevatedButton(text: 'Alıcı Bilgilerini Görüntüle',onPressed: () {
                          showDialog(context: context, builder: (context) {
                            return ReceiverInfoAlert(
                              phone: snapshot.data?.source?.phone1,
                              name: snapshot.data?.source?.name,
                              address: snapshot.data?.source?.address?.city,
                            );
                          },);
                        },),
                      ],
                    );
                  },
                  noDataWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Devam Eden Yükünüz Yok',style: context.myTextTheme.headlineMedium,),
                      buildSizedBox(),
                      PinkElevatedButton(text: 'Hadi İş Bulalım',onPressed: () {
                        NavigatorManager.instance.pushReplacement(NavigatesRoutes.tabs,arguments: 1);
                      },)
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
  SizedBox buildSizedBox() => SizedBox(height: 10.h,);
}

class FrightsState extends StatefulWidget {
  const FrightsState({super.key, required this.lastState,});
  final String lastState;

  @override
  State<FrightsState> createState() => _FrightsStateState();
}

class _FrightsStateState extends State<FrightsState> {
  int? selectedIndex;
  void setSelectedIndex()async{
    setState(() {
      selectedIndex=FreightsStatesConstant.stateList.indexWhere((element) => element==widget.lastState);
    });
  }
  @override
  void initState() {
    setSelectedIndex();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(color: Color(0xffECE3F0)),
      height: 110.h,
      width: 1.sw,
      child: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: PageController(viewportFraction: 0.28,initialPage: selectedIndex ?? 0),
        itemCount: FreightsStatesConstant.stateList.length,
        itemBuilder: (context, index) {
          var scale=selectedIndex==index ? 1.2 : 0.65;
          return TweenAnimationBuilder(
            tween: Tween(begin: scale,end: scale,),
            curve: Curves.bounceIn,
            duration:const Duration(seconds: 0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: scale,
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: PageViewItem(index: index,path: PngItems.wait.pngPath),
                ),
              );
            },
          );
      },)
    );
  }
}

class PageViewItem extends StatelessWidget {
  const PageViewItem({super.key, required this.path,required this.index});
  final String path;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 50.h,
          decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage(FreightsStatesConstant.stateListPng[index]),fit: BoxFit.contain),
          ),
        ),
        Text(FreightsStatesConstant.stateList[index],style: context.myTextTheme.bodyLarge!.copyWith(color: Colors.black),)
      ],
    );
  }
}
class FreightsRequestCount extends StatelessWidget {
  const FreightsRequestCount({super.key, required this.text, this.onTap,});
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            height: 32.h,
            width: 0.60.sw,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow:const [BoxShadow(color:Colors.black,blurRadius: 2,offset: Offset(0,1) )],
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(color: Color(0xffC4C4C4)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text +' :',style: context.myTextTheme.headlineSmall?.copyWith(fontSize: 15),),
                Text('23',style: context.myTextTheme.headlineSmall!.copyWith(color: Color(0xff12BF76)),),
              ],
            ),
          ),
          SizedBox(height: 32.h,width:0.28.sw,child: ElevatedButton(onPressed: () {}, child: Text('Görüntüle',style: context.myTextTheme.bodySmall!.copyWith(color:Colors.black),)))
        ],
      ),
    );
  }
}
