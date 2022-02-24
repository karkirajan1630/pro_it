import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_it_admin/config/userState.dart';
import 'package:pro_it_admin/controllers/controllers.dart';
import 'package:pro_it_admin/views/views.dart';

class Wrapper extends GetView<FirebaseAuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.status == Status.AUTHENTICATED) {
        return HomeView();
      } else {
        return AuthView();
      }
    });
  }
}