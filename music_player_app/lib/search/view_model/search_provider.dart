import 'package:flutter/widgets.dart';
import 'package:music_player_app/album/view/album.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SearchProvider with ChangeNotifier {
  List<SongModel> temp = [];
  final searchController = TextEditingController();
  onChangeFunction(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      temp.addAll(context.read<AllsongsProvider>().songs);
      notifyListeners();
    } else {
      temp.clear();
      for (SongModel i in context.read<AllsongsProvider>().songs) {
        if (i.title.toLowerCase().contains(
                  value.toLowerCase(),
                ) ||
            (i.artist!.toLowerCase().contains(
                  value.toLowerCase(),
                ))) {
          temp.add(i);
        }
        notifyListeners();
      }
    }
  }
}
