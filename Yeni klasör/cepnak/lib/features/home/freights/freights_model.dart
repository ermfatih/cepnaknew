import 'package:cepnak/features/home/freights/source.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:equatable/equatable.dart';

import '../../../product/models/agent_model.dart';
import '../../../product/models/carrier_model.dart';
import 'destination.dart';

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

class Address {
  final String country;
  final String city;
  final String? district;
  final String? description;

  Address(
      {required this.country,
        required this.city,
        this.district,
        this.description});
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      country: json['country'],
      city: json['city'],
      district: json['district'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'city': city,
      'district': district,
      'description': description,
    };
  }
}
