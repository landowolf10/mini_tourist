class CardStatusGeneralCount {
  int visitedCount;
  int downloadedCount;

  CardStatusGeneralCount({
     required this.visitedCount,
     required this.downloadedCount
  });

  factory CardStatusGeneralCount.fromJson(Map<String, dynamic> json) {
    return CardStatusGeneralCount(
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