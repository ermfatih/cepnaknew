import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Volunteer extends ParseObject implements ParseCloneable, EquatableMixin {
  static const String _keyTableName = 'Volunteer';
  Volunteer({
    String? objectId,
    required String name,
    String? displayName,
    ParseFileBase? picture,
    bool? isAllowChatWithBeneficiary
  }) : super(_keyTableName) {
    if (objectId != null) {
      this.objectId = objectId;
    }
    set<String>('name', name);
    set<String?>('displayName', displayName);
    set<ParseFileBase?>('picture', picture);
    set<bool?>('isAllowChatWithBeneficiary', isAllowChatWithBeneficiary);
  }
  Volunteer.clone()
      : this(
    name: '',
    displayName: '',
    isAllowChatWithBeneficiary: false,
  );
  @override
  Volunteer clone(Map<String, dynamic> map) => Volunteer.clone()..fromJson(map);
  String get name => get<String?>('name') ?? '';
  String? get displayName => get<String?>('displayName') ?? '';
  ParseFileBase? get picture => get<ParseFileBase?>('picture');
  bool? get isAllowChatWithBeneficiary => get<bool?>('isAllowChatWithBeneficiary');
  @override
  List<Object?> get props => [
    objectId,
    name,
    displayName,
    picture,
    isAllowChatWithBeneficiary
  ];

  @override
  bool? get stringify => true;

  Volunteer copyWith({
    String? name,
    String? displayName,
    ParseFileBase? picture,
    bool? isAllowChatWithBeneficiary
  }) {
    return Volunteer(
        objectId: objectId,
        name: name??this.name,
        picture: picture??this.picture,
        isAllowChatWithBeneficiary: isAllowChatWithBeneficiary??this.isAllowChatWithBeneficiary,
        displayName: displayName??this.displayName
    );
  }
}