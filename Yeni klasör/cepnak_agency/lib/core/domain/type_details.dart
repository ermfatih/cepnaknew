
class TypeDetails {
  final String subCategory;
  final int? durationInMonth;
  final int? duration;
  final String? durationType;
  final String? schoolInfo;

  TypeDetails({
    required this.subCategory,
    this.durationInMonth,
    this.duration,
    this.durationType,
    this.schoolInfo,
  });

  factory TypeDetails.fromJson(Map<String, dynamic> json) {
    return TypeDetails(
      subCategory: json['subCategory'],
      durationInMonth: json['durationInMonth'],
      duration: json['duration'],
      durationType: json['durationType'],
      schoolInfo: json['schoolInfo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subCategory': subCategory,
      'durationInMonth': durationInMonth,
      'duration': duration,
      'durationType': durationType,
      'schoolInfo': schoolInfo,
    };
  }
}
