import 'dart:convert';

import 'package:mini_tourist/model/client.dart';
import 'package:mini_tourist/utils/constant_data.dart';
import 'package:http/http.dart' as http;

class ClientApiService {
  static const String endPoint = '${baseUrl}api/v1/cards/category?category=';

  Future<Map<String, dynamic>> login(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('${baseUrl}api/v1/login'), // Ajusta la ruta según tu API
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data; // Retorna los datos del usuario/token
    } else {
      // Si el servidor devuelve un error, puedes manejarlo aquí
      final errorData = json.decode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to login');
    }
  } catch (e) {
    print('Error en loginUser: $e');
    throw Exception('Error de conexión: $e');
  }
}

  Future<List<Client>> getCardsByCategory(String category) async {
    final response = await http.get(Uri.parse('$endPoint$category'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);

      print("Json response endoint: $data");

      List<Client> cardInfoList = data.map<Client>((json) {
        return Client.fromJson(json);
      }).toList();

      return cardInfoList;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load card names');
    }
  }

  Future<List<Client>> getCardsByPremium() async {
    final response = await http.get(Uri.parse('${baseUrl}api/v1/cards/premium?isPremium=Yes'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);

      print("Json response endpoint premium: $data");

      List<Client> cardInfoList = data.map<Client>((json) {
        return Client.fromJson(json);
      }).toList();

      return cardInfoList;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load card names');
    }
  }

  Future<List<Client>> getAllClients() async {
    final response = await http.get(Uri.parse('${baseUrl}api/v1/cards'));//Change this endpoint

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      print("Json response: $data");

      return data.map((client) => Client.fromJson(client)).toList();
    } else {
      throw Exception('Failed to fetch clients');
    }
  }

  Future<Client> getSelectedClient(int clientId) async {
    final response = await http.get(Uri.parse('${baseUrl}api/v1/card/$clientId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      
      return Client.fromJson(data);
    } else {
      print('Failed to download image: ${response.statusCode}');
      throw Exception('Failed to fetch clients');
    }
  }
}