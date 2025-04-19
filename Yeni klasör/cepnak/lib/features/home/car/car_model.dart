import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

//final DateTime? registrationDate;
//final DateTime? inspectionDate;
//
//final String? type;
//final String? color;
//final bool? openTruck;
//final Object? documents;
//final Object? locations;
//
class Vehicle{
  final String? objectId;
  final String plate;
  final DateTime? registrationDate;
  final DateTime? inspectionDate;
  final double? fuelConsumption;
  final String properties;
  final double? capacity;
  List<dynamic> cargoSelections;

  Vehicle( {required this.registrationDate, required this.inspectionDate, required this.cargoSelections,required this.plate, required this.fuelConsumption,required this.properties,required this.capacity, this.objectId});


  factory Vehicle.fromParseObject(ParseObject? parseObject) {
    return Vehicle(
      plate: parseObject?.get<String>('plate') ?? '',
      registrationDate: parseObject?.get<DateTime>('registrationDate'),
      inspectionDate: parseObject?.get<DateTime>('inspectionDate'),
      fuelConsumption: double.tryParse(parseObject?.get('fuelConsumption').toString() ?? 0.toString()),
      properties: parseObject?.get<String>('properties') ?? '',
      capacity: double.tryParse(parseObject?.get('capacity').toString() ?? 0.toString()),
      cargoSelections:parseObject?.get<List>('cargoSelections') ?? [],
      objectId: parseObject?.get<String>('objectId'),
    );
  }

}
class CarWithPictures {
  final Vehicle? vehicle;
  final List<SelectedFile>? list;

  CarWithPictures({required this.vehicle,required this.list});

}
class Pictures{
  final ParseFile? parseFile;
  Pictures(this.parseFile);
  factory Pictures.fromParseObject(ParseObject? parseObject) {
    return Pictures(
      parseObject?.get<ParseFile>('file')
    );
  }
}