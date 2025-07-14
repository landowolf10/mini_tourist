import 'package:flutter/material.dart';
import 'package:mini_tourist/utils/constant_data.dart';
import 'package:mini_tourist/view/widgets/main_page_widgets/card_detail_widget.dart';

List<Widget> firstSliderImages(List<String> images) {
  return imgList.map((item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(item),
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
    );
  }).toList();
}

List<Widget> secondSliderImages(List<String> images) {
  return images.asMap().entries.map((entry) {
    final index = entry.key;
    final imageUrl = entry.value;

    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => displayImageDetails(index, context),
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 4.0), // Espacio reducido
            height: 300,
            width: MediaQuery.of(context).size.width *
                0.45, // angosto (relativo al viewportFraction)
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
