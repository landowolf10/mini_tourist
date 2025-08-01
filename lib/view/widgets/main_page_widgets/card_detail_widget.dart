import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_tourist/view_model/card_view_model.dart';
import 'package:mini_tourist/view_model/client_view_model.dart';
import 'package:provider/provider.dart';

//Shows a popup with the details of the tapped card.
void displayImageDetails(int index, BuildContext context, {required bool isPlace}) {
  final clientViewModel = Provider.of<ClientViewModel>(context, listen: false);
  final cardViewModel = Provider.of<CardViewModel>(context, listen: false);
  final selectedCardId = isPlace
      ? clientViewModel.cardNamesPlaces[index].cardId
      : clientViewModel.cardNames[index].cardId;

  final imageURL = isPlace
      ? clientViewModel.places[index].image
      : clientViewModel.images[index].image;

  cardViewModel.addCardStatus(
    cardId: selectedCardId,
    status: 'Visited',
    city: 'Zihuatanejo',
    date: DateTime.now(),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.close),
                  )
                ],
              ),
              Image.network(imageURL)
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () async {
              await cardViewModel.donwloadImage(imageURL);
              await cardViewModel.addCardStatus(
                cardId: selectedCardId,
                status: 'Downloaded',
                city: 'Zihuatanejo',
                date: DateTime.now(),
              );
              //print("Downloaded image: $imageURL");
              Fluttertoast.showToast(
                msg: "¡Cupón descargado correctamente!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Descargar cupón')],
            ),
          )
        ],
      );
    },
  );
}