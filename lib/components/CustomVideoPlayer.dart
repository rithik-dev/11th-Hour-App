import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomVideoPlayer extends StatelessWidget {
  final String lectureUrl;
  final String courseId;

  CustomVideoPlayer({this.lectureUrl, this.courseId});

  @override
  Widget build(BuildContext context) {
    return AwsomeVideoPlayer(
      lectureUrl,
      playOptions: VideoPlayOptions(
        seekSeconds: 15,
        aspectRatio: 16 / 9,
        loop: false,
        autoplay: true,
        allowScrubbing: true,
        startPosition: Duration(seconds: 0),
      ),
      videoStyle: VideoStyle(
        playIcon: Icon(
          Icons.play_circle_outline,
          size: 70,
          color: Colors.white,
        ),
        showPlayIcon: true,
        videoControlBarStyle: VideoControlBarStyle(
          progressStyle: VideoProgressStyle(
              // padding: EdgeInsets.all(0),
              playedColor: Colors.red,
              bufferedColor: Colors.green,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              dragBarColor: Colors.white,
              height: 4,
              progressRadius: 2,
              dragHeight: 5),
          playIcon: Icon(Icons.play_arrow, color: Colors.white, size: 16),
          pauseIcon: Icon(
            Icons.pause,
            color: Colors.red,
            size: 20,
          ),
          rewindIcon: Icon(
            Icons.replay_30,
            size: 20,
            color: Colors.white,
          ),
          forwardIcon: Icon(
            Icons.forward_30,
            size: 20,
            color: Colors.white,
          ),
          fullscreenIcon: Icon(
            Icons.fullscreen,
            size: 20,
            color: Colors.white,
          ),
          fullscreenExitIcon: Icon(
            Icons.fullscreen_exit,
            size: 20,
            color: Colors.red,
          ),
          itemList: [
            "rewind",
            "play",
            "forward",
            "position-time",
            "progress",
            "duration-time",
            "fullscreen"
          ],
        ),
      ),
      oninit: (controller) async {
        await UserController.addToRecentCourses(
            userId: Provider.of<User>(context, listen: false).userId,
            courseId: courseId);
        Provider.of<User>(context, listen: false)
            .addCourseToRecentCourses(courseId);
      },
      onpop: (value) {
        Navigator.pop(context);
      },
      onended: (value) {
        print("video ended");
      },
    );
  }
}
