target_directory=$(pwd)
read -p "Dosya Adı: " fileName
read -p "Model Adı: " modelName

cat <<EOF >"${target_directory}/${fileName}.dart"

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:equatable/equatable.dart';

class $modelName extends ParseObject implements ParseCloneable, EquatableMixin {
  static const String _keyTableName = '$modelName';

  $modelName({
    String? objectId,
  }) : super(_keyTableName) {
    if (objectId != null) {
      this.objectId = objectId;
    }
   //setters here
  }
  $modelName.clone()
      : this(

      );

  @override
  $modelName clone(Map<String, dynamic> map) => $modelName.clone()..fromJson(map);

  @override
  List<Object?> get props => [

      ];
  @override
  bool? get stringify => true;
  $modelName copyWith({
    String? objectId,
  }) {
    return $modelName(
      objectId: objectId,

    );
  }
}

EOF
echo "$fileName.dart oluşturuldu."