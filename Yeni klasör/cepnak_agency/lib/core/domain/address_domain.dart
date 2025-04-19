
class Address {
  final String country;
  final String city;
  final String? district;
  final String? description;

  Address(
      {required this.country,
      required this.city,
      this.district,
      this.description});
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      country: json['country'],
      city: json['city'],
      district: json['district'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'city': city,
      'district': district,
      'description': description,
    };
  }
}