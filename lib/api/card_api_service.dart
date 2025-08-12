import 'dart:convert';
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mini_tourist/model/card_lat_long.dart';
import 'package:mini_tourist/model/card_status.dart';
import 'package:mini_tourist/model/card_status_general_city.dart';
import 'package:mini_tourist/model/card_status_general_count.dart';
import 'package:mini_tourist/model/card_status_general_count_date.dart';
import 'package:mini_tourist/model/card_status_general_range.dart';
import 'package:mini_tourist/model/places_per_category.dart';
import 'package:mini_tourist/utils/constant_data.dart';
import 'package:http/http.dart' as http;

class CardApiService {
  static const String endPoint = '${baseUrl}api/v1/cards/';

  Future<void> registerStatus(CardStatus cardStatus) async {
    final response = await http.post(
      Uri.parse('${endPoint}register_status'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(cardStatus.toJson()),
    );

    print("Payload: " + cardStatus.toJson().toString());
    print("Status code status created: ${response.statusCode}");

    if (response.statusCode == 201) {
      print("Status created");
    } else {
      throw Exception('Failed to add status');
    }
  }

  Future<CardLatLong> getLatAndLongdByCardId(int cardId) async {
    final response = await http.get(Uri.parse('${baseUrl}api/v1/card/lat-long/$cardId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return CardLatLong.fromJson(data);
    } else {
      print('Failed to download image: ${response.statusCode}');
      throw Exception('Failed to fetch clients');
    }
  }

  Future<List<PlacesPerCategory>> getPlacesPerCategory(int ownerId, String category) async {
    final response = await http.get(Uri.parse('${baseUrl}api/v1/cards/place/category?owner_id=$ownerId&category=$category'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      print("Owner Id: $ownerId");
      print("Category: $category");
      print("Places per category json: " + jsonData.toString());
      return jsonData.map((item) => PlacesPerCategory.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch clients');
    }
  }

  Future<void> downloadImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      // Convert the image bytes to Uint8List
      Uint8List bytes = response.bodyBytes;

      // Save the image to the gallery
      await ImageGallerySaver.saveImage(bytes);

      print('Image saved to gallery, notification');
    } else {
      print('Failed to download image: ${response.statusCode}');
    }
  }

   Future<CardStatusGeneralCount> getVisitedAndDownloadedCardsGeneral() async {
    String api = 'count/general';
    final response = await http.get(Uri.parse(endPoint + api));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      //print('Visited and downloaded data: ' + data.toString());
      return CardStatusGeneralCount.fromJson(data);
    } else {
      throw Exception('Error al obtener conteos: ${response.statusCode}');
    }
  }

  Future<CardStatusGeneralCountDate> getVisitedAndDownloadedCardsGeneralDate(String date) async {
    String api = 'count/date?date=$date';
    final response = await http.get(Uri.parse(endPoint + api));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      print('Visited and downloaded data date: ' + data.toString());
      return CardStatusGeneralCountDate.fromJson(data);

      //print('Image saved to gallery, notification');
    } else {
      throw Exception('Failed to fetch counts');
    }
  }

  Future<CardStatusGeneralCountRange> getVisitedAndDownloadedCardsGeneralRange(String startDate, String endDate) async {
    String api =  '${endPoint}count?startDate=$startDate&endDate=$endDate';
    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      // Convert the image bytes to Uint8List
      final data = json.decode(response.body) as Map<String, dynamic>;
      print('Visited and downloaded data date range: ' + data.toString());
      return CardStatusGeneralCountRange.fromJson(data);

      //print('Image saved to gallery, notification');
    } else {
      throw Exception('Failed to fetch counts');
    }
  }

  Future<CardStatusGeneralCountCity> getVisitedAndDownloadedCardsGeneralCity(String city) async {
    String api = 'count/city?city=$city';
    final response = await http.get(Uri.parse(endPoint + api));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      print('Visited and downloaded data city: ' + data.toString());
      return CardStatusGeneralCountCity.fromJson(data);

      //print('Image saved to gallery, notification');
    } else {
      throw Exception('Failed to fetch counts');
    }
  }

  Future<CardStatusGeneralCount> getVisitedAndDownloadedCardsGeneralByCardId(int cardId) async {
    final response = await http.get(Uri.parse('${baseUrl}api/v1/card/count/card?cardId=$cardId'));

    //print('Response desde la API: ' + response.toString());

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      //print('Visited and downloaded data: ' + data.toString());
      return CardStatusGeneralCount.fromJson(data);
    } else {
      throw Exception('Error al obtener conteos: ${response.statusCode}');
    }
  }

  Future<CardStatusGeneralCountDate> getVisitedAndDownloadedCardsDateByCardId(int cardId, String date) async {
    String endPoint = '${baseUrl}api/v1/card?cardId=$cardId&date=$date';
    final response = await http.get(Uri.parse(endPoint));

    print('Endpoint: ' + endPoint);
    print('Selected cardId: ' + cardId.toString());
    print('Selected date: ' + date);
    print('Response desde la API: ' + response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      //print('Visited and downloaded data: ' + data.toString());
      return CardStatusGeneralCountDate.fromJson(data);
    } else {
      throw Exception('Error al obtener conteos: ${response.statusCode}');
    }
  }

  Future<CardStatusGeneralCountRange> getVisitedAndDownloadedCardsDateRangeByCardId(int cardId, String startDate, String endDate) async {
    String endPoint = '${baseUrl}api/v1/card/count/range?startDate=$startDate&endDate=$endDate&cardId=$cardId';
    final response = await http.get(Uri.parse(endPoint));

    print('Response desde la API: ' + response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      //print('Visited and downloaded data: ' + data.toString());
      return CardStatusGeneralCountRange.fromJson(data);
    } else {
      throw Exception('Error al obtener conteos: ${response.statusCode}');
    }
  }
}