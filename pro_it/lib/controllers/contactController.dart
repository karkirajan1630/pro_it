import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_it/controllers/controllers.dart';
import 'package:pro_it/models/models.dart';
import 'package:pro_it/services/firebaseApi.dart';

class ContactController extends GetxController {
 

  var contactFormKey = GlobalKey<FormState>().obs;

  var name = TextEditingController().obs;
  var email = TextEditingController().obs;
  var phone = TextEditingController().obs;
  var message = TextEditingController().obs;

  @override
  void onInit() {
    final userController = Get.find<UserController>();
    
    name.value.text = userController.dbUser.value.name;
    email.value.text = userController.dbUser.value.email;
    
    super.onInit();
  }

  void onDispose() {
    name.value.dispose();
    email.value.dispose();
    phone.value.dispose();
    message.value.dispose();
    update();
  }

  void onClear() {
    name.value.text = "";
    email.value.text = "";
    phone.value.text = "";
    message.value.text = "";
    update();
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  void handleContact() async {
    ConnectivityResult connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      Get.snackbar("Check Your Internet Connection!", "Try again later");
    } else {
      if (contactFormKey.value.currentState!.validate()) {
        Contact contact = Contact(
          name: name.value.text,
          email: email.value.text,
          number: int.parse(phone.value.text),
          message: message.value.text,
          updateDate: DateTime.now(),
        );
        FirebaseApi.createContact(contact).then(
          (value) {
            Get.snackbar(
              "Successfull!!",
              "Your Message is placed",
              snackPosition: SnackPosition.BOTTOM,
            );
          },
        );
        onClear();
      }
    }
  }
}