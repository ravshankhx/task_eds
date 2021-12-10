class Geo {
  String? lat;
  String? lng;
  Geo({this.lng,this.lat});

  Geo.fromJson(Map<String, dynamic> json)
      : lat = json['lat'],
        lng = json['lng'];

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };
}
