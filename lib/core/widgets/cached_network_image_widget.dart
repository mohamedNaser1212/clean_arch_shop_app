import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/models/base_products_model.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  const CachedNetworkImageWidget({super.key, required this.model});
  final BaseProductModel model;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: model.image,
      fit: BoxFit.cover,
      width: 120,
      height: 120,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: Colors.red,
      ),
    );
  }
}
