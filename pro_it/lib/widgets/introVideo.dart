import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_it/config/constants.dart';
import 'package:pro_it/config/pallete.dart';
import 'package:video_player/video_player.dart';

class Introvideo extends StatefulWidget {
  const Introvideo({Key? key}) : super(key: key);

  @override
  _IntrovideoState createState() => _IntrovideoState();
}

class _IntrovideoState extends State<Introvideo> {
  late VideoPlayerController _controller;
  bool gotError = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/video/intro_video.mp4",
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) {
        _controller.setVolume(0.0);
        _controller.play();
        setState(() {});
      }, onError: (e) {
        setState(() {
          gotError = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !gotError
        ? Container(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Center(
                    child: CircularProgressIndicator(
                    color: Pallete.cyan100,
                  )),
          )
        : Opacity(
            opacity: 0.6,
            child: CachedNetworkImage(
              imageUrl: SLIDE2,
              width: Get.width,
              fit: BoxFit.cover,
            ),
          );
  }
}
