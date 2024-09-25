import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarousalImageWidget extends StatelessWidget {
  const CarousalImageWidget({super.key, required this.images});
  final dynamic images;

  
  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  ClipRRect _body(BuildContext context) {
    return ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: _carousalSlider(context),
  );
  }

  CarouselSlider _carousalSlider(BuildContext context) {
    return CarouselSlider(
    options: CarouselOptions(
      height: MediaQuery.of(context).size.height / 3,
      autoPlay: true,
      viewportFraction: 1,
      enlargeCenterPage: true,
      autoPlayInterval: const Duration(seconds: 2),
      autoPlayAnimationDuration: const Duration(milliseconds: 600),
      autoPlayCurve: Curves.fastOutSlowIn,
    ),
    items: images.map<Widget>((img) {
      return CachedNetworkImage(
        imageUrl: img,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }).toList(),
  );
  }
}
