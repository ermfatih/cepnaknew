
class BankInformation {
  final String? currencyType;
  final String? iban;
  final String? accountOwner;
  final String? accountNumber;
  final String? bankName;

  BankInformation(
      {this.currencyType,
      this.iban,
      this.accountOwner,
      this.accountNumber,
      this.bankName});
  factory BankInformation.fromJson(Map<String, dynamic> json) {
    return BankInformation(
      currencyType: json['currencyType'],
      iban: json['iban'],
      accountOwner: json['accountOwner'],
      accountNumber: json['accountNumber'],
      bankName: json['bankName'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'currencyType': currencyType,
      'iban': iban,
      'accountOwner': accountOwner,
      'accountNumber': accountNumber,
      'bankName': bankName,
    };
  }
}