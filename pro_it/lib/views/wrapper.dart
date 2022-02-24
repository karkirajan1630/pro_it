import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_it/config/userState.dart';
import 'package:pro_it/controllers/controllers.dart';
import 'package:pro_it/views/views.dart';


class Wrapper extends GetView<FirebaseAuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.status == Status.AUTHENTICATED) {
        return NavView();
      } else {
        return AuthView();
      }
    });
  }
}