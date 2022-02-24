import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_it/controllers/controllers.dart';

class AuthController extends GetxController {
  // For sign in
  var signInFormKey = GlobalKey<FormState>().obs;
  var email1 = TextEditingController().obs;
  var password1 = TextEditingController().obs;

  Future<void> signIn() async {
    if (signInFormKey.value.currentState!.validate()) {
      await Get.find<FirebaseAuthController>()
          .signIn(email1.value.text, password1.value.text);
      clear();
    }
  }

  // For sign up
  var signUpFormKey = GlobalKey<FormState>().obs;
  var name = TextEditingController().obs;
  var email2 = TextEditingController().obs;
  var password2 = TextEditingController().obs;

  Future<void> signUp() async {
    if (signUpFormKey.value.currentState!.validate()) {
      await Get.find<FirebaseAuthController>()
          .signUp(name.value.text, email2.value.text, password2.value.text);
      clear();
    }
  }

  // Clear the fields
  clear(){
    email1.value.text = "";
    email2.value.text = "";
    password1.value.text = "";
    password2.value.text = "";
    name.value.text = "";
  }
}
