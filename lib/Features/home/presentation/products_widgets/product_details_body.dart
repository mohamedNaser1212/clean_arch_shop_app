// import 'package:flutter/material.dart';
// import 'package:shop_app/Features/home/presentation/products_widgets/products_details_components.dart';
// import 'package:shop_app/core/models/base_products_model.dart';
// import 'package:shop_app/core/utils/styles/color_manager.dart';

// class ProductDetailsInformationBody extends StatefulWidget {
//   const ProductDetailsInformationBody(
//       {super.key, required this.model, required this.images, this.isProduct});
//   final BaseProductModel model;

//   final dynamic isProduct;

//   final List<String> images;

//   @override
//   State<ProductDetailsInformationBody> createState() =>
//       ProductDetailsInformationBodyState();
// }

// class ProductDetailsInformationBodyState
//     extends State<ProductDetailsInformationBody> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: ColorController.whiteColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: ColorController.greyColor.withOpacity(0.5),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: ProductsDetailsComponents(
//         state: this,
//       ),
//     );
//   }
// }
