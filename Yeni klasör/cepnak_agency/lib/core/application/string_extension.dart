extension StringExtensions on String {
  String truncate(int maxLength) {
    if (length <= maxLength) {
      return this;
    } else {
      return '${substring(0, maxLength)}...';
    }
  }
}
extension SizeExtension on int{
  String getByteType(){
    if (this >= 1024 * 1024) {
      double sizeInMB = this / (1024 * 1024);
      return '${sizeInMB.toStringAsFixed(2)} MB';
    } else if (this >= 1024) {
      double sizeInKB = this / 1024;
      return '${sizeInKB.toStringAsFixed(2)} KB';
    } else {
      return '$this byte';
    }
  }
}
extension CurrencyExtension on String?{
  String? getSymbolByCurrencyType(){
    if(this == 'USD'){
      return "\$";
    }else if(this =='EUR'){
      return "€";
    }
    else if(this=="TRY"){
      return "₺";
    }else{
      return "\$";
    }
  }
}
extension DoubleParseExtension on dynamic{
  getDoubleValue(var value){
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return 0.0;
    }
  }
}