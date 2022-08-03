// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../../all_songs/view_model/allsongs_provider.dart';
import '../../model/playlist_model.dart';

class PlaylistProviderFuctions with ChangeNotifier {
  List<PlaylistDbModel> playlistNotifier = [];
  List<SongModel> playloop = [];
  void addPlaylist(PlaylistDbModel value) async {
    final playlistDb = await Hive.openBox<PlaylistDbModel>('playlist_Db');
    int id = await playlistDb.add(value);
    value.id = id;
    await playlistDb.put(value.id, value);
    playlistNotifier.add(value);
    notifyListeners();
  }

  getallPlaylists() async {
    final playlistDb = await Hive.openBox<PlaylistDbModel>('playlist_Db');
    playlistNotifier.clear();
    playlistNotifier.addAll(playlistDb.values);
    notifyListeners();
  }

  deletePlaylist(index) async {
    final playlistDb = await Hive.openBox<PlaylistDbModel>('playlist_Db');
    await playlistDb.deleteAt(index);
    getallPlaylists();
  }

  updatePlaylist(index, value) async {
    final playlistDb = await Hive.openBox<PlaylistDbModel>('playlist_Db');
    await playlistDb.putAt(index, value);
    getallPlaylists();
  }
}
