class CardStatusGeneralCountDate {
  //String date;
  int visitedCount;
  int downloadedCount;

  CardStatusGeneralCountDate({
    //required this.date,
    required this.visitedCount,
    required this.downloadedCount
  });

  factory CardStatusGeneralCountDate.fromJson(Map<String, dynamic> json) {
    return CardStatusGeneralCountDate(
      // Conversión segura para ambos casos (int o string)
      visitedCount: (json['visited_count'] is int) 
          ? json['visited_count'] 
          : int.tryParse(json['visited_count']?.toString() ?? '0') ?? 0,
          
      downloadedCount: (json['downloaded_count'] is int)
          ? json['downloaded_count']
          : int.tryParse(json['downloaded_count']?.toString() ?? '0') ?? 0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //'date': date,
      'visited_count': visitedCount,
      'downloaded_count': downloadedCount
    };
  }
}