import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pro_it/config/constants.dart';
import 'package:pro_it/config/pallete.dart';
import 'package:pro_it/controllers/controllers.dart';
import 'package:pro_it/models/models.dart';
import 'package:pro_it/utilities/utls.dart';

import 'drawerListTile.dart';

class MyDrawer extends StatelessWidget {
  final FirebaseAuthController authController =
      Get.find<FirebaseAuthController>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawerProfile(),
                  SizedBox(
                    height: 20,
                  ),
                  Utils.getDivider(),
                  SizedBox(
                    height: 20,
                  ),
                  DrawerListTile(
                    svgImage: "assets/images/services.svg",
                    title: "Services",
                    route: "/services",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DrawerListTile(
                    svgImage: "assets/images/privacy-policy.svg",
                    title: "Privacy Policy",
                    route: "/privacy-policy",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DrawerListTile(
                    svgImage: "assets/images/refund-policy.svg",
                    title: "Refund Policy",
                    route: "/refund-policy",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DrawerListTile(
                    svgImage: "assets/images/terms-of-service.svg",
                    title: "Terms of Service",
                    route: "/terms-of-service",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DrawerListTile(
                    svgImage: "assets/images/contact-us.svg",
                    title: "Contact Us",
                    route: "/contact",
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      child: SvgPicture.asset(
                        "assets/images/sign-out.svg",
                        alignment: Alignment.center,
                      ),
                      backgroundColor: Colors.white,
                    ),
                    title: Text(
                      'SignOut',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      Get.find<FirebaseAuthController>().signOut();
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      imageUrl: APPLOGO,
                      width: 200,
                      height: 140,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String email = Get.find<FirebaseAuthController>().user!.email!;
    return Container(
      child: GetX<UserController>(builder: (controller){
        DbUser user = controller.dbUser.value;
        return Row(
        children: [
          user.profilePhoto != ""
              ? CircleAvatar(
                  radius: 40,
                  foregroundImage:
                      CachedNetworkImageProvider(user.profilePhoto),
                )
              : Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Pallete.primaryCol,
                  ),
                  child: Center(
                    child: Text(
                      Utils.getInitials(user.name),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // color: UniversalVariables.lightBlueColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 150.0,
                child: Text(
                  "${user.name}",
                  maxLines: 2,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 3.0,
              ),
              Text(
                "$email",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      );
      }),
    );
  }
}
