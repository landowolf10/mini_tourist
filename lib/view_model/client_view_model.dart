import 'package:flutter/material.dart';
import 'package:mini_tourist/api/client_api_service.dart';
import 'package:mini_tourist/model/client.dart';

class ClientViewModel extends ChangeNotifier {
  final ClientApiService _apiService = ClientApiService();

  List<Client> cardNames = [];
  List<Client> images = [];
  String singleImage = '';
  List<Client> clients = [];
  Client? client;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      //isLoading = true;
      notifyListeners();

      final response = await _apiService.login(email, password);
      
      // Opcional: Guardar otros datos del usuario si es necesario
      /*if (response['role'] != null) {
        client = Client.fromJson(response['user']);
      }*/

      //isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      //isLoading = false;
      notifyListeners();
      print('Error en loginUser: $e');
      rethrow; // Esto permite manejar el error en la UI
    }
  }

  Future<void> fetchCardNamesByCategory(String category) async {
    try {
      List<Client> cards = await _apiService.getCardsByCategory(category);
      cardNames = cards;
      images = cards;

      if (images.length == 1) {
        singleImage = images[0].image;
      }

      for (int i = 0; i < cards.length; i++) {
        print('Card names: ${cardNames[i].cardName}');
      }

      for (int i = 0; i < cards.length; i++) {
        print('Card images: ${images[i].image}');
      }
        
      print('Viewmodel client id: ${cardNames[0].memberId}');
      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  Future<void> fetchCardNamesByPremium() async {
    try {
      List<Client> cards = await _apiService.getCardsByPremium();
      cardNames = cards;
      images = cards;

      for (int i = 0; i < cards.length; i++) {
        print('Card names: ${cardNames[i].cardName}');
      }

      for (int i = 0; i < cards.length; i++) {
        print('Card images: ${images[i].image}');
      }
        
      print('Viewmodel client id: ${cardNames[0].memberId}');
      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  Future<void> getAllClients() async {
    try {
      clients = await _apiService.getAllClients();

      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  Future<void> getSelectedClient(int clientId) async {
    try {
      client = await _apiService.getSelectedClient(clientId);

      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }


  /*Future<void> addPost(Post post) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 201) {
      fetchPosts(); // Refresh the list after adding a post
    } else {
      throw Exception('Failed to add post');
    }
  }

  Future<void> updatePost(Post post) async {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/${post.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 200) {
      fetchPosts(); // Refresh the list after updating a post
    } else {
      throw Exception('Failed to update post');
    }
  }

  Future<void> deletePost(int postId) async {
    final response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      fetchPosts(); // Refresh the list after deleting a post
    } else {
      throw Exception('Failed to delete post');
    }
  }*/
}