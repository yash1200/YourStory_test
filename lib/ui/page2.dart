import 'package:flutter/material.dart';
import 'package:intern_test/model/photo.dart';
import 'package:intern_test/provider/AppProvider.dart';
import 'package:intern_test/widgets/error_widget.dart';
import 'package:intern_test/widgets/loader.dart';
import 'package:intern_test/widgets/photo_card.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
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
            return PhotoCard(
              imageUrl: provider.photos[index].thumbnailUrl,
              title: provider.photos[index].title,
            );
          }
        },
      );
    }
  }
}
