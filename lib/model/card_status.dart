class CardStatus {
  int cardId;
  String status;
  String city;
  DateTime date;

  CardStatus({
     required this.cardId,
     required this.status,
     required this.city,
     required this.date
  });

  factory CardStatus.fromJson(Map<String, dynamic> json) {
    return CardStatus(
      cardId: json['cardid'],
      status: json['status'],
      city: json['city'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardid': cardId,
      'status': status,
      'city': city,
      'date': date.toIso8601String(),
    };
  }
}