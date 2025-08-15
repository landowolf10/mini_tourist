import 'package:flutter/material.dart';
import 'package:mini_tourist/model/places_per_category.dart';
import 'package:mini_tourist/view/client_detail.dart';
import 'package:mini_tourist/view/widgets/drawer.dart';
import 'package:mini_tourist/view_model/card_view_model.dart';
class PlacesByCategoriesScreen extends StatefulWidget {
  final int ownerId;
  final String category;

  const PlacesByCategoriesScreen({
    super.key,
    required this.ownerId,
    required this.category
  });

  @override
  State<PlacesByCategoriesScreen> createState() => _PlacesByCategoriesScreentate();
}

class _PlacesByCategoriesScreentate extends State<PlacesByCategoriesScreen> {
  final CardViewModel cardViewModel = CardViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClickCards'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child: _buildClientList()),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Regresar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],
        ),
      ),
      drawer: const AppDrawer(),
    );
  }

  Widget _buildClientList() {
    return FutureBuilder<void>(
      future: cardViewModel.getPlacesPerCategory(widget.ownerId, widget.category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
          );
        } else {
          List<PlacesPerCategory>? placeByCategory = cardViewModel.placesPerCategory;

          if (placeByCategory!.isEmpty) {
            return const Center(
              child: Text(
                'No se encontraron lugares registrados',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.separated(
            itemCount: placeByCategory.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final place = placeByCategory[index];
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  title: Text(
                    place.placeName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(place.category),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ClientDetail(clientId: place.cardId, isFromCategoryPlace: true)),
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}