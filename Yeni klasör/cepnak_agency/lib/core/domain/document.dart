/*
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Document extends ParseObject implements ParseCloneable, EquatableMixin {
  static const String _keyTableName = 'Document';
  Document({
    String? objectId,
    ParseFileBase? parseFileBase,
    required String description,
    required int size,

  }) : super(_keyTableName) {
    if (objectId != null) {
      this.objectId = objectId;
    }
    set<String>('description', description);
    set<ParseFileBase?>('parseFileBase', parseFileBase);
    set<int>('size', size);
  }
  Document.clone()
      : this(
    description: '',
    size: 0,
  );
  @override
  Document clone(Map<String, dynamic> map) => Document.clone()..fromJson(map);
  String get description => get<String?>('description') ?? '';
  ParseFileBase? get parseFileBase => get<ParseFileBase?>('parseFileBase');
  int get size => get<int?>('size') ??0;
  @override
  List<Object?> get props => [
    objectId,
    description,
    parseFileBase,
    size
  ];

  @override
  bool? get stringify => true;

  Document copyWith({
    ParseFileBase? parseFileBase,
    String? description,
    int? size,
  }) {
    return Document(
      objectId: objectId,
      description: description??this.description,
      parseFileBase: parseFileBase??this.parseFileBase,
      size: size??this.size
    );
  }
}
*/