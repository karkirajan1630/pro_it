import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_it_admin/models/models.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:pro_it_admin/services/firebaseApi.dart';
import 'package:path/path.dart' as Path;

class ProductController extends GetxController {
  final Rx<List<Product>> _productList = Rx<List<Product>>([]);

  List<Product> get productList => _productList.value;

  var title = TextEditingController().obs;
  var description = TextEditingController().obs;
  var basicPrice = TextEditingController().obs;
  var standardPrice = TextEditingController().obs;
  var premiumPrice = TextEditingController().obs;

  late firebase_storage.Reference ref;

  var productFormKey = GlobalKey<FormState>().obs;

  Rx<List<PickedFile>> pickedImages = Rx<List<PickedFile>>([]);

  var imageUrl = "".obs;

  final picker = ImagePicker();

  var uploading = false.obs;
  var submitting = false.obs;
  var progressVal = 0.0.obs;

  @override
  void onInit() {
    _productList.bindStream(FirebaseApi.getProducts());
    super.onInit();
  }

  chooseImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      pickedImages.value.add(PickedFile(pickedFile!.path));
    } catch (e) {
      Get.snackbar("Ohh😮😮😮😮", "Image not selected😌😌😌😌");
    }

    update();
  }

  removeImageAt(int index) {
    pickedImages.value.removeAt(index);
    update();
  }

  removeImage(PickedFile file) {
    pickedImages.value.remove(file);
    update();
  }

  Future uploadFile() async {
    uploading.value = true;
    update();

    PickedFile img = pickedImages.value[0];

    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('product_images/${Path.basename(img.path)}');
    await ref.putFile(File(img.path)).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        imageUrl.value = value;
      });
    });
    uploading.value = false;
    update();
  }

  Future<void> addProductToDb() async {
    ConnectivityResult connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      Get.snackbar("Check Your Internet Connection!", "Try again later");
    } else {
      if (productFormKey.value.currentState!.validate()) {
        submitting.value = true;
        if (pickedImages.value.isEmpty) {
          Get.snackbar("Sorry!", "Add at least one image for product.");
        } else {
          await uploadFile();
          update();
          Product product = Product(
            title: title.value.text,
            imageUrl: imageUrl.value,
            price: Price(
              basic: double.parse(basicPrice.value.text),
              standard: double.parse(standardPrice.value.text),
              premium: double.parse(premiumPrice.value.text),
            ),
            description: description.value.text,
          );
          // productItemDb.createItem(product).then(
          //   (value) {
          //     Get.snackbar(
          //       "Successfull!!",
          //       "Your Product is Created",
          //       snackPosition: SnackPosition.BOTTOM,
          //     );
          //   },
          // );

          FirebaseApi.createProduct(product).then(
            (value) {
              Get.snackbar(
                "Successfull!!",
                "Your Product is Created",
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          );
          onClear();
        }
      }
    }
    submitting.value = false;
    update();
  }

  deleteProduct(String id) {
    FirebaseApi.deleteProduct(id);
    update();
  }

  void onClear() {
    title.value.text = "";
    description.value.text = "";
    imageUrl.value = "";
    pickedImages.value = [];
    progressVal.value = 0.0;
    basicPrice.value.text = "";
    standardPrice.value.text = "";
    premiumPrice.value.text = "";
  }
}
