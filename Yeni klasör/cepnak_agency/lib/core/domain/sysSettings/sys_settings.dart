import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class UpdatedInfo {
  DateTime date;
  String userID;
  String ip;

  UpdatedInfo({required this.date, required this.userID, required this.ip});

  factory UpdatedInfo.fromJson(Map<String, dynamic> json) {
    return UpdatedInfo(
      date: DateTime.parse(json['date']['iso']),
      userID: json['userID'],
      ip: json['IP'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'date': {'__type': 'Date', 'iso': date.toIso8601String()},
      'userID': userID,
      'IP': ip,
    };
  }
}

class SysSetting extends ParseObject implements ParseCloneable, EquatableMixin {
  SysSetting(
      {String? objectId,
      required String name,
      required String value,
      required String type,
      required List<UpdatedInfo> updateInfo,
      List? objectValue})
      : super(_keyTableName) {
    if (objectId != null) {
      this.objectId = objectId;
    }
    set<String>("name", name);
    set<String>("value", value);
    set<List<UpdatedInfo>>("updateInfo", updateInfo);
    set<String>("type", type);
    set<List?>("objectValue", objectValue);
  }
  SysSetting.clone()
      : this(
          name: "",
          value: "",
          type: '',
          updateInfo: [],
        );

  @override
  SysSetting clone(Map<String, dynamic> map) =>
      SysSetting.clone()..fromJson(map);

  static const String _keyTableName = 'SysSetting';
  String get name => get<String>('name')!;
  String get value => get<String>('value')!;
  List? get objectValue => get<List>('objectValue');

  String get type => get<String>('type')!;
  List<UpdatedInfo> get updateInfo => [];

  @override
  List<Object?> get props => [objectId, name, value, updateInfo, objectId];

  @override
  bool? get stringify => true;
  SysSetting copyWith({
    String? type,
    String? name,
    String? value,
    List<UpdatedInfo>? updateInfo,
  }) {
    return SysSetting(
      objectId: objectId,
      name: name ?? this.name,
      value: value ?? this.value,
      updateInfo: updateInfo ?? this.updateInfo,
      type: type ?? this.type,
    );
  }
}
