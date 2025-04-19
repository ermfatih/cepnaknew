

import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../core/domain/address_domain.dart';
/*
class Destination{
  final String? name;
  final String? picture;
  final String? phone1;
  final String? phone2;
  final Address? address;
  final ParseGeoPoint? location;
  Destination();
  factory Destination.fromParseObject(ParseObject? parseObject){
    return Destination(
      name: parseObject?.get<String>('name'),
      picture: parseObject?.get<String>('picture'),
      phone1: parseObject?.get<String>('phone1'),
      phone2:  parseObject?.get<String>('phone2'),
      address:  Address.fromParseObject(parseObject?.get<ParseObject>('address')),
      location: parseObject?.get('location'),
    );
  }
}*/
class Destination extends ParseObject implements ParseCloneable, EquatableMixin {
  static const String _keyTableName = 'destination';
  Destination({
    String? objectId,
    String? name,
    String? picture,
    String? phone1,
    String? phone2,
    Address? address,
    ParseGeoPoint? location,
  }) : super(_keyTableName) {
    if (objectId != null) {
      this.objectId = objectId;
    }
    set<String?>('name', name);
    set<String?>('picture', picture);
    set<String?>('phone1', phone1);
    set<String?>('phone2', phone2);
    set<Address?>('address', address);
    set<ParseGeoPoint?>('location', location);
  }
  Destination.clone()
      : this(
    name: '',
  );

  @override
  Destination clone(Map<String, dynamic> map) => Destination.clone()..fromJson(map);

  String? get name => get<String?>('name');
  String? get picture => get<String?>('picture');
  String? get phone1 => get<String?>('phone1');
  String? get phone2 => get<String?>('phone2');

  ParseGeoPoint? get location=> get<ParseGeoPoint?>('location');
  Address? get address {
    final object = get<dynamic>("address");
    if (object == null) {
      return null;
    }
    return Address.fromJson(object);
  }



  @override
  List<Object?> get props => [
    name,
    picture,
    phone1,
    phone2,
    location,
    address
  ];
  @override
  bool? get stringify => true;
  Destination copyWith({
    String? objectId,
    String? name,
    String? picture,
    String? phone1,
    String? phone2,
    Address? address,
    ParseGeoPoint? location,
  }) {
    return Destination(
      objectId: objectId,
      name: name??this.name,
      picture: picture??this.picture,
      address: address?? this.address,
      location: location??this.location,
      phone1: phone1??this.phone1,
      phone2: phone2??this.phone2,
    );
  }
}
