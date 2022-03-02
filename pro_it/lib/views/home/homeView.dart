import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pro_it/bindings/bindings.dart';
import 'package:pro_it/config/constants.dart';
import 'package:pro_it/config/pallete.dart';
import 'package:pro_it/controllers/controllers.dart';
import 'package:pro_it/utilities/utls.dart';
import 'package:pro_it/views/chat/chatMessageView.dart';
import 'package:pro_it/widgets/widgets.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 220,
            leading: IconButton(
              onPressed: () {
                controller.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Introvideo(),
              title: Text(
                "Pro IT",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  String email = Get.find<FirebaseAuthController>().user!.email!;
                  String username = Utils.getUsername(email);
                  Get.to(()=>ChatMessageView(), binding: ChatsBinding(), arguments: {'id' : "$username"});
                },
                icon: Icon(
                  FontAwesomeIcons.facebookMessenger,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                HeadingWidget(title: "Welcome!", textAlign: TextAlign.center),
                DescriptionWidget(
                  description:
                      "We are happy to have you on board. We sell services for Websites and apps development, social media management, building funnels and Shopify Stores.",
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: MySlider(),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                HeadingWidget(title: "Services", textAlign: TextAlign.center),
                CachedNetworkImage(imageUrl: SERVICES),
                DescriptionWidget(
                  description:
                      "Service, in short, is not what you do, but who you are. It's a way of living that you need to bring to everything you do if you're to bring it to your customer interactions.",
                  textAlign: TextAlign.justify,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Pallete.primaryCol,
                  ),
                  child: Text("Services"),
                  onPressed: () {
                    Get.find<NavController>().onPageChange(1);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
