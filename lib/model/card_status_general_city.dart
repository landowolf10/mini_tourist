class CardStatusGeneralCountCity {
  int visitedCount;
  int downloadedCount;

  CardStatusGeneralCountCity({
     required this.visitedCount,
     required this.downloadedCount
  });

  factory CardStatusGeneralCountCity.fromJson(Map<String, dynamic> json) {
    return CardStatusGeneralCountCity(
      visitedCount: int.parse(json['visited_count']),
      downloadedCount: int.parse(json['downloaded_count'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visited_count': visitedCount,
      'downloaded_count': downloadedCount
    };
  }
}