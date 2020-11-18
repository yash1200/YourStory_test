import 'package:flutter/material.dart';
import 'package:intern_test/model/photo.dart';

class AppProvider extends ChangeNotifier {
  int _navIndex = 0;
  bool _isLoading = true;
  bool _isError = false;
  bool _hasMore = true;
  int _page = 1;
  List<Photo> _photos = [];
  List<String> _videos = [];
  bool _isVideoLoading = true;

  int get navIndex => _navIndex;

  set navIndex(int index) {
    _navIndex = index;
    notifyListeners();
  }

  int get page => _page;

  set page(int page) {
    _page = page;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  bool get isError => _isError;

  set isError(bool error) {
    _isError = error;
    notifyListeners();
  }

  bool get hasMore => _hasMore;

  set hasMore(bool more) {
    _hasMore = more;
    notifyListeners();
  }

  List<Photo> get photos => _photos;

  set photos(List<Photo> ph) {
    _photos.addAll(ph);
    notifyListeners();
  }

  List<String> get videos => _videos;

  set videos(List<String> v) {
    _videos.addAll(v);
    notifyListeners();
  }

  bool get isVideoLoading => _isVideoLoading;

  set isVideoLoading(bool loading) {
    _isVideoLoading = loading;
    notifyListeners();
  }
}
