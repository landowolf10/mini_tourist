import 'package:flutter/material.dart';
import 'package:mini_tourist/model/client.dart';
import 'package:mini_tourist/view/place_detail.dart';

List<Widget> carouselSliderImages(List<ClientModel> cards, {required bool isPlace}) {
  return cards.asMap().entries.map((entry) {
    //final index = entry.key;
    final card = entry.value;

    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaceDetail(
                  imageURL: card.image,
                  cardId: card.cardId,
                  cardName: card.cardName,
                  isPlace: isPlace,
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
                image: NetworkImage(card.image),
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