import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mini_tourist/view/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class BackCardInfoScreen extends StatelessWidget {
  final double lat;
  final double lng;

  const BackCardInfoScreen({
    super.key,
    required this.lat,
    required this.lng,
  });

  void _abrirIndicaciones() async {
    final String googleMapsUrl =
        'comgooglemaps://?daddr=$lat,$lng&directionsmode=driving';
    final String fallbackUrl =
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving';

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
      await launchUrl(Uri.parse(fallbackUrl),
          mode: LaunchMode.externalApplication);
    } else {
      debugPrint('No se pudo abrir Google Maps.');
    }
  }

  Widget _infoRow(IconData icon, String text, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.redAccent, size: 22),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LatLng destino = LatLng(lat, lng);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Localización"),
        backgroundColor: Colors.redAccent,
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
            // Mapa con altura fija más grande
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5, // 50% de la pantalla
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
                        height: 150,
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 60,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Información extra
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Horarios",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      _infoRow(Icons.access_time, "Lunes - Viernes: 9:00 AM - 8:00 PM"),
                      _infoRow(Icons.access_time, "Sábado - Domingo: 10:00 AM - 6:00 PM"),
                      const Divider(),

                      const Text(
                        "Contacto",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      _infoRow(Icons.phone, "55 1234 5678",
                          onTap: () => launchUrl(Uri.parse("tel:5512345678"))),
                      _infoRow(Icons.language, "www.ejemplo.com",
                          onTap: () => launchUrl(Uri.parse("https://www.ejemplo.com"))),
                      _infoRow(Icons.facebook, "/EjemploNegocio",
                          onTap: () => launchUrl(Uri.parse("https://facebook.com/EjemploNegocio"))),
                      const Divider(),

                      const Text(
                        "Características",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      _infoRow(Icons.restaurant, "Comida oriental"),
                      _infoRow(Icons.fastfood, "Antojitos mexicanos"),
                      _infoRow(Icons.local_cafe, "Cafetería"),
                    ],
                  ),
                ),
              ),
            ),

            // Botón Cómo llegar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.directions),
                  label: const Text('Cómo llegar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _abrirIndicaciones,
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}