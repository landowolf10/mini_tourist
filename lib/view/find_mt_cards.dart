import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mini_tourist/view/widgets/drawer.dart';

class FindMtCards extends StatefulWidget {
  const FindMtCards({super.key});

  @override
  State<FindMtCards> createState() => _FindMtCardsState();
}

class _FindMtCardsState extends State<FindMtCards> {
  final MapController _mapController = MapController();
  final List<String> cities = ['Guerrero', 'Jalisco', 'Oaxaca'];
  String selectedCity = 'Guerrero';

  final Map<String, LatLng> cityLocations = {
    'Guerrero': const LatLng(17.638, -101.551),
    'Jalisco': const LatLng(20.6597, -103.3496),
    'Oaxaca': const LatLng(17.0732, -96.7266),
  };

  final List<String> carouselImages = [
    'lib/assets/images/img-cliente-1.webp',
    'lib/assets/images/img-cliente-2.webp',
    'lib/assets/images/img-cliente-3.webp',
    'lib/assets/images/img-cliente-4.webp',
    'lib/assets/images/img-cliente-5.webp',
    'lib/assets/images/img-cliente-6.webp'
  ];

  void _moveToCity(String city) {
    final LatLng? location = cityLocations[city];
    if (location != null) {
      _mapController.move(location, 11);
      setState(() {
        selectedCity = city;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MiniTourist'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 📍 Mapa
            SizedBox(
              height: 250,
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: cityLocations[selectedCity]!,
                  initialZoom: 11,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: cityLocations.entries.map((entry) {
                      return Marker(
                        width: 40,
                        height: 40,
                        point: entry.value,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 30,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // 🟥 Encabezado
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¿DÓNDE ENCUENTRO LAS MINITOURIST CARDS?',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Encuentra nuestras tarjetas en varios puntos clave de México. Elige una ciudad para localizar los sitios disponibles.',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),

            // 🏷️ Chips de ciudades
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: cities.map((city) {
                  final bool isSelected = selectedCity == city;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(city),
                      selected: isSelected,
                      selectedColor: Colors.red,
                      backgroundColor: Colors.grey.shade200,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      onSelected: (_) => _moveToCity(city),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // 🖼️ Sección de carrusel
            Container(
              width: double.infinity,
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'NUESTROS ALIADOS',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: carouselImages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              carouselImages[index],
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}