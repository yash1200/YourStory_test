import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  static List<String> ytUrls = [
    'https://www.youtube.com/watch?v=zrn7V3bMJvg',
    'https://www.youtube.com/watch?v=mSc7qFzxHDw',
    'https://www.youtube.com/watch?v=HefHf5B1YM0',
    'https://www.youtube.com/watch?v=qYxRYB1oszw',
    'https://www.youtube.com/watch?v=r0tHiCjW2w0',
    'https://www.youtube.com/watch?v=YFCSODyFxbE',
    'https://www.youtube.com/watch?v=RkSqPAn9szs',
    'https://www.youtube.com/watch?v=oD5RtLhhubg',
    'https://www.youtube.com/watch?v=LKKgYpC-EPQ',
    'https://www.youtube.com/watch?v=vzWWDO6whIM',
  ];

  YoutubePlayerController getController(int index) {
    return YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(ytUrls[index]),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ytUrls.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        YoutubePlayerController controller = getController(index);
        return Padding(
          padding: const EdgeInsets.only(top: 150, bottom: 150),
          child: VisibilityDetector(
            key: Key(controller.initialVideoId),
            onVisibilityChanged: (info) {
              var visiblePercentage = info.visibleFraction * 100;
              if (visiblePercentage == 100.0) {
                controller.play();
              } else {
                controller.pause();
              }
            },
            child: YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: true,
            ),
          ),
        );
      },
    );
  }
}
