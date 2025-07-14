import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget carouselSliderWidget(double height, double viewportFraction, int autoPlayInterval, List<Widget> sliderWidgets) {
  return CarouselSlider(
    options: CarouselOptions(
      height: height,
      viewportFraction: viewportFraction,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: autoPlayInterval),
      enlargeCenterPage: true,
      enlargeStrategy: CenterPageEnlargeStrategy.height,
    ),
    items: sliderWidgets,
  );
}
