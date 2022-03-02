import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_it_admin/config/constants.dart';
import 'package:pro_it_admin/controllers/firebaseAuthController.dart';

class AuthController extends GetxController {
  // For sign in
  var signInFormKey = GlobalKey<FormState>().obs;
  var email1 = TextEditingController(text: AdminEmail).obs;
  var password1 = TextEditingController().obs; // psw is proit7788

  Future<void> signIn() async {
    if (signInFormKey.value.currentState!.validate()) {
      await Get.find<FirebaseAuthController>()
          .signIn(email1.value.text, password1.value.text);
      clear();
    }
  }

  // Clear the fields
  clear() {
    password1.value.text = "";
  }
}
