import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/carousal_slider_widget.dart';

class CarousalImageWidget extends StatelessWidget {
  const CarousalImageWidget({super.key, required this.images});
  final dynamic images;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: CarousalSliderWidget(images: images),
    );
  }
}
