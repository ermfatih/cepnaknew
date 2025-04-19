import 'package:cepnak_agency/authentication/domain/agent.dart';
import 'package:cepnak_agency/carriers_management/domain/carrier_model.dart';
import 'package:cepnak_agency/freights_management/domain/source_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:equatable/equatable.dart';

import 'destination_model.dart';


class Freight extends ParseObject implements ParseCloneable, EquatableMixin {
  static const String _keyTableName = 'freights';
  Freight({
    String? objectId,
    required Agent agentId,
    bool? isCompleted,
    DateTime? deliveryDate,
    DateTime? startDate,
    double? price,
    double? commission,
    String? name,
    double? distance,
    String? cargoType,
    double? weight,
    Destination? destination,
    Source? source,
    String? lastState,
    Carrier? carrierId,
  }) : super(_keyTableName) {
    if (objectId != null) {
      this.objectId = objectId;
    }
    set<Agent>('agentId', agentId);
    set<bool?>('isCompleted', isCompleted);
    set<DateTime?>('deliveryDate', deliveryDate);
    set<DateTime?>('startDate', startDate);
    set<double?>('price', price);
    set<double?>('commission', commission);
    set<String?>('name', name);
    set<double?>('distance', distance);
    set<String?>('cargoType', cargoType);
    set<double?>('weight', weight);
    set<String?>('lastState', lastState);
    set<Source?>('source', source);
    set<Destination?>('destination', destination);
    set<Carrier?>('carrierId', carrierId);
  }
  Freight.clone()
      : this(
    agentId: Agent.clone(),
  );

  @override
  Freight clone(Map<String, dynamic> map) => Freight.clone()..fromJson(map);




  Carrier? get carrierId => getCarrier();
  Source? get source =>getSource();
  Destination? get destination =>getDestination();
  Agent get agentId => getAgent();
  bool? get isCompleted => get<bool>('isCompleted');
  DateTime? get deliveryDate => get<DateTime?>('deliveryDate');
  DateTime? get startDate => get<DateTime?>('startDate');
  double get price {
    var value = get('price');
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return 0.0;
    }
  }
  double get commission {
    var value = get('commission');
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return 0.0;
    }
  }
  double get distance {
    var value = get('distance');
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return 0.0;
    }
  }
  double get weight {
    var value = get('weight');
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return 0.0;
    }
  }

  String? get name => get<String?>('name');
  String? get cargoType => get<String?>('cargoType');
  String? get lastState => get<String?>('lastState');
  Destination? getDestination() {
    final ParseObject? data = get<ParseObject?>('destination');
    if (data != null) {
      return Destination.clone()..fromJson(data.toJson());
    }
    return Destination.clone();
  }

  Source? getSource() {
    final ParseObject? data = get<ParseObject?>('source');
    if (data != null) {
      return Source.clone()..fromJson(data.toJson());
    }
    return Source.clone();
  }

  /*Address? get address {
    final object = get<dynamic>("address");
    if (object == null) {
      return null;
    }
    return Address.fromJson(object);
  }
  BankInformation? get bankInformation {
    final object = get<dynamic>("bankInformation");
    if (object == null) {
      return null;
    }
    return BankInformation.fromJson(object);
  }*/
  Agent getAgent() {
    final ParseObject? data = get<ParseObject?>('agentId');
    if (data != null) {
      return Agent.clone()..fromJson(data.toJson());
    }
    return Agent.clone();
  }
  Carrier? getCarrier() {
    final ParseObject? data = get<ParseObject?>('carrierId');
    if (data != null) {
      return Carrier.clone()..fromJson(data.toJson());
    }
    return null;
  }



  @override
  List<Object?> get props => [
    agentId,
    isCompleted,
    deliveryDate,
    startDate,
    price,
    commission,
    name,
    distance,
    cargoType,
    weight,
    lastState,
    destination,
    source,
    carrierId,
  ];
  @override
  bool? get stringify => true;
  Freight copyWith({
    String? objectId,
    Agent? agentId,
    bool? isCompleted,
    DateTime? deliveryDate,
    DateTime? startDate,
    double? price,
    double? commission,
    String? name,
    double? distance,
    String? cargoType,
    double? weight,
    Destination? destination,
    Source? source,
    String? lastState,
    Carrier? carrierId,
  }) {
    return Freight(
      objectId: objectId,
      agentId: agentId??this.agentId,
      name: name?? this.name,
      cargoType: cargoType??this.cargoType,
      commission: commission?? this.commission,
      deliveryDate: deliveryDate?? this.deliveryDate,
      distance: distance??this.distance,
      isCompleted: isCompleted ?? this.isCompleted,
      lastState: lastState?? this.lastState,
      price: price?? this.price,
      startDate: startDate??this.startDate,
      weight: weight??this.weight,
      source: source?? this.source,
      destination: destination?? this.destination,
      carrierId: carrierId??this.carrierId,
    );
  }
}




/*class FreightsModel{
  final String? objectId;
  final String? name;
  final DateTime? deliveryDate;
  final double? price;
  final double? commission;
  final bool? isCompleted;
  final String? lastState;
  final String? carrierId;
  final String? customerId;
  final String? agentId;
  final String? cargoType;
  final double? weight;
  final double? distance;
  final Source? source;
  final Destination? destination;
  final ParseObject? invoice;

  FreightsModel({this.agentId,this.objectId,required this.name,required this.deliveryDate,required this.price,required this.commission,
    required this.isCompleted,required this.lastState,required this.carrierId,required this.customerId,
    required this.cargoType,required this.weight,required this.distance,required this.source,
    required this.destination,required this.invoice});

  factory FreightsModel.fromParseObject(ParseObject? parseObject){
    return FreightsModel(
        objectId:parseObject?.objectId,
        name: parseObject?.get<String>('name'),
        deliveryDate: parseObject?.get<DateTime>('deliveryDate'),
        isCompleted: parseObject?.get<bool>('isComplete'),
        lastState: parseObject?.get<String>('lastState'),
        carrierId: parseObject?.get<String>('carrierId'),
        customerId: parseObject?.get<String>('customerId'),
        agentId: parseObject?.get<String>('agentId'),
        cargoType: parseObject?.get<String>('cargoType'),
        commission: double.tryParse(parseObject?.get('commission').toString() ?? '0'),
        price: double.tryParse(parseObject?.get('price').toString() ?? '0'),
        weight: double.tryParse(parseObject?.get('weight').toString() ?? '0'),
        distance: double.tryParse(parseObject?.get('distance').toString() ?? '0'),
        source: Source.fromParseObject(parseObject?.get<ParseObject>('source')),
        destination: Destination.fromParseObject(parseObject?.get<ParseObject>('destination')),
        invoice: parseObject?.get<ParseObject>('invoice'),
    );
  }
}*/
/*class Address{
  final String? street;
  final String? neighbourhood;
  final String? district;
  final String? city;
  Address({this.neighbourhood,required this.street,required this.district,required this.city});
  factory Address.fromParseObject(ParseObject? parseObject){
    return Address(
      street: parseObject?.get<String>('street'),
      neighbourhood: parseObject?.get<String>('neighbourhood'),
      district: parseObject?.get<String>('district'),
      city: parseObject?.get<String>('city'),
    );
  }
}*/
/*class TransportPart{
  final String? name;
  final String? picture;
  final String? phone1;
  final String? phone2;
  final Address? address;
  final ParseGeoPoint? location;

  TransportPart({required this.name, required this.picture,required this.phone1,required this.phone2,required this.address,required this.location});
}*/
/*class Source{
  final String? name;
  final String? picture;
  final String? phone1;
  final String? phone2;
  final Address? address;
  final ParseGeoPoint? location;
  Source();
  factory Source.fromParseObject(ParseObject? parseObject){
    return Source(
        name: parseObject?.get<String>('name'),
        picture: parseObject?.get<String>('picture'),
        phone1: parseObject?.get<String>('phone1'),
        phone2: parseObject?.get<String>('phone2'),
        address: Address.fromParseObject(parseObject?.get<ParseObject>('address')),
        location: parseObject?.get('location'),
    );
  }
}*/


