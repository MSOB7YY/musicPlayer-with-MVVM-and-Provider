// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../all_songs/view/all_songs.dart';

class DbFav {
  static ValueNotifier<List<dynamic>> favourites = ValueNotifier([]);
  static List<dynamic> favsong = [];
  static List<SongModel> favloop = [];

  static addSongs(item) async {
    final boxdb = await Hive.openBox('favourites');
    await boxdb.add(item);

    getAllsongs();
  }

  static getAllsongs() async {
    final boxdb = await Hive.openBox('favourites');
    favsong = boxdb.values.toList();

    displaySongs();
    favourites.notifyListeners();
  }

  static displaySongs() async {
    final boxdb = await Hive.openBox('favourites');
    final List<dynamic> music = boxdb.values.toList();
    favourites.value.clear();
    favloop.clear();
    for (int i = 0; i < music.length; i++) {
      for (int j = 0; j < AllSongs.songs.length; j++) {
        if (music[i] == AllSongs.songs[j].id) {
          favourites.value.add(j);
          favloop.add(AllSongs.songs[j]);
        }
      }
    }
  }

  static deletion(index) async {
    final boxdb = await Hive.openBox('favourites');
    await boxdb.deleteAt(index);
    getAllsongs();
  }
}
