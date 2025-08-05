class CardLatLong {
  double lat;
  double long;

  CardLatLong({
     required this.lat,
     required this.long
  });

  factory CardLatLong.fromJson(Map<String, dynamic> json) {
    return CardLatLong(
      lat: double.parse(json['lat']),
      long: double.parse(json['long'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long
    };
  }
}