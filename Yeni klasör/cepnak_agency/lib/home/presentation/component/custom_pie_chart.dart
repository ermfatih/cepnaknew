import 'package:cepnak_agency/home/application/providers.dart';
import 'package:cepnak_agency/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circle_chart/flutter_circle_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import '../../../freights_management/domain/freight.dart';

class CustomPieChart extends ConsumerWidget {
  const CustomPieChart({super.key,this.list});
  final List<Freight>? list;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text=Theme.of(context).textTheme;
    final colors=ref.watch(appColorLightProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Yük Tipleri',
              style: text.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.greyish
              ),
            ),
          ),
          ref.watch(getFreightsForChart).when(data:(data) {
            List<CargoTypeData> cargoTypeDataList = [];
            for (Freight freight in data??[]) {
              String cargoType = freight.cargoType ?? freight.objectId!;
              String lastState=freight.lastState??'';
              var existingData = cargoTypeDataList.firstWhere((data) => data.cargoType == cargoType, orElse: () => CargoTypeData(lastState: lastState,cargoType: cargoType, count: 0));
              if (existingData.count == 0) {
                cargoTypeDataList.add(CargoTypeData(cargoType: cargoType, count: 1,lastState:lastState ));
              } else {
                existingData.count++;
              }
            }
            return CircleChart(
              animationOnItemsChanged: true,
              chartType: CircleChartType.bracelet,
              items: List.generate(cargoTypeDataList.length, (index) {

                  return CircleChartItemData(
                    color: randomColor(),
                    value: cargoTypeDataList[index].count.toDouble(),//cargoTypeCounts['Sıvı']?.toDouble() ??0,
                    name: cargoTypeDataList[index].cargoType,//cargoTypeCounts.keys.toList()[index],
                    description: cargoTypeDataList[index].lastState//cargoTypeCounts.keys.toList()[index],
                  );
              }
              ),
            );
          }, error: (error, stackTrace) => const Text('Error'), loading: () => const Text('data'),)
        ],
      ),
    );
  }
}
Color randomColor() {
  var g = math.Random.secure().nextInt(255);
  var b = math.Random.secure().nextInt(255);
  var r = math.Random.secure().nextInt(255);
  return Color.fromARGB(255, r, g, b);
}

class CargoTypeData {
  final String cargoType;
  int count;
  final String lastState;

  CargoTypeData({required this.cargoType, required this.count,required this.lastState});
}
