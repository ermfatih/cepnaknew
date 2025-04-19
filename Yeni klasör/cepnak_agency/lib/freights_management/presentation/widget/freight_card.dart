import 'package:cepnak_agency/core/application/date_utils.dart';
import 'package:cepnak_agency/core/application/string_extension.dart';
import 'package:cepnak_agency/freights_management/domain/freight.dart';
import 'package:cepnak_agency/freights_management/presentation/component/freight_map_component.dart';
import 'package:cepnak_agency/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FreightCard extends ConsumerStatefulWidget {
  const FreightCard({super.key,required this.freight});
  final Freight? freight;
  @override
  ConsumerState createState() => _FreightCardState();
}

class _FreightCardState extends ConsumerState<FreightCard> {
  bool isBig=false;
  @override
  Widget build(BuildContext context) {
    final text=Theme.of(context).textTheme;
    final color=ref.watch(appColorLightProvider);
    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: 5.h),
      duration: const Duration(seconds: 1),
      //width: 1.sw,
      //height: isBig ? 300:100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
          color: color.greyish.shade300
      ),
      //height: 50.h,
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.all(5),
               decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r),topRight: Radius.circular(15.r)),
                color: color.greyish.shade300
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(margin: EdgeInsets.symmetric(horizontal: 5.w),padding: EdgeInsets.all(10.sp),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.r)),color: color.whiteish),child: Text(widget.freight?.name ??''),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.freight?.source?.address?.city ??''),
                    SizedBox(width: 30.w,),
                    const Icon(Icons.arrow_forward),
                    SizedBox(width: 30.w),
                    Text(widget.freight?.destination?.address?.city ??''),
                  ],
                ),
                TextButton.icon(
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white)),
                    icon: const Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      setState(() {
                        isBig=!isBig;
                      });
                    }, label:const Text('Detay'))
              ],
            ),
          ),
          Visibility(visible: isBig,child: FreightMapComponent(latitude: widget.freight?.source?.location?.latitude ??0, longitude: widget.freight?.source?.location?.longitude ??0, isDestination: false, latitudeDestination: widget.freight?.destination?.location?.latitude ??0, longitudeDestination: widget.freight?.destination?.location?.latitude ??0)),
          Visibility(
            visible: isBig,
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  border: Border.all()
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('Sender'),
                      Card(
                        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.r))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(widget.freight?.source?.name??''),
                              Text(widget.freight?.source?.phone1??''),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.arrow_forward),
                  Column(
                    children: [
                      const Text('Receiver'),
                      Card(
                        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.r))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(widget.freight?.destination?.name??''),
                              Text(widget.freight?.destination?.phone1??''),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            //margin: EdgeInsets.all(5),
            //height: 150.h,
            decoration: BoxDecoration(
              color: color.greyish.shade300,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.r),bottomRight: Radius.circular(15.r)),
            ),
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
                border: Border.all()
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 180.w,child: ListTile(leading: const Icon(Icons.add),title: Text(widget.freight?.cargoType ?? ''),)),
                      SizedBox(width: 180.w,child: ListTile(leading: const Icon(Icons.fire_truck_sharp),title: Text(widget.freight?.weight.toString()  ?? ''),)),
                      SizedBox(width: 210.w,child: ListTile(leading: const Icon(Icons.date_range),title: Row(
                        children: [
                          Text(dateFormat(widget.freight?.deliveryDate),style: text.bodySmall),
                          const Icon(Icons.remove),
                          Text(dateFormat(widget.freight?.startDate),style: text.bodySmall),
                        ],
                      ),)),
                    ],
                  ),
                  Column(
                    children: [
                      Card(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text((widget.freight?.lastState ??'').truncate(15),style: text.bodySmall,),
                      )),
                      buildImageContainer(widget.freight?.carrierId?.profilePicture?.url, color),
                      Text(widget.freight?.carrierId?.name ??'')
                    ],
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isBig,
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  border: Border.all()
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('Price'),
                      Card(
                        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.r))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.freight?.price.toString()??''),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Commission'),
                      Card(
                        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.r))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.freight?.commission.toString()??''),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

        ],
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
        width: 80.w,height: 80.h);
  }
}

