import 'package:flutter/material.dart';
import 'package:intern_test/model/photo.dart';
import 'package:intern_test/provider/AppProvider.dart';
import 'package:intern_test/widgets/error_widget.dart';
import 'package:intern_test/widgets/loader.dart';
import 'package:intern_test/widgets/video_card.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
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

  Future<void> fetch(BuildContext context) async {
    final provider = Provider.of<AppProvider>(context);
    try {
      final response = await http.get(
          "https://jsonplaceholder.typicode.com/photos?_page=${provider.page}");
      List<Photo> fetchedPhotos = photoFromJson(response.body);
      provider.hasMore = fetchedPhotos.length == 10;
      provider.isLoading = false;
      provider.page = provider.page + 1;
      provider.photos = fetchedPhotos;
    } catch (e) {
      provider.isLoading = false;
      provider.isError = true;
    }
  }

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
    final provider = Provider.of<AppProvider>(context);
    if (provider.photos.isEmpty) {
      fetch(context);
      if (provider.isLoading) {
        return Loader();
      } else {
        return ErrorText();
      }
    } else {
      return ListView.builder(
        itemCount: provider.photos.length + (provider.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == provider.photos.length) {
            if (provider.isError) {
              return ErrorText();
            } else {
              fetch(context);
              return Loader();
            }
          } else {
            YoutubePlayerController controller = getController(index % 10);
            return VideoCard(
              imageUrl: provider.photos[index].thumbnailUrl,
              title: provider.photos[index].title,
              videoUrl: YoutubePlayer.convertUrlToId(ytUrls[index % 10]),
              controller: controller,
            );
          }
        },
      );
    }
  }
}
