import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapViewScreen extends StatelessWidget {
  final double lat;
  final double lng;
  final String nombre;

  const MapViewScreen({
    super.key,
    required this.lat,
    required this.lng,
    required this.nombre,
  });

  void _abrirIndicaciones() async {
    final String googleMapsUrl = 'comgooglemaps://?daddr=$lat,$lng&directionsmode=driving';
    final String fallbackUrl = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving';

    // Intenta abrir la app de Google Maps
    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } 
    // Si no está instalada, abre en navegador
    else if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
      await launchUrl(Uri.parse(fallbackUrl), mode: LaunchMode.externalApplication);
    } 
    else {
      debugPrint('No se pudo abrir Google Maps.');
    }
  }


  @override
  Widget build(BuildContext context) {
    final LatLng destino = LatLng(lat, lng);

    return Scaffold(
      appBar: AppBar(title: Text(nombre)),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: destino,
                initialZoom: 15,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: destino,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.directions),
                label: const Text('Cómo llegar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _abrirIndicaciones,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
