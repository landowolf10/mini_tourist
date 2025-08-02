import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_tourist/view_model/card_view_model.dart';
import 'package:provider/provider.dart';

class PlaceDetail extends StatefulWidget {
  final String imageURL;
  final int cardId;
  final String cardName;

  const PlaceDetail({
    Key? key,
    required this.imageURL,
    required this.cardId,
    required this.cardName,
  }) : super(key: key);

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  @override
  void initState() {
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

  final List<String> cardLabels = [
    "Galería de fotos",
    "Información general",
    "Mapa de localización",
    "Restaurantes",
    "Hoteles",
    "Atracciones",
  ];

  @override
  Widget build(BuildContext context) {
    final cardViewModel = Provider.of<CardViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del Cupón"),
        backgroundColor: Colors.redAccent,
      ),
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
              children: cardLabels.map((label) {
                return Card(
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