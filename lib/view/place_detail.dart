import 'package:flutter/material.dart';
import 'package:mini_tourist/view/map_view_screen.dart';
import 'package:mini_tourist/view/places_by_categories_screen.dart';
import 'package:mini_tourist/view/widgets/drawer.dart';
import 'package:mini_tourist/view_model/card_view_model.dart';
import 'package:provider/provider.dart';

class PlaceDetail extends StatefulWidget {
  final String imageURL;
  final int cardId;
  final String cardName;
  final bool isPlace;

  const PlaceDetail({
    Key? key,
    required this.imageURL,
    required this.cardId,
    required this.cardName,
    required this.isPlace
  }) : super(key: key);

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  @override
  void initState() {
    final cardViewModel = Provider.of<CardViewModel>(context, listen: false);
    cardViewModel.getLatAndLongdByCardId(widget.cardId);
    super.initState();

    // Se marca como visitado al entrar a la pantalla
    Future.delayed(Duration.zero, () {
      final cardViewModel = Provider.of<CardViewModel>(context, listen: false);
      cardViewModel.addCardStatus(
        cardId: widget.cardId,
        status: 'Visited',
        city: 'Zihuatanejo',
        date: DateTime.now(),
      );
    });
  }

  //If is place use this list, else other list
  final List<String> cardLabelsPlace = [
    "Información general",
    "Galería de fotos",
    "Mapa de localización",
    "Restaurantes",
    "Hoteles",
    "Atracciones",
  ];

  final List<String> normalCardLabels = [
    "Menu",
    "Galería de fotos",
    "Servicios extra",
    "Información y reservaciones",
    "Descarga tu cupón",
    "Mapa de localización"
  ];

  @override
  Widget build(BuildContext context) {
    final cardViewModel = Provider.of<CardViewModel>(context, listen: false);
    final List<String> currentLabels = widget.isPlace ? cardLabelsPlace : normalCardLabels;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del Cupón"),
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
        )
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.cardName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            /// Grid de tarjetas (2 columnas, 3 filas)
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 3 / 2,
              children: currentLabels.map((label) {
                return GestureDetector(
                  onTap: () {
                    if (widget.isPlace) {
                      switch (label) {
                        case "Mapa de localización":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MapViewScreen(
                                lat: cardViewModel.lat,
                                lng: cardViewModel.long,
                                nombre: widget.cardName,
                              ),
                            ),
                          );
                          break;
                        case "Restaurantes":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlacesByCategoriesScreen(
                                ownerId: widget.cardId,
                                category: 'restaurants',
                              ),
                            ),
                          );
                          break;
                        case "Hoteles":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlacesByCategoriesScreen(
                                ownerId: widget.cardId,
                                category: 'hotels',
                              ),
                            ),
                          );
                          break;
                        case "Atracciones":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlacesByCategoriesScreen(
                                ownerId: widget.cardId,
                                category: 'attractions',
                              ),
                            ),
                          );
                          break;
                        // Agrega más casos si necesitas
                      }
                    } else {
                      switch (label) {
                        case "Mapa de localización":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MapViewScreen(
                                lat: cardViewModel.lat,
                                lng: cardViewModel.long,
                                nombre: widget.cardName,
                              ),
                            ),
                          );
                          break;
                        case "Descarga tu cupón":
                          cardViewModel.donwloadImage(widget.imageURL);
                          cardViewModel.addCardStatus(
                            cardId: widget.cardId,
                            status: 'Downloaded',
                            city: 'Zihuatanejo',
                            date: DateTime.now(),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("¡Cupón descargado correctamente!")),
                          );
                          break;
                        // Puedes seguir agregando casos específicos para "Menu", "Servicios extra", etc.
                      }
                    }
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          label,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            /// Imagen del cupón
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(widget.imageURL),
            ),

            /*const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                await cardViewModel.donwloadImage(widget.imageURL);
                await cardViewModel.addCardStatus(
                  cardId: widget.cardId,
                  status: 'Downloaded',
                  city: 'Zihuatanejo',
                  date: DateTime.now(),
                );
                Fluttertoast.showToast(
                  msg: "¡Cupón descargado correctamente!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              icon: const Icon(Icons.download),
              label: const Text("Descargar Cupón"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}