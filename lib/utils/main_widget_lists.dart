import 'package:flutter/material.dart';
import 'package:mini_tourist/view/place_detail.dart';
import 'package:mini_tourist/view_model/card_view_model.dart';
import 'package:mini_tourist/view_model/client_view_model.dart';
import 'package:provider/provider.dart';

List<Widget> secondSliderImages(List<String> images, {required bool isPlace}) {
  return images.asMap().entries.map((entry) {
    final index = entry.key;
    final imageUrl = entry.value;

    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            final clientViewModel = Provider.of<ClientViewModel>(context, listen: false);
            Provider.of<CardViewModel>(context, listen: false);

            final selectedCardId = isPlace
                ? clientViewModel.cardNamesPlaces[index].cardId
                : clientViewModel.cardNames[index].cardId;

            final cardName = isPlace
                ? clientViewModel.cardNamesPlaces[index].cardName
                : clientViewModel.cardNames[index].cardName;

            final imageURL = imageUrl;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaceDetail(
                  imageURL: imageURL,
                  cardId: selectedCardId,
                  cardName: cardName,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            height: 300,
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
        );
      },
    );
  }).toList();
}