// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../all_songs/view_model/allsongs_provider.dart';

class DbFav {
  static ValueNotifier<List<dynamic>> favourites = ValueNotifier([]);
  static List<dynamic> favsong = [];
  static List<SongModel> favloop = [];

  static addSongs(item, BuildContext context) async {
    final boxdb = await Hive.openBox('favourites');
    await boxdb.add(item);

    getAllsongs(context);
  }

  static getAllsongs(BuildContext context) async {
    final boxdb = await Hive.openBox('favourites');
    favsong = boxdb.values.toList();

    displaySongs(context);
    favourites.notifyListeners();
  }

  static displaySongs(BuildContext context) async {
    final boxdb = await Hive.openBox('favourites');
    final List<dynamic> music = boxdb.values.toList();
    favourites.value.clear();
    favloop.clear();
    for (int i = 0; i < music.length; i++) {
      for (int j = 0; j < context.read<AllsongsProvider>().songs.length; j++) {
        if (music[i] == context.read<AllsongsProvider>().songs[j].id) {
          favourites.value.add(j);
          favloop.add(context.read<AllsongsProvider>().songs[j]);
        }
      }
    }
  }

  static deletion(index, BuildContext context) async {
    final boxdb = await Hive.openBox('favourites');
    await boxdb.deleteAt(index);
    getAllsongs(context);
  }
}
