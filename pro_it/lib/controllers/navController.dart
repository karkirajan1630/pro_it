import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_it/views/views.dart';

class NavController extends GetxController {
  var currentIndex = 0.obs;
  List<Widget> pages = [
    HomeView(),
    ServicesView(),
    CartView(),
    OrderView(),
  ];
  void onPageChange(int index) {
    currentIndex.value = index;
  }
}
