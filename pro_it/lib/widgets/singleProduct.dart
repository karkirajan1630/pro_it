import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_it/config/pallete.dart';
import 'package:pro_it/controllers/controllers.dart';
import 'package:pro_it/models/models.dart';
import 'package:pro_it/services/firebaseApi.dart';
import 'package:pro_it/utilities/utls.dart';

class SingleProductController extends GetxController {
 

  

  
  @override
  void onInit() {
    Product product = Get.arguments;
    print("Product ${product.id} viewing:");
    print(product.toMap());
    var username = Utils.getUsername(Get.find<FirebaseAuthController>().user!.email!);
    FirebaseApi.createProductV(username, product.id!);
    super.onInit();
  }
}

class SingleProduct extends StatelessWidget {
  final Product product;

  SingleProduct({Key? key, required this.product}) : super(key: key);

  final SingleProductController controller = Get.put(SingleProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.cyan100,
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          GetX<CartController>(builder: (controller) {
            return IconButton(
              onPressed: () {
                Get.find<NavController>().onPageChange(2);
                Get.back();
              },
              icon: Badge(
                child: Icon(Icons.shopping_cart),
                badgeContent: Text("${controller.cartItemList.length}"),
                badgeColor: Pallete.cyan100,
              ),
            );
          }),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: Get.width,
            height: Get.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(product.imageUrl),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fill),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: Text("${product.title}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: Text(
                      "Rs. ${product.price.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30.0,
                      ),
                    ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  "Description",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                child: Text(
                  "${product.description}",
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              
              Container(
                padding: const EdgeInsets.only(bottom: 15.0, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Pallete.primaryCol,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomLeft: Radius.circular(40)),
                        ),
                      ),
                      onPressed: () async {
                        await Get.find<CartController>().addToCart(
                            product,
                            product.price,
                            1,
                            );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 32.0),
                        child: Text("Add to cart"),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
