import 'dart:convert';
import 'package:http/http.dart';
import 'package:mini_tourist/model/client.dart';
import 'package:mini_tourist/model/create_member.dart';
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

  Future<void> registerMember(CreateMember createMember) async {
    final uri = Uri.parse('${baseUrl}api/v1/card/register');
    MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields['email'] = createMember.email;
    request.fields['password'] = createMember.password;
    request.fields['cardName'] = createMember.cardName;
    request.fields['city'] = createMember.city;
    request.fields['category'] = createMember.category;
    request.fields['premium'] = createMember.isPremium;

    if (createMember.image != null) {
      request.files.add(await http.MultipartFile.fromPath('imageFile', createMember.image!.path));
    }

    if (createMember.backImage != null) {
      request.files.add(await http.MultipartFile.fromPath('backImageFile', createMember.backImage!.path));
    }

    try {
      final response = await request.send();
      final respStr = await response.stream.bytesToString();

      print("Register member response code: ${response.statusCode}");
      print("Response body: $respStr");

      if (response.statusCode != 201) {
        throw Exception('Fallo al registrar miembro: $respStr');
      }
    } catch (e) {
      print('Error al registrar miembro: $e');
      rethrow;
    }
  }

  Future<List<ClientModel>> getCardsByCategory(String category) async {
    final response = await http.get(Uri.parse('$endPoint$category'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);

      print("Json response endoint: $data");

      List<ClientModel> cardInfoList = data.map<ClientModel>((json) {
        return ClientModel.fromJson(json);
      }).toList();

      return cardInfoList;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load card names');
    }
  }

  Future<List<ClientModel>> getCardsByPremium() async {
    final response = await http
        .get(Uri.parse('${baseUrl}api/v1/cards/premium?isPremium=Yes'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);

      print("Json response endpoint premium: $data");

      List<ClientModel> cardInfoList = data.map<ClientModel>((json) {
        return ClientModel.fromJson(json);
      }).toList();

      return cardInfoList;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load card names');
    }
  }

  Future<List<ClientModel>> getAllClients() async {
    

    final response = await http
        .get(Uri.parse('${baseUrl}api/v1/cards'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      print("Json response: $data");

      return data.map((client) => ClientModel.fromJson(client)).toList();
    } else {
      throw Exception('Failed to fetch clients');
    }
  }

  Future<ClientModel> getSelectedClient(int clientId) async {
    final response =
        await http.get(Uri.parse('${baseUrl}api/v1/card/$clientId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return ClientModel.fromJson(data);
    } else {
      print('Failed to download image: ${response.statusCode}');
      throw Exception('Failed to fetch clients');
    }
  }
}
