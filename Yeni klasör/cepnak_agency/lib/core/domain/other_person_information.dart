
class OtherPersonInfo {
  final String relation;
  final String name;
  final DateTime dob;
  final String other;

  OtherPersonInfo({
    required this.relation,
    required this.name,
    required this.dob,
    required this.other,
  });

  factory OtherPersonInfo.fromJson(Map<String, dynamic> json) {
    return OtherPersonInfo(
      relation: json['relation'],
      name: json['name'],
      dob: DateTime.parse(json['dob']),
      other: json['other'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'relation': relation,
      'name': name,
      'dob': dob.toIso8601String(),
      'other': other,
    };
  }
}
