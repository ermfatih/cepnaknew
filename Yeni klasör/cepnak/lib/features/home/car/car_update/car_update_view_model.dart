import 'dart:io';
import 'package:cepnak/features/home/car/car_model.dart';
import 'package:cepnak/features/home/car/car_service.dart';
import 'package:cepnak/product/base/base_controller.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';



class CarUpdateViewModel extends BaseController{
   final form= FormGroup({
      'plate':FormControl<String>(validators: [Validators.required]),
      'capacity':FormControl<double>(validators: [Validators.required,]),
      'registrationDate':FormControl<DateTime>(validators: [Validators.required]),
      'fuelConsumption':FormControl<String>(validators: [Validators.required,]),
      'inspectionDate':FormControl<DateTime>(validators: [Validators.required]),
      'cargoSelections':FormControl<List<String>>(validators: [Validators.required]),
      'properties':FormControl<String>(validators: [Validators.required],),
      'image':FormControl<List<SelectedFile>>(validators: [Validators.required]),
   });

  String get _plate=> form.value['plate'].toString();
  double get _capacity=>  double.tryParse(form.value['capacity'].toString())!;
  DateTime get _registrationDate=>form.value['registrationDate'] as DateTime;
  double get _fuelConsumption=> double.tryParse(form.value['fuelConsumption'].toString())!;
  DateTime get _inspectionDate=> form.value['inspectionDate'] as DateTime;
  List<String> get _cargoSelections=> form.value['cargoSelections'] as List<String>;
  String get _properties=> form.value['properties'].toString();
  List<ParseFile> get parseFile =>(form.value['image'] as List<SelectedFile>).map((e) => ParseFile(File(e.file?.path ?? ''))).toList();
  final CarService _carService=CarService();
  Future<CarWithPictures?> getVehicle(String objectId)async {
    return await _carService.fun(objectId);
  }

  giveToFormValues(CarWithPictures? carWithPictures){
    form.value = {
      'plate': carWithPictures?.vehicle?.plate,
      'capacity':carWithPictures?.vehicle?.capacity,
      'registrationDate':carWithPictures?.vehicle?.registrationDate as DateTime,
      'fuelConsumption':carWithPictures?.vehicle?.fuelConsumption.toString(),
      'inspectionDate':carWithPictures?.vehicle?.inspectionDate as DateTime,
      'cargoSelections':carWithPictures?.vehicle?.cargoSelections.map((e) => e.toString()).toList(),
      'properties':carWithPictures?.vehicle?.properties,
      'image':carWithPictures?.list,
    };
  }
  void onPressedUpdate(String objectId)async{
    var model=Vehicle(objectId: objectId,plate: _plate, registrationDate: _registrationDate, fuelConsumption: _fuelConsumption,properties:  _properties,capacity: _capacity,cargoSelections: _cargoSelections, inspectionDate: _inspectionDate);
    if(form.valid){
      _carService.updateVehicle(model,parseFile);
    }
    form.markAllAsTouched();
  }
}
