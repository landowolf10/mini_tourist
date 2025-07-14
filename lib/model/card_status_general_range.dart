class CardStatusGeneralCountRange {
  int visitedCount;
  int downloadedCount;

  CardStatusGeneralCountRange({
     required this.visitedCount,
     required this.downloadedCount
  });

  factory CardStatusGeneralCountRange.fromJson(Map<String, dynamic> json) {
    return CardStatusGeneralCountRange(
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