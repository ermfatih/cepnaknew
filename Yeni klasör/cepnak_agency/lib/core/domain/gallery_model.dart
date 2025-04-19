import 'dart:typed_data';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:equatable/equatable.dart';

class GalleryModelAddParameters {
  String name;
  String description;
  String fileUrl;
  Uint8List fileBytes;
  String dimensions;
  String size;
  String type;
  GalleryModelAddParameters(
      {required this.description,
      required this.dimensions,
      required this.fileUrl,
      required this.name,
      required this.size,
      required this.fileBytes,
      required this.type});
}

class GalleryModelUpdateParameters {
  String name;
  String objectId;
  String description;
  Uint8List? fileBytes;
  String dimensions;
  String size;
  String type;
  GalleryModelUpdateParameters(
      {required this.description,
      required this.dimensions,
      required this.objectId,
      required this.name,
      required this.size,
      required this.fileBytes,
      required this.type});
}

class GalleryObject extends ParseObject
    implements ParseCloneable, EquatableMixin {
  GalleryObject({
    required String name,
    required String description,
    ParseFileBase? file,
    String? dimensions,
    String? size,
    String? type,
  }) : super(_keyTableName) {
    set<String>("name", name);
    set<String>("description", description);
    set<ParseFileBase?>("file", file);
    set<String?>("dimensions", dimensions);
    set<String?>("size", size);
    set<String?>("type", type);
  }
  GalleryObject.clone() : this(name: "", description: "");

  @override
  GalleryObject clone(Map<String, dynamic> map) =>
      GalleryObject.clone()..fromJson(map);

  static const String _keyTableName = 'Gallery';
  String get name => get<String>('name')!;
  String get description => get<String>('description')!;
  ParseFileBase? get file => get<ParseFileBase?>('file');
  String? get size => get<String>('size');
  String? get dimensions => get<String>('dimensions');
  String? get type => get<String>('type');

  @override
  List<Object?> get props => [objectId, name, description, file];

  @override
  bool? get stringify => true;
  GalleryObject copyWith(
      {String? type,
      String? name,
      String? description,
      ParseFileBase? file,
      String? dimensions,
      String? size}) {
    return GalleryObject(
        name: name ?? this.name,
        description: description ?? this.description,
        dimensions: dimensions ?? this.dimensions,
        size: size ?? this.size,
        type: type ?? this.type,
        file: file ?? this.file);
  }
}
