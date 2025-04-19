enum CardType{master,via,troy}

class CreditCard {
  final String? description;
  final String? name;
  final String? number;
  final String? lag4Digits;
  final String? expireDate;
  final String? cvc;
  final CardType? cardType;

  CreditCard({this.description, this.name,this.number,this.lag4Digits,this.expireDate,this.cvc,this.cardType});

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      description: json['description'],
      name: json['name'],
      number: json['number'],
      lag4Digits: json['lag4Digits'],
      expireDate: json['expireDate'],
      cvc: json['cvc'],
      cardType: CardType.values.byName(json['cardType']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'name': name,
      'number':number,
      'lag4Digits': lag4Digits,
      'expireDate': expireDate,
      'cvc': cvc,
      'cardType': cardType?.name,
    };
  }
}