import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoCard extends StatelessWidget {
  final String videoUrl;
  final String imageUrl;
  final String title;
  final YoutubePlayerController controller;

  VideoCard({this.imageUrl, this.title, this.videoUrl, this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
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
          ),
          Image.network(
            imageUrl,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            height: 160,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
