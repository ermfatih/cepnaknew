class SysCurrency {
  String name;
  String code;
  bool enabled;
  bool enabledForBeneficiary;

  SysCurrency({
    required this.name,
    required this.code,
    required this.enabled,
    required this.enabledForBeneficiary,
  });

  factory SysCurrency.fromJson(Map<String, dynamic> json) {
    return SysCurrency(
      name: json['name'],
      code: json['code'],
      enabled: json['enabled'],
      enabledForBeneficiary: json['enabledForBeneficiary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'enabled': enabled,
      'enabledForBeneficiary': enabledForBeneficiary,
    };
  }
}
