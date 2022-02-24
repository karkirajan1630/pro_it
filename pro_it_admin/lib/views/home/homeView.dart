import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_it_admin/config/pallete.dart';
import 'package:pro_it_admin/controllers/controllers.dart';
import 'package:pro_it_admin/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<NavController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
            title: Text("Pro IT Dashboard"),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () async {
                  await Get.find<FirebaseAuthController>().signOut();
                },
                icon: Icon(Icons.logout),
              ),
            ]),
        body: controller.pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Pallete.backgroundColor,
          currentIndex: controller.currentIndex.value,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Pallete.primaryCol,
          items: [
            BottomNavigationBarItem(
              icon: SVGCircle(
                svgImage: "assets/images/products.svg",
                radius: 14,
              ),
              label: "Products",
            ),
            BottomNavigationBarItem(
              icon: SVGCircle(
                svgImage: "assets/images/orders.svg",
                radius: 14,
              ),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: SVGCircle(
                svgImage: "assets/images/contact-us.svg",
                radius: 14,
              ),
              label: "Contact",
            ),
            BottomNavigationBarItem(
              icon: SVGCircle(
                svgImage: "assets/images/chat.svg",
                radius: 14,
              ),
              label: "Chat",
            ),
          ],
          onTap: (index) {
            controller.onPageChange(index);
          },
        ),
      );
    });
  }
}
