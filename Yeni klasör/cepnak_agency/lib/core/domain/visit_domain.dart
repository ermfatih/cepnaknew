class Visit {
  final String visitId;
  final DateTime? visitDate;
  final DateTime? entryDate;
  final String visitCode;
  final DateTime? verifiedDate;
  final String status;
  final dynamic evaluation;
  Visit(
      {required this.visitId,
      required this.visitDate,
      this.entryDate,
      required this.visitCode,
      this.verifiedDate,
      required this.status,
      this.evaluation});

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      visitId: json['visitId'],
      status: json['status'],
      visitDate: DateTime.parse(json['visitDate']['iso']),
      entryDate: json['entryDate'] != null
          ? DateTime.parse(json['entryDate']['iso'])
          : null,
      verifiedDate: json['verifiedDate'] != null
          ? DateTime.parse(json['verifiedDate']['iso'])
          : null,
      visitCode: json['visitCode'],
      evaluation: json['evaluation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visitId': visitId,
      'status': status,
      'visitDate': visitDate?.toIso8601String(),
      'entryDate': entryDate?.toIso8601String(),
      'verifiedDate': verifiedDate?.toIso8601String(),
      'visitCode': visitCode,
      'evaluation': evaluation,
    };
  }
}
