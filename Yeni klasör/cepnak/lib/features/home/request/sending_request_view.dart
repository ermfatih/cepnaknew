import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/future_builder_items/custom_future_builder.dart';
import 'package:cepnak/features/home/request/request_view_model.dart';
import 'package:cepnak/product/constant/request_states_list.dart';
import 'package:cepnak/product/models/request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class SendingRequestView extends StatefulWidget {
  const SendingRequestView({super.key});

  @override
  State<SendingRequestView> createState() => _SendingRequestViewState();
}

class _SendingRequestViewState extends State<SendingRequestView> {
  final RequestViewModel _requestViewModel=Get.find();
  @override
  void initState() {
    super.initState();
    _requestViewModel.onInit();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingLowAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            InfoText(color: Colors.green,text: 'Onaylanan talepler'),
            InfoText(color: Colors.blueGrey,text: 'Beklemede olan talepler'),
            InfoText(color: Colors.red,text: 'Reddedilen talepler'),
            SizedBox(height: 15.h,),
            Text('Tüm Talepler',style: context.myTextTheme.headlineMedium),
            CustomFutureBuilder(
              future: _requestViewModel.future,
              dataWidget: (snapshot) {
                return Column(
                  children: [
                    ...List.generate(snapshot.data?.length ?? 0, (index) => Column(
                      children: [
                        FutureBuilder(
                          future: _requestViewModel.getAgentById(snapshot.data?[index]?.agentId),
                          builder: (context, agentSnapshot) {
                            int ssq=RequestStatus.values.indexWhere((element) => snapshot.data?[index]?.requestState==element.name);
                            return Padding(
                              padding: context.paddingVeryLowVertical,
                              child: Container(
                                decoration: BoxDecoration(color:(ssq==0)? Colors.grey :(ssq==1)? Colors.green: Colors.red ,borderRadius: BorderRadius.circular(5.r)),
                                child: ListTile(
                                  leading: CircleAvatar(),
                                  title: Text(agentSnapshot.data?.name ?? ''),
                                  subtitle: Text(snapshot.data?[index]?.message ?? ''),
                                ),
                              ),
                            );
                          },
                        )
                      ],)
                    ),
                  ],
                );
              },
              noDataWidget: Container(height: 100.h,child: Text('Henüz hiç talep gönderilmemiş'),),
            )
          ]),
        ),
      ),
    );
  }
}
class InfoText extends StatelessWidget {

  InfoText({super.key, required this.color, required this.text,});
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingVeryLowVertical,
      child: Row(
        children: [
          Container(width: 25.h,height: 25.h,color: color,),
          SizedBox(width: 20.w,),
          Text(text,style: context.myTextTheme.headlineSmall,),

        ],),
    );
  }
}

