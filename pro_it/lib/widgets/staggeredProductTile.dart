import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_it/config/pallete.dart';
import 'package:pro_it/models/models.dart';
import 'package:pro_it/widgets/singleProduct.dart';

class StaggeredProductTile extends StatelessWidget {
  const StaggeredProductTile({Key? key, required this.product})
      : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SingleProduct(product: product), arguments: product);
      },
      child: Card(
        child: Container(
          color: Pallete.cyan100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image
              Container(
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: Get.height * 0.25,
                ),
              ),
              //Title
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.title,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              //Price
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Rs ${product.price.toStringAsFixed(2)}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
