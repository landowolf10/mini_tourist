import 'dart:io';

class CreateMember {
  String email;
  String password;
  String cardName;
  String city;
  String category;
  String isPremium;
  File? image;
  File? backImage;

  CreateMember({
    required this.email,
    required this.password,
    required this.cardName,
    required this.city,
    required this.category,
    required this.isPremium,
    required this.image,
    required this.backImage
  });

  factory CreateMember.fromJson(Map<String, dynamic> json) {
    return CreateMember(
      email: json['email'],
      password: json['password'],
      cardName: json['cardname']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      isPremium: json['premium']?.toString() ?? 'No',
      image: json['image'],
      backImage: json['back_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'cardname': cardName,
      'city': city,
      'category': category,
      'premium': isPremium,
      'image': image,
      'back_image': backImage,
    };
  }
}