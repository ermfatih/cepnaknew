import 'package:cepnak_agency/core/domain/address_domain.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:equatable/equatable.dart';
import '../../core/domain/bank_information.dart';

class Carrier extends ParseObject implements ParseCloneable, EquatableMixin {
  static const String _keyTableName = 'carriers';
  Carrier({
    String? objectId,
    required ParseUser owner,
    required String email,
    required String name,
    required String phoneNumber,
    required String parseUserName,
    required String gender,
    String? userName,
    DateTime? birthDate,
    //ParseFileBase? profilePicture,
    String? nationality,
    String? language,
    ParseGeoPoint? location,
    Address? address,
    bool? isActive,
    BankInformation? bankInformation,
    ParseFileBase? profilePicture,
    bool? isBreak,
  }) : super(_keyTableName) {
    if (objectId != null) {
      this.objectId = objectId;
    }
    set<ParseUser>('owner', owner);
    set<String?>('email', email);
    //set<String?>('fullName', fullName);
    set<String?>('phoneNumber', phoneNumber);
    set<String>('parseUserName', parseUserName);
    set<String?>('userName', userName);
    set<String?>('gender', gender);
    set<DateTime?>('birthDate', birthDate);
    set<String?>('nationality', nationality);
    set<String?>('language', language);
    set<ParseGeoPoint?>('location', location);
    set<String?>('name', name);
    set<Address?>('address', address);
    set<BankInformation?>('bankInformation', bankInformation);
    set<bool?>('isActive', isActive);
    set<ParseFileBase?>('profilePicture', profilePicture);
    set<bool?>('isBreak', isBreak);
  }
  Carrier.clone()
      : this(
      owner: ParseUser('', '', ''),
      email: '',
      name: '',
      phoneNumber: '',
      gender: '',
      parseUserName: '');

  @override
  Carrier clone(Map<String, dynamic> map) => Carrier.clone()..fromJson(map);

  bool? get isBreak => get<bool?>('isBreak');
  String get name => get<String?>('name')??'';
  ParseFileBase? get profilePicture => get<ParseFileBase?>('profilePicture');
  String get email => get<String>('email') ?? '';
  ParseUser get owner => get<ParseUser>('owner') ?? ParseUser("", "", "");
  bool? get isActive => get<bool?>('isActive') ?? false;
  //String get name => get<String>('name') ?? '';
  String get phoneNumber => get<String>('phoneNumber') ?? '';
  String get parseUserName => get<String?>('parseUserName') ?? '';
  String get userName => get<String?>('userName') ?? '';
  String get gender => get<String>('gender') ?? '';

  DateTime get birthDate => get<DateTime>('birthDate') ?? DateTime.now();
  String get nationality => get<String>('nationality') ?? '';
  String get language => get<String>('language') ?? '';
  ParseGeoPoint get location =>
      get<ParseGeoPoint>('location') ?? ParseGeoPoint();
  Address? get address {
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
  }

  double get ratingByVolunteer {
    var value = get('ratingByVolunteer');
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return 0.0;
    }
  }
  /*
  List<Project>? get myProjectIds => get<List<dynamic>?>("myProjectIds")
      ?.map((e) => Project.clone()..fromJson((e as ParseObject).toJson()))
      .toList();
  }*/

  @override
  List<Object?> get props => [
    owner,
    email,
    phoneNumber,
    isActive,
    parseUserName,
    userName,
    gender,
    birthDate,
    //profilePicture,
    nationality,
    language,
    location,
    address,
    bankInformation,
    ratingByVolunteer,
    name,
  ];
  @override
  bool? get stringify => true;
  Carrier copyWith({
    ParseUser? owner,
    String? email,
    String? name,
    String? phoneNumber,
    String? userName,
    String? parseUserName,
    bool? isActive,
    String? gender,
    DateTime? birthDate,
    ParseFileBase? profilePicture,
    String? nationality,
    String? language,
    ParseGeoPoint? location,
    Address? address,
    BankInformation? bankInformation,
  }) {
    return Carrier(
        objectId: objectId,
        owner: owner ?? this.owner,
        email: email ?? this.email,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        isActive: isActive ?? this.isActive,
        parseUserName: parseUserName ?? this.parseUserName,
        userName: userName ?? this.userName,
        gender: gender ?? this.gender,
        birthDate: birthDate ?? this.birthDate,
        nationality: nationality ?? this.nationality,
        language: language ?? this.language,
        location: location ?? this.location,
        address: address ?? this.address,
        bankInformation: bankInformation ?? this.bankInformation,
      profilePicture: profilePicture??this.profilePicture
    );
  }
}
