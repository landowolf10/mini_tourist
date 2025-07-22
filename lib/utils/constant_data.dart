import 'package:flutter/material.dart';

//const String baseUrl = 'https://mtspringboot-production.up.railway.app/'; //Railway
//const String baseUrl = 'http://192.168.1.134:9090/'; //Local SpringBoot
const String baseUrl = 'http://10.0.2.2:8000/'; //Local Laravel/SpringBoot emulator Android

final List<String> imgList = [
  'lib/assets/images/zihua.webp',
  'lib/assets/images/cancha.jpg',
  'lib/assets/images/info-carousel-1.jpg',
  'lib/assets/images/delfiniti.jpg'
];
final List<Map<String, String>> categories = [
  //{'image': 'lib/assets/images/logo.png', 'text': 'Premium', 'category': 'premium'},
  {
    'image': 'lib/assets/images/atractions.webp',
    'text': 'Atracciones',
    'category': 'parks'
  },
  {
    'image': 'lib/assets/images/entertainment.webp',
    'text': 'Entretenimineto',
    'category': 'places_events'
  },
  {
    'image': 'lib/assets/images/food.jpg',
    'text': 'Gastronomía',
    'category': 'restaurants'
  },
  {
    'image': 'lib/assets/images/shopping.jpg',
    'text': 'Compras',
    'category': 'shopping'
  },
  {
    'image': 'lib/assets/images/diversion.jpg',
    'text': 'Diversión familiar',
    'category': 'fun'
  },
  {
    'image': 'lib/assets/images/img-conocer-mas.png',
    'text': 'Conoce todas nuestras categorías',
    'category': 'all_categories'
  },
];

final List<Map<String, String>> allCategories = [
  {
    'icon': 'lib/assets/images/premium.png',
    'text': 'Premium',
    'category': 'premium'
  },
  {
    'icon': 'lib/assets/images/parks.png',
    'text': 'Parques y atracciones',
    'category': 'parks'
  },
  {
    'icon': 'lib/assets/images/restaurants.png',
    'text': 'Restaurantes, bares y cafeterías',
    'category': 'restaurants'
  },
  {
    'icon': 'lib/assets/images/events.png',
    'text': 'Lugares y eventos',
    'category': 'places_events'
  },
  {
    'icon': 'lib/assets/images/stores.png',
    'text': 'Tiendas',
    'category': 'stores'
  },
  {
    'icon': 'lib/assets/images/stores.png',
    'text': 'Servicios',
    'category': 'services'
  },
];

final Map<String, Color> categoryColors = {
  'premium': const Color.fromARGB(255, 236, 179, 7),
  'parks': Colors.red,
  'restaurants': const Color.fromARGB(255, 6, 94, 247),
  'places_events': Colors.green,
  'stores': Colors.purple,
  'services': Colors.teal,
};

final List<String> cities = ['Ciudades', 'Zihuatanejo', 'Acapulco', 'Morelia'];
