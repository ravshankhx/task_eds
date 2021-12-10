import 'geo_model.dart';

class Adress {
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  Geo? geo;

  Adress(
      {this.street,
        this.suite,
        this.city,
        this.zipcode,
        this.geo});


  Adress.fromJson(Map<String, dynamic> json)
      : street = json['street'],
        geo = Geo.fromJson(json['geo']),
        city = json['city'],
        suite = json['suite'],
        zipcode = json['zipcode'];

  Map<String, dynamic> toJson() => {
        'street': street,
        'suite': suite,
        'city': city,
        'zipcode': zipcode,
        'geo': geo!.toJson(),
      };
}
