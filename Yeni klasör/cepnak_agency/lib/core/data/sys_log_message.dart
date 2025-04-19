class SysLogMessageType {
  String code;
  String message;
  bool displayInLogs;

  SysLogMessageType({
    required this.code,
    required this.message,
    required this.displayInLogs,
  });

  factory SysLogMessageType.fromJson(Map<String, dynamic> json) {
    return SysLogMessageType(
      code: json['code'],
      message: json['message'],
      displayInLogs: json['displayInLogs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'displayInLogs': displayInLogs,
    };
  }
}
