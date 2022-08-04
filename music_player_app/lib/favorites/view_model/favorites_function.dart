// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../all_songs/view_model/allsongs_provider.dart';

class FavoriteFunctions with ChangeNotifier {
  List<dynamic> favourites = [];
  List<dynamic> favsong = [];
  List<SongModel> favloop = [];

  addSongs(item, BuildContext context) async {
    final boxdb = await Hive.openBox('favourites');
    await boxdb.add(item);
    notifyListeners();
    getAllFavorites(context);
  }

  getAllFavorites(BuildContext context) async {
    final boxdb = await Hive.openBox('favourites');
    favsong = boxdb.values.toList();

    displaySongs(context);
    notifyListeners();
  }

  displaySongs(BuildContext context) async {
    final boxdb = await Hive.openBox('favourites');
    final List<dynamic> music = boxdb.values.toList();
    favourites.clear();
    favloop.clear();
    for (int i = 0; i < music.length; i++) {
      for (int j = 0; j < context.read<AllsongsProvider>().songs.length; j++) {
        if (music[i] == context.read<AllsongsProvider>().songs[j].id) {
          favourites.add(j);
          favloop.add(context.read<AllsongsProvider>().songs[j]);
        }
      }
    }
    notifyListeners();
  }

  deletion(index, BuildContext context) async {
    final boxdb = await Hive.openBox('favourites');
    await boxdb.deleteAt(index);
    getAllFavorites(context);
    notifyListeners();
  }
}
