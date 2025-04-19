import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/home/car/car_model.dart';
import 'package:cepnak/features/home/car/car_service.dart';
import 'package:cepnak/features/home/car/car_view/car_view_model.dart';
import 'package:cepnak/features/home/profile/profile_view.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class CarView extends StatefulWidget {
  const CarView({super.key});

  @override
  State<CarView> createState() => _CarViewState();
}

class _CarViewState extends State<CarView> {
  CarService _service=CarService();
  final _carViewModel=Get.put(CarViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Araçlarım')),
      body: Padding(
        padding: context.paddingLowAll,
        child: RefreshIndicator(
          onRefresh: ()async {
            setState(() {});
          },
          child: FutureBuilder(
            future: _service.getCarrierByCurrentUser(),
            builder: (context, carrier) {
              return FutureBuilder<List<Vehicle>>(
                  future:_carViewModel.getVehicles(carrier.data?.objectId ??''),
                  builder: (context, snapshot) {
                    if(snapshot.data==null || snapshot.hasData==false){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 500.h,
                          child: ListView.builder(
                            shrinkWrap: false,
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  CarListTile(carName: snapshot.data?[index].plate ?? 'null',onTap:()async {
                                    _carViewModel.vehicleId.value=await snapshot.data![index].objectId!;
                                    NavigatorManager.instance.pushToPage(NavigatesRoutes.carUpdate);
                                  },),
                                ],
                              );
                            },),
                        ),
                        GreenElevatedButton(onPressed: () {
                          NavigatorManager.instance.pushToPage(NavigatesRoutes.carAddView);
                        },text: 'Araç Ekle',)
                      ],
                    );
                  }
              );
            },
          ),
        ),
      ),
    );
  }
}
class CarListTile extends StatelessWidget {
  const CarListTile({super.key, required this.carName, this.onTap,});
  final String carName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      height: 60.h,
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(carName),
          GestureDetector(child: Icon(Icons.update),onTap:onTap ,),
          Icon(Icons.delete),
        ],
      ),
    );
  }
}
