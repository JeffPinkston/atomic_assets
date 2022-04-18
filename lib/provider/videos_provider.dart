import 'package:flutter/material.dart';

class VideosProvider with ChangeNotifier {
  int _selectedIndex = -1;
  List _videos = [];
  String _selectedVideo = '';
  String _selectedName = '';

  int get selectedIndex => _selectedIndex;

  List get videos => _videos;

  String get selectedName => _selectedName;
  String get selectedVideo => _selectedVideo;

  void updateVideos(videos) {
    _videos = videos;
    notifyListeners();
  }

  void updateSelectedData(index) {
    _selectedIndex = index;
    _selectedVideo = videos[index].data.video;
    _selectedName = videos[index].data.name;
    notifyListeners();
  }

  void next() {
    _selectedIndex++;
    updateSelectedData(_selectedIndex);
  }

  void back() {
    _selectedIndex--;
    updateSelectedData(_selectedIndex);
  }
}
