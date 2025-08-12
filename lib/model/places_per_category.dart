class PlacesPerCategory {
  int id;
  int ownerId;
  int cardId;
  String placeName;
  String category;

  PlacesPerCategory({
     required this.id,
     required this.ownerId,
     required this.cardId,
     required this.placeName,
     required this.category
  });

  factory PlacesPerCategory.fromJson(Map<String, dynamic> json) {
    return PlacesPerCategory (
      id: json['id'],
      ownerId: json['owner_id'],
      cardId: json['card_id'],
      placeName: json['place_name'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'card_id': cardId,
      'place_name': placeName,
      'category': category
    };
  }
}