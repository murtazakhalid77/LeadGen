import 'package:flutter/material.dart';
import 'package:lead_gen/view/signupAndLogin/login.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _videoController = VideoPlayerController.asset('lib/assets/start.mp4')
      ..initialize().then((_) {
        // Ensure the video is initialized and then start playing
        _videoController.play().then((_) {
          // After the video finishes playing, navigate to the login page
          Future.delayed(Duration(seconds: _videoController.value.duration!.inSeconds), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen(phoneNumber: '',)),
            );
          });
        });
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Video Player widget to display the video
          _videoController.value.isInitialized
              ? Container(
                  height: MediaQuery.of(context).size.height, // Set the height here
                  child: AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  ),
                )
              : Container(), // Placeholder container until the video is initialized
        ],
      ),
    );
  }
}
