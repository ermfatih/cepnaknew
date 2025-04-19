
class SysSubCategory {
  String type;
  String name;
  bool enabled;

  SysSubCategory({required this.type, required this.name, required this.enabled});

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'enabled': enabled,
    };
  }

  factory SysSubCategory.fromJson(Map<String, dynamic> json) {
    return SysSubCategory(
      type: json['type'],
      name: json['name'],
      enabled: json['enabled'],
    );
  }
 
}
