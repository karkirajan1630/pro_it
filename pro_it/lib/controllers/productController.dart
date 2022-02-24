import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_it/controllers/controllers.dart';
import 'package:pro_it/models/models.dart';
import 'package:pro_it/services/recentProductService.dart';
import 'package:pro_it/services/services.dart';
import 'package:pro_it/utilities/utls.dart';

class ProductController extends GetxController {
  Rx<TextEditingController> searchController =
      Rx<TextEditingController>(TextEditingController(text: ""));

  var query = "".obs;

  final Rx<List<Product>> _productList = Rx<List<Product>>([]);
  final Rx<List<ProductV>> _productVList = Rx<List<ProductV>>([]);

  List<Product> get productList {

    return RecentProductService.getRecent(
            _productList.value, _productVList.value)
        .where((e) => e.title.toLowerCase().contains(query.value.toLowerCase()))
        .toList();
  }

  @override
  void onInit() {
    _productList.bindStream(FirebaseApi.getProducts());
    _productVList.bindStream(FirebaseApi.getProductsV(
        Utils.getUsername(Get.find<FirebaseAuthController>().user!.email!)));
    super.onInit();
  }

  void setQuery(String val) {
    query.value = val;
    update();
  }
}
