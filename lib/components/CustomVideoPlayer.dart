import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class CustomVideoPlayer extends StatelessWidget {
  final String lectureUrl;
  final String courseId;
  final bool addToRecent;

  CustomVideoPlayer({this.lectureUrl, this.courseId, this.addToRecent = true});

  @override
  Widget build(BuildContext context) {
    return AwsomeVideoPlayer(
      lectureUrl,
      playOptions: VideoPlayOptions(
        seekSeconds: 15,
        aspectRatio: 16 / 9,
        loop: false,
        autoplay: false,
        allowScrubbing: true,
        startPosition: Duration(seconds: 0),
      ),
      videoStyle: VideoStyle(
        playIcon: Icon(
          Icons.play_circle_outline,
          size: 70,
          color: Colors.pink,
        ),
        showPlayIcon: true,
        videoControlBarStyle: VideoControlBarStyle(
          progressStyle: VideoProgressStyle(
              // padding: EdgeInsets.all(0),
              playedColor: Colors.red,
              bufferedColor: Colors.green,
              backgroundColor: NeumorphicTheme.currentTheme(context).baseColor,
              dragBarColor: Colors.black,
              height: 3,
              progressRadius: 2,
              dragHeight: 5),
          playIcon: Icon(Icons.play_arrow, color: Colors.black, size: 16),
          pauseIcon: Icon(
            Icons.pause,
            color: Colors.red,
            size: 20,
          ),
          rewindIcon: Icon(
            Icons.replay_30,
            size: 20,
            color: Colors.black,
          ),
          forwardIcon: Icon(
            Icons.forward_30,
            size: 20,
            color: Colors.black,
          ),
          fullscreenIcon: Icon(
            Icons.fullscreen,
            size: 20,
            color: Colors.black,
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
      oninit: addToRecent
          ? (controller) async {
              await UserController.addToRecentCourses(
                  userId: Provider.of<User>(context, listen: false).userId,
                  courseId: courseId);
              Provider.of<User>(context, listen: false)
                  .addCourseToRecentCourses(courseId);
            }
          : (controller) {},
      onpop: (value) {
        Navigator.pop(context);
      },
      onended: (value) {
        print("video ended");
      },
    );
  }
}
