class CardLatLong {
  double lat;
  double long;
  String? schedule;
  String? phoneNumber;
  String? web;
  String? socialMedia;
  String? characteristics;

  CardLatLong({
     required this.lat,
     required this.long,
     this.schedule,
     this.phoneNumber,
     this.web,
     this.socialMedia,
     this.characteristics
  });

  factory CardLatLong.fromJson(Map<String, dynamic> json) {
    return CardLatLong(
      lat: double.parse(json['lat']),
      long: double.parse(json['long']),
      schedule: json['schedule']?.toString() ?? '',
      phoneNumber: json['phone_number']?.toString() ?? '',
      web: json['web']?.toString() ?? '',
      socialMedia: json['social_media']?.toString() ?? '',
      characteristics: json['characteristics']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
      'schedule': schedule,
      'phone_number': phoneNumber,
      'web': web,
      'social_media': socialMedia,
      'characteristics': characteristics
    };
  }
}