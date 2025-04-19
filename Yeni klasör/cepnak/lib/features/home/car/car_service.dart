
import 'package:cepnak/features/home/car/car_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

class CarService {
  final QueryBuilder<ParseObject> carriersQuery = QueryBuilder<ParseObject>(
      ParseObject('carriers'));
  final QueryBuilder<ParseObject> vehicleQuery = QueryBuilder<ParseObject>(
      ParseObject('vehicles'));
  final QueryBuilder<ParseObject> queryVehicles = QueryBuilder<ParseObject>(
      ParseObject('vehicles'));

  //final QueryBuilder<ParseObject> relationVehicle = QueryBuilder<ParseObject>(ParseObject('carriers'))..setRedirectClassNameForKey('vehicles');
  final QueryBuilder<ParseObject> picturesQuery = QueryBuilder<ParseObject>(
      ParseObject('pictures'));

  final carriers = ParseObject('carriers');
  final vehicles = ParseObject('vehicles');
  final pictures = ParseObject('pictures');
  ParseUser? currentUser;

  Future<void> updateVehicle(Vehicle vehicle,List<ParseFile> picturesList) async {
    vehicles
      ..objectId = vehicle.objectId
      ..set('plate', vehicle.plate)..set(
        'capacity', vehicle.capacity)..set('properties', vehicle.properties)..set(
        'fuelConsumption', vehicle.fuelConsumption)..set(
        'cargoSelections', vehicle.cargoSelections)..set(
        'inspectionDate', vehicle.inspectionDate)..set(
        'registrationDate', vehicle.registrationDate);

    await vehicles.update();

    picturesList.forEach((parseFile) async {
      parseFile..objectId=parseFile.objectId;
      await parseFile.delete(id: '1tydwjtGim');
      //pictures..set('file', element);
      //await pictures.update();
    });
  }

  void addRelationsVehicles(Vehicle vehicle, List<ParseFile>? photos) async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser != null) {
      carriersQuery..whereEqualTo('userId', currentUser!.objectId);
      final apiResponse = await carriersQuery.query();
      if (apiResponse.success && apiResponse.results != null) {
        for (var carrier in apiResponse.results!) {
          carrier as ParseObject;
          //vehicles..set('carrierId', currentUser!.objectId);
          addPictures(photos, vehicles);
          vehicles..set('plate', vehicle.plate)..set(
              'properties', vehicle.properties)..set(
              'capacity', vehicle.capacity)..set(
              'cargoSelections', vehicle.cargoSelections)..set(
              'fuelConsumption', vehicle.fuelConsumption)..set(
              'registrationDate', vehicle.registrationDate)..set(
              'inspectionDate', vehicle.inspectionDate);
          await vehicles.save();
          carrier.addRelation('vehicles', [vehicles]);
          await carrier.save();
        }
      }
    }
  }

  void addPictures(List<ParseFile>? list, ParseObject object) async {
    list?.forEach((element) async {
      await element.save();
      pictures..set('file', element);
      await pictures.save();
      object..addRelation('files', [pictures]);
      await object.save();
    });
  }

  Future<List<Vehicle>> getVehicles(String carrierId) async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser != null) {
      vehicleQuery..whereRelatedTo('vehicles', 'carriers', carrierId);
      final response = await vehicleQuery.query();
      if (response.success && response.results != null) {
        return (response.results as List<ParseObject>).map((e) =>
            Vehicle.fromParseObject(e)).toList();
      }
      else {
        return [];
      }
    }
    else {
      return [];
    }
  }

  Future<Vehicle?> getSelectedVehicle(String? objectId) async {
    queryVehicles..whereEqualTo('objectId', objectId);
    final response = await queryVehicles.query();
    if (response.success && response.results != null) {
      return Vehicle.fromParseObject((response.results!.first as ParseObject));
    }
    return null;
  }

  Future<List<Pictures>?> getPictures(String objectId) async {
    picturesQuery..whereRelatedTo('files', 'vehicles', objectId);
    final response = await picturesQuery.query();
    if (response.success && response.results != null) {
      return (response.results! as List<ParseObject>?)?.map((e) =>
          Pictures.fromParseObject(e)).toList();
    }
    return null;
  }

  Future<List<SelectedFile>?> getPictures2(String objectId) async {
    picturesQuery..whereRelatedTo('files', 'vehicles', objectId);
    final response = await picturesQuery.query();
    if (response.success && response.results != null) {
      return (response.results! as List<ParseObject>?)?.map((e) =>
          SelectedFile.image(file: e
              .get<ParseFile>('file')
              ?.file, url: e
              .get<ParseFile>('file')
              ?.url,)).toList();
    }
    return null;
  }

  Future<ParseObject?> getCarrierByCurrentUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser != null) {
      final query=carriersQuery..whereEqualTo('userId', currentUser?.objectId ??'');
      final response=await query.query();
      if (response.success && response.results != null) {
        return query.first();
      }
    }
    throw 'current User null';
  }

  Future<CarWithPictures> fun(String objectId) async {
    Vehicle? vehicle = await getSelectedVehicle(objectId);
    List<SelectedFile>? files = await getPictures2(objectId);
    await getSelectedVehicle(objectId);
    return CarWithPictures(vehicle: vehicle, list: files);
  }
}
/*
  void updateVehicle(Vehicle vehicle) async {
    vehicleQuery..whereEqualTo('objectId', vehicle.objectId);
    final response=await vehicleQuery.query();
    if (response.success && response.results != null){
      ParseObject parse=response.results!.first();
      parse..set(key, value)
    }
  }*/