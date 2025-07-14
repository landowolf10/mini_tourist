class Client {
  int cardId;
  int memberId;
  String cardName;
  String city;
  String category;
  String isPremium;
  String image;
  String backImage;
  String creationDate;
  String? updateDate;

  Client({
    required this.cardId,
    required this.memberId,
    required this.cardName,
    required this.city,
    required this.category,
    required this.isPremium,
    required this.image,
    required this.backImage,
    required this.creationDate,
    this.updateDate,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      cardId: _parseToInt(json['cardid']),
      memberId: _parseToInt(json['memberid']),
      cardName: json['cardname']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      isPremium: json['premium']?.toString() ?? 'No',
      image: json['image']?.toString() ?? '',
      backImage: json['back_image']?.toString() ?? '',
      creationDate: json['creation_date']?.toString() ?? '',
      updateDate: json['update_date']?.toString(),
    );
  }

  static int _parseToInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0; // Valor por defecto si no se puede parsear
  }
}