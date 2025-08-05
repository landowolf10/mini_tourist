class ClientModel {
  int cardId;
  int memberId;
  String cardName;
  String city;
  String place;
  String category;
  String isPremium;
  String image;
  String backImage;
  String lat;
  String long;
  String creationDate;
  String? updateDate;

  ClientModel({
    required this.cardId,
    required this.memberId,
    required this.cardName,
    required this.city,
    required this.place,
    required this.category,
    required this.isPremium,
    required this.image,
    required this.backImage,
    required this.lat,
    required this.long,
    required this.creationDate,
    this.updateDate,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      cardId: _parseToInt(json['cardid']),
      memberId: _parseToInt(json['memberid']),
      cardName: json['cardname']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      place: json['place']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      isPremium: json['premium']?.toString() ?? 'No',
      image: json['image']?.toString() ?? '',
      backImage: json['back_image']?.toString() ?? '',
      lat: json['lat']?.toString() ?? '',
      long: json['long']?.toString() ?? '',
      creationDate: json['creation_date']?.toString() ?? '',
      updateDate: json['update_date']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardid': cardId,
      'memberid': memberId,
      'cardname': cardName,
      'city': city,
      'place': place,
      'category': category,
      'premium': isPremium,
      'image': image,
      'back_image': backImage,
      'lat': lat,
      'long': long,
      'creation_date': creationDate,
      'update_date': updateDate,
    };
  }

  static int _parseToInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0; // Valor por defecto si no se puede parsear
  }
}