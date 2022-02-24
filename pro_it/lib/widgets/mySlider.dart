import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_it/config/constants.dart';

class MySlider extends StatelessWidget {
  const MySlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 30),
      child: CarouselSlider(
          items: [
            slideItem(
                "We are serving our customers, not a life sentence, and we enjoy it.",
                SLIDE1),
            slideItem(
                "We don't want to push our ideas on to customers, we simply want to make what they want.",
                SLIDE2),
            slideItem(
                "Let us help you to bring your ideas into Reality.", SLIDE3),
          ],
          options: CarouselOptions(
            height: Get.height * .3,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            viewportFraction: 1,
          )),
    );
  }

  Widget slideItem(String title, String imageUrl) {
    return Container(
      child: Stack(
        children: [
          Opacity(
            opacity: 0.7,
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "$title",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
