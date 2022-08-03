// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../../all_songs/view_model/allsongs_provider.dart';
import '../../model/playlist_model.dart';

ValueNotifier<List<PlaylistDbModel>> playlistNotifier = ValueNotifier([]);
List<SongModel> playloop = [];
void addPlaylist(PlaylistDbModel value) async {
  final playlistDb = await Hive.openBox<PlaylistDbModel>('playlist_Db');
  int id = await playlistDb.add(value);
  value.id = id;
  await playlistDb.put(value.id, value);
  playlistNotifier.value.add(value);
  playlistNotifier.notifyListeners();
}

getallPlaylists() async {
  final playlistDb = await Hive.openBox<PlaylistDbModel>('playlist_Db');
  playlistNotifier.value.clear();
  playlistNotifier.value.addAll(playlistDb.values);
  playlistNotifier.notifyListeners();
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

class Playlistsongcheck {
  static ValueNotifier<List> selectPlaySong = ValueNotifier([]);
  static showSelectSong(index, BuildContext context) async {
    final checkSong = playlistNotifier.value[index].songList;
    selectPlaySong.value.clear();
    playloop.clear();
    for (int i = 0; i < checkSong.length; i++) {
      for (int j = 0; j < context.read<AllsongsProvider>().songs.length; j++) {
        if (context.read<AllsongsProvider>().songs[j].id == checkSong[i]) {
          selectPlaySong.value.add(j);
          playloop.add(context.read<AllsongsProvider>().songs[j]);
          break;
        }
      }
    }
  }
}
