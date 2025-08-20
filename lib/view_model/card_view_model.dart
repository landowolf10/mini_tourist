import 'package:flutter/material.dart';
import 'package:mini_tourist/api/card_api_service.dart';
import 'package:mini_tourist/model/card_lat_long.dart';
import 'package:mini_tourist/model/card_status.dart';
import 'package:mini_tourist/model/card_status_general_city.dart';
import 'package:mini_tourist/model/card_status_general_count.dart';
import 'package:mini_tourist/model/card_status_general_count_date.dart';
import 'package:mini_tourist/model/card_status_general_range.dart';
import 'package:mini_tourist/model/client.dart';
import 'package:mini_tourist/model/places_per_category.dart';

class CardViewModel extends ChangeNotifier {
  final CardApiService _apiService = CardApiService();
  CardStatusGeneralCount? _cardStatusGeneralCount;
  CardStatusGeneralCount? _cardStatusGeneralCountById;
  CardLatLong? _cardLatLong;
  List<ClientModel> _beaches = [];
  List<PlacesPerCategory>? placesPerCategory;
  CardStatusGeneralCountDate? _cardStatusGeneralCountDate;
  CardStatusGeneralCountDate? _cardStatusGeneralCountDateById;
  CardStatusGeneralCountRange? _cardStatusGeneralCountRange;
  CardStatusGeneralCountRange? _cardStatusGeneralCountRangeById;
  CardStatusGeneralCountCity? _cardStatusGeneralCountCity;

  int get visitedCount => _cardStatusGeneralCount?.visitedCount ?? 0;
  int get downloadedCount => _cardStatusGeneralCount?.downloadedCount ?? 0;
  int get visitedCountById => _cardStatusGeneralCountById?.visitedCount ?? 0;
  int get downloadedCountById => _cardStatusGeneralCountById?.downloadedCount ?? 0;

  int get visitedCountDate => _cardStatusGeneralCountDate?.visitedCount ?? 0;
  int get downloadedCountDate => _cardStatusGeneralCountDate?.downloadedCount ?? 0;
  int get visitedCountDateById => _cardStatusGeneralCountDateById?.visitedCount ?? 0;
  int get downloadedCountDateById => _cardStatusGeneralCountDateById?.downloadedCount ?? 0;

  int get visitedCountRange => _cardStatusGeneralCountRange?.visitedCount ?? 0;
  int get downloadedCountRange => _cardStatusGeneralCountRange?.downloadedCount ?? 0;
  int get visitedCountRangeById => _cardStatusGeneralCountRangeById?.visitedCount ?? 0;
  int get downloadedCountRangeById => _cardStatusGeneralCountRangeById?.downloadedCount ?? 0;

  int get visitedCountCity => _cardStatusGeneralCountCity?.visitedCount ?? 0;
  int get downloadedCountCity => _cardStatusGeneralCountCity?.downloadedCount ?? 0;

  double get lat => _cardLatLong?.lat ?? 0;
  double get long => _cardLatLong?.long ?? 0;

  List<ClientModel> get beaches => _beaches;

  //List<PlacesPerCategory> get placesPerCategory => _placesPerCategory ?? [];

  Future<void> addCardStatus({
    required int cardId,
    required String status,
    required String city,
    required DateTime date,
  }) async {
    try {
      final cardStatus = CardStatus(
        cardId: cardId,
        status: status,
        city: city,
        date: date,
      );

      await _apiService.registerStatus(cardStatus);
      print('Status created');
      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  Future<void> getLatAndLongdByCardId(int cardId) async {
    try {
      _cardLatLong = await _apiService.getLatAndLongdByCardId(cardId);

      print("lat: " + lat.toString());
      print("long: " + long.toString());

      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error in viewmodel: $e');
    }
  }

  Future<void> getAllBeaches() async {
    try {
      _beaches = await _apiService.getAllBeaches();

      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error in viewmodel: $e');
    }
  }

  Future<void> getPlacesPerCategory(int ownerId, String category) async {
  try {
    placesPerCategory = await _apiService.getPlacesPerCategory(ownerId, category);
    
    //print("Places per category: $_placesPerCategory");
    notifyListeners();
  } catch (e) {
    print('Error in viewmodel: $e');
  }
}


  Future<void> donwloadImage(String imageURL) async {
    try {
      await _apiService.downloadImage(imageURL);

      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  Future<void> getVisitedAndDownloadedCardsGeneral() async {
    try {
      _cardStatusGeneralCount = await _apiService.getVisitedAndDownloadedCardsGeneral();

      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error in viewmodel: $e');
    }
  }

  Future<void> getVisitedAndDownloadedCardsGeneralDate(String date) async {
    try {
      _cardStatusGeneralCountDate = await _apiService.getVisitedAndDownloadedCardsGeneralDate(date);

      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  Future<void> getVisitedAndDownloadedCardsGeneralRange(String startDate, String endDate) async {
    try {
      _cardStatusGeneralCountRange = await _apiService.getVisitedAndDownloadedCardsGeneralRange(startDate, endDate);

      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  Future<void> getVisitedAndDownloadedCardsGeneralCity(String city) async {
    try {
      _cardStatusGeneralCountCity = await _apiService.getVisitedAndDownloadedCardsGeneralCity(city);

      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  Future<void> getVisitedAndDownloadedCardsGeneralByCardId(int cardId) async {
    try {
      _cardStatusGeneralCountById = await _apiService.getVisitedAndDownloadedCardsGeneralByCardId(cardId);

      print('Response desde el viewmodel: $_cardStatusGeneralCountById');

      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error in viewmodel: $e');
    }
  }

  Future<void> getVisitedAndDownloadedCardsDateByCardId(int cardId, String date) async {
    try {
      _cardStatusGeneralCountDateById = await _apiService.getVisitedAndDownloadedCardsDateByCardId(cardId, date);

      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error in viewmodel: $e');
    }
  }

  Future<void> getVisitedAndDownloadedCardsDateRangeByCardId(int cardId, String startDate, String endDate) async {
    try {
      _cardStatusGeneralCountRangeById = await _apiService.getVisitedAndDownloadedCardsDateRangeByCardId(cardId, startDate, endDate);

      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error in viewmodel: $e');
    }
  }
}