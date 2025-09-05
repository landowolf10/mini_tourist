import 'dart:io';

class CreateMember {
  String email;
  String password;
  String cardName;
  String city;
  String place;
  String? belongsToBeach;
  String? beachCardName;
  String category;
  String isPremium;
  File? image;
  File? backImage;
  String lat;
  String long;
  String? schedule;
  String? phoneNumber;
  String? web;
  String? socialMedia;
  String? characteristics;

  CreateMember({
    required this.email,
    required this.password,
    required this.cardName,
    required this.city,
    required this.place,
    this.belongsToBeach,
    this.beachCardName,
    required this.category,
    required this.isPremium,
    required this.image,
    required this.backImage,
    required this.lat,
    required this.long,
    this.schedule,
    this.phoneNumber,
    this.web,
    this.socialMedia,
    this.characteristics
  });

  factory CreateMember.fromJson(Map<String, dynamic> json) {
    return CreateMember(
      email: json['email'],
      password: json['password'],
      cardName: json['cardname']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      place: json['place']?.toString() ?? '',
      belongsToBeach: json['belongsToBeach']?.toString(),
      beachCardName: json['beachCardName']?.toString(),
      category: json['category']?.toString() ?? '',
      isPremium: json['premium']?.toString() ?? 'No',
      image: json['image'],
      backImage: json['back_image'],
      lat: json['lat']?.toString() ?? '',
      long: json['long']?.toString() ?? '',
      schedule: json['schedule']?.toString() ?? '',
      phoneNumber: json['phone_number']?.toString() ?? '',
      web: json['web']?.toString() ?? '',
      socialMedia: json['social_media']?.toString() ?? '',
      characteristics: json['characteristics']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'cardname': cardName,
      'city': city,
      'place': place,
      'belongsToBeach': belongsToBeach,
      'beachCardName': beachCardName,
      'category': category,
      'premium': isPremium,
      'image': image,
      'back_image': backImage,
      'lat': lat,
      'long': long,
      'schedule': schedule,
      'phone_number': phoneNumber,
      'web': web,
      'social_media': socialMedia,
      'characteristics': characteristics,
    };
  }

  /// 👇 Método para depuración: imprime todo el modelo
  @override
  String toString() {
    return '''
      CreateMember(
        email: $email,
        password: $password,
        cardName: $cardName,
        city: $city,
        place: $place,
        belongsToBeach: $belongsToBeach,
        beachCardName: $beachCardName,
        category: $category,
        isPremium: $isPremium,
        image: ${image != null ? image!.path : "null"},
        backImage: ${backImage != null ? backImage!.path : "null"},
        lat: $lat,
        long: $long
      )''';
  }
}