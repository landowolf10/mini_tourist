import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mini_tourist/api/client_api_service.dart';
import 'package:mini_tourist/model/client.dart';
import 'package:mini_tourist/model/create_member.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ClientViewModel extends ChangeNotifier {
  final ClientApiService _apiService = ClientApiService();

  List<ClientModel> cardNames = [];
  List<ClientModel> cardNamesPlaces = [];
  List<ClientModel> images = [];
  List<ClientModel> places = [];
  String singleImage = '';
  List<ClientModel> clients = [];
  ClientModel? client;

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

  Future<void> saveSession(String role, {int? cardId}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
    if (cardId != null) {
      await prefs.setInt('cardid', cardId);
    }
    await prefs.setInt('loginTime', DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> registerNewMember(CreateMember member) async {
    try {
      await _apiService.registerMember(member);
      notifyListeners();
    } catch (e) {
      print('Error en registerNewMember: $e');
      rethrow;
    }
  }

  Future<void> getCardsByIsPlace(String isPlace) async {
    const String cacheKey = 'cached_places';
    const String lastFetchKey = 'last_fetch_places';
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final lastFetchString = prefs.getString(lastFetchKey);
    DateTime? lastFetchTime = lastFetchString != null ? DateTime.tryParse(lastFetchString) : null;

    bool shouldFetch = true;


    if (lastFetchTime != null) {
      final difference = now.difference(lastFetchTime);
      if (difference.inSeconds < 30) {
        // Dentro del rango de caché, intenta cargar desde local
        final cachedJson = prefs.getString(cacheKey);
        if (cachedJson != null) {
          try {
            final List<dynamic> decoded = jsonDecode(cachedJson);
            List<ClientModel> cachedCards =
                decoded.map((item) => ClientModel.fromJson(item)).toList();
            places = cachedCards;
            cardNamesPlaces = cachedCards;
            notifyListeners();
            print('✅ Cargado desde caché local');
            shouldFetch = false;
          } catch (e) {
            print('⚠️ Error al decodificar caché: $e');
          }
        }
      }
    }

    if (shouldFetch) {
      try {
        print('📡 Llamando a la API de lugares...');
        List<ClientModel> cards = await _apiService.getCardsByIsPlace(isPlace);
        cardNamesPlaces = cards;
        places = cards;

        // Guardar en caché
        final jsonToCache =
            jsonEncode(cards.map((e) => e.toJson()).toList());
        await prefs.setString(cacheKey, jsonToCache);
        await prefs.setString(lastFetchKey, now.toIso8601String());

        notifyListeners();
        print('✅ Datos actualizados desde API y guardados en caché');
      } catch (e) {
        print('❌ Error al obtener tarjetas de lugares: $e');
      }
    }
  }

  Future<void> fetchCardNamesByCategory(String category) async {
    final String cacheKey = 'cached_cards_$category';
    final String lastFetchKey = 'last_fetch_$category';
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final lastFetchString = prefs.getString(lastFetchKey);
    DateTime? lastFetchTime = lastFetchString != null ? DateTime.tryParse(lastFetchString) : null;

    bool shouldFetch = true;


    if (lastFetchTime != null) {
      final difference = now.difference(lastFetchTime);
      if (difference.inSeconds < 30) {
        // Dentro del rango de caché, intenta cargar desde local
        final cachedJson = prefs.getString(cacheKey);
        if (cachedJson != null) {
          try {
            final List<dynamic> decoded = jsonDecode(cachedJson);
            List<ClientModel> cachedCards =
                decoded.map((item) => ClientModel.fromJson(item)).toList();
            images = cachedCards;
            cardNames = cachedCards;
            notifyListeners();
            print('✅ Cargado desde caché local');
            shouldFetch = false;
          } catch (e) {
            print('⚠️ Error al decodificar caché: $e');
          }
        }
      }
    }

    if (shouldFetch) {
      try {
        print('📡 Llamando a la API de tarjetas por categoría...');
        List<ClientModel> cards = await _apiService.getCardsByCategory(category);
        cardNames = cards;
        images = cards;

        // Guardar en caché
        final jsonToCache =
            jsonEncode(cards.map((e) => e.toJson()).toList());
        await prefs.setString(cacheKey, jsonToCache);
        await prefs.setString(lastFetchKey, now.toIso8601String());

        notifyListeners();
        print('✅ Datos actualizados desde API y guardados en caché');
      } catch (e) {
        print('❌ Error al obtener tarjetas premium: $e');
      }
    }
  }

  Future<void> fetchCardNamesByPremium() async {
    const cacheKey = 'cached_premium_cards';
    const lastFetchKey = 'last_premium_fetch';
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final lastFetchString = prefs.getString(lastFetchKey);
    DateTime? lastFetchTime = lastFetchString != null ? DateTime.tryParse(lastFetchString) : null;

    bool shouldFetch = true;

    if (lastFetchTime != null) {
      final difference = now.difference(lastFetchTime);
      if (difference.inSeconds < 30) {
        // Dentro del rango de caché, intenta cargar desde local
        final cachedJson = prefs.getString(cacheKey);
        if (cachedJson != null) {
          try {
            final List<dynamic> decoded = jsonDecode(cachedJson);
            List<ClientModel> cachedCards =
                decoded.map((item) => ClientModel.fromJson(item)).toList();
            images = cachedCards;
            cardNames = cachedCards;
            notifyListeners();
            print('✅ Cargado desde caché local');
            shouldFetch = false;
          } catch (e) {
            print('⚠️ Error al decodificar caché: $e');
          }
        }
      }
    }

    if (shouldFetch) {
      try {
        print('📡 Llamando a la API de tarjetas premium...');
        List<ClientModel> cards = await _apiService.getCardsByPremium();
        cardNames = cards;
        images = cards;

        // Guardar en caché
        final jsonToCache =
            jsonEncode(cards.map((e) => e.toJson()).toList());
        await prefs.setString(cacheKey, jsonToCache);
        await prefs.setString(lastFetchKey, now.toIso8601String());

        notifyListeners();
        print('✅ Datos actualizados desde API y guardados en caché');
      } catch (e) {
        print('❌ Error al obtener tarjetas premium: $e');
      }
    }
  }

  Future<void> getAllClients() async {
    const cacheKey = 'cached_members';
    const lastFetchKey = 'last_members_fetch';
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final lastFetchString = prefs.getString(lastFetchKey);
    DateTime? lastFetchTime = lastFetchString != null ? DateTime.tryParse(lastFetchString) : null;

    bool shouldFetch = true;

    if (lastFetchTime != null) {
      final difference = now.difference(lastFetchTime);
      if (difference.inSeconds < 30) {
        // Dentro del rango de caché, intenta cargar desde local
        final cachedJson = prefs.getString(cacheKey);
        if (cachedJson != null) {
          try {
            final List<dynamic> decoded = jsonDecode(cachedJson);
            clients = decoded.map((item) => ClientModel.fromJson(item)).toList();
            notifyListeners();
            print('✅ Cargado desde caché local');
            shouldFetch = false;
          } catch (e) {
            print('⚠️ Error al decodificar caché: $e');
          }
        }
      }
    }

    if (shouldFetch) {
      try {
        print('📡 Llamando a la API de all clients...');
        clients = await _apiService.getAllClients();

        // Guardar en caché
        final jsonToCache = jsonEncode(clients.map((e) => e.toJson()).toList());
        await prefs.setString(cacheKey, jsonToCache);
        await prefs.setString(lastFetchKey, now.toIso8601String());

        notifyListeners();
        print('✅ Datos actualizados desde API y guardados en caché');
      } catch (e) {
        print('❌ Error al obtener tarjetas premium: $e');
      }
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