import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:equatable/equatable.dart';

import '../../features/home/freights/freights_model.dart';

enum AppStatus { inProgress, acceptedInProgress, acceptedCompleted, rejected }

enum Gender { male, female }

class Agent extends ParseObject implements ParseCloneable, EquatableMixin {
  static const String _keyTableName = 'agents';

  Agent({
    String? objectId,
    required ParseUser owner,
    required String email,
    required String fullName,
    required String phone,
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
    ParseFileBase? logo,
    String? name,
  }) : super(_keyTableName) {
    if (objectId != null) {
      this.objectId = objectId;
    }
    set<ParseUser>('owner', owner);

    set<String?>('email', email);
    set<String?>('fullName', fullName);
    set<String?>('phone', phone);
    set<String>('parseUserName', parseUserName);

    set<String?>('userName', userName);
    set<String?>('gender', gender);
    set<DateTime?>('birthDate', birthDate);
    set<String?>('nationality', nationality);
    set<String?>('language', language);
    set<ParseGeoPoint?>('location', location);
    set<String?>('name', name);
    //set<String?>('personalIncome', personalIncome);
    //set<String?>('familyIncome', familyIncome);

    //set<bool?>('isPropertyOwnership', isPropertyOwnership);
    //set<bool?>('isHouseOwnership', isHouseOwnership);
    //set<bool?>('isAllowChatWithDonor', isAllowChatWithDonor);
    //set<double?>('ratingByVolunteer', ratingByVolunteer);
    set<Address?>('address', address);
    //set<ParseFileBase?>('profilePicture', profilePicture);
    set<BankInformation?>('bankInformation', bankInformation);
    set<bool?>('isActive', isActive);
    set<ParseFileBase?>('logo', logo);
    // set<List<Project>?>('myProjectIds', myProjectIds);
  }
  Agent.clone()
      : this(
      owner: ParseUser('', '', ''),
      email: '',
      fullName: '',
      phone: '',
      gender: '',
      parseUserName: '');

  @override
  Agent clone(Map<String, dynamic> map) =>
      Agent.clone()..fromJson(map);



  String? get name => get<String?>('name');
  ParseFileBase? get logo => get<ParseFileBase?>('logo');
  String get email => get<String>('email') ?? '';
  ParseUser get owner => get<ParseUser>('owner') ?? ParseUser("", "", "");
  bool? get isActive => get<bool?>('isActive') ?? false;

  String get fullName => get<String>('fullName') ?? '';
  String get phone => get<String>('phone') ?? '';
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

  //ParseFileBase? get profilePicture => get<ParseFileBase?>('profilePicture');
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

  List<Project>? get myProjectIds => get<List<dynamic>?>("myProjectIds")
      ?.map((e) => Project.clone()..fromJson((e as ParseObject).toJson()))
      .toList();
  }*/

  @override
  List<Object?> get props => [
    owner,
    email,
    fullName,
    phone,
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
  Agent copyWith({
    ParseUser? owner,
    String? email,
    String? fullName,
    String? phone,
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
    //int? houseHoldSize,
    // String? personalIncome,
    //String? familyIncome,
    //bool? isPropertyOwnership,
    //bool? isHouseOwnership,
    //bool? isAllowChatWithDonor,
    BankInformation? bankInformation,
    //double? ratingByVolunteer,
    //String? currency,
    // List<Project>? myProjectIds,
    String? name,
    ParseFileBase? logo,
  }) {
    return Agent(
        objectId: objectId,
        owner: owner ?? this.owner,
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        phone: phone ?? this.phone,
        name: name??this.name,
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
        logo: logo??this.logo
    );
  }
}

class BankInformation {
  final String? currencyType;
  final String? iban;
  final String? accountOwner;
  final String? accountNumber;
  final String? bankName;

  BankInformation(
      {this.currencyType,
        this.iban,
        this.accountOwner,
        this.accountNumber,
        this.bankName});
  factory BankInformation.fromJson(Map<String, dynamic> json) {
    return BankInformation(
      currencyType: json['currencyType'],
      iban: json['iban'],
      accountOwner: json['accountOwner'],
      accountNumber: json['accountNumber'],
      bankName: json['bankName'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'currencyType': currencyType,
      'iban': iban,
      'accountOwner': accountOwner,
      'accountNumber': accountNumber,
      'bankName': bankName,
    };
  }
}
