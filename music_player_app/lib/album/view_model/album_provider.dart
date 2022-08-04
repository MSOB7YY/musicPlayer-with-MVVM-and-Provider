import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumProvider with ChangeNotifier {
  final OnAudioQuery audioQuery = OnAudioQuery();
  List<SongModel> albumSong = [];

  albumProviderFn(
      AlbumModel albumModel, BuildContext context, List<SongModel> item) {
    albumSong.clear;
    albumSong = item;
  }
}
