import 'package:parse_server_sdk/parse_server_sdk.dart';

class CardModel{
  final String? cardNumber;
  final String? expiryDate;
  final String? cardHolderName;
  final String? cvvCode;

  CardModel({required this.cardNumber,required this.expiryDate,required this.cardHolderName,required this.cvvCode});
  factory CardModel.fromParseObject(ParseObject? parseObject){
    return CardModel(
      cardHolderName: parseObject?.get('cardHolderName'),
      cardNumber: parseObject?.get('cardNumber'),
      expiryDate: parseObject?.get('expiryDate'),
      cvvCode: parseObject?.get('cvvCode'),
    );
  }
}