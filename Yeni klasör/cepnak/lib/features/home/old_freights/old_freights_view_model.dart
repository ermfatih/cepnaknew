import 'package:cepnak/features/home/freights/freights_model.dart';
import 'package:cepnak/features/home/freights/freights_service.dart';

class OldFreightsViewModel{
  FreightService _service=FreightService();
  Future<List<Freight>?> getOldFreights()async{
    return await _service.getOldFreights();
  }
}