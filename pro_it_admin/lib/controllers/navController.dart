import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_it_admin/views/views.dart';

class NavController extends GetxController {
  var currentIndex = 0.obs;
  List<Widget> pages = [
    ProductsView(),
    OrdersView(),
    ContactsView(),
    ChatView(),
  ];
  void onPageChange(int index) {
    currentIndex.value = index;
  }
}