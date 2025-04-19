import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Manager extends ParseObject implements ParseCloneable, EquatableMixin {
  static const String _keyTableName = 'Manager';
  Manager({
    String? objectId,
    required String managerName,
    String? displayName,
    ParseFileBase? picture,
    bool? isAllowChatWithBeneficiary,
    List<String>? roles,
  }) : super(_keyTableName) {
    if (objectId != null) {
      this.objectId = objectId;
    }
    set<String>('name', managerName);
    set<String?>('displayName', displayName);
    set<ParseFileBase?>('picture', picture);
    set<bool?>('isAllowChatWithBeneficiary', isAllowChatWithBeneficiary);
    set<List<String>?>('roles', roles);
  }
  Manager.clone()
      : this(
    managerName: '',
    displayName: '',
    isAllowChatWithBeneficiary: false,
    roles: []
  );
  @override
  Manager clone(Map<String, dynamic> map) => Manager.clone()..fromJson(map);
  String get managerName => get<String?>('name') ?? '';
  String? get displayName => get<String?>('displayName') ?? '';
  ParseFileBase? get picture => get<ParseFileBase?>('picture');
  bool? get isAllowChatWithBeneficiary => get<bool?>('isAllowChatWithBeneficiary');
  List<String>? get roles => getRoles();
  List<String> getRoles() {
    final roles = get<List<dynamic>>('roles');
    List<String> result = [];
    if (roles != null) {
      result = roles.map((e) => e as String).toList();
    }
    return result;
  }
  @override
  List<Object?> get props => [
    objectId,
    managerName,
    displayName,
    picture,
    isAllowChatWithBeneficiary,
    roles
  ];

  @override
  bool? get stringify => true;

  Manager copyWith({
    String? managerName,
    String? displayName,
    ParseFileBase? picture,
    bool? isAllowChatWithBeneficiary,
    List<String>? roles,
  }) {
    return Manager(
        objectId: objectId,
        managerName: managerName??this.managerName,
        picture: picture??this.picture,
        isAllowChatWithBeneficiary: isAllowChatWithBeneficiary??this.isAllowChatWithBeneficiary,
        displayName: displayName??this.displayName,
        roles: roles??this.roles,
    );
  }
}