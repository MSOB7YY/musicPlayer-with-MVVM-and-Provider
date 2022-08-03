import 'package:flutter/widgets.dart';
import 'package:music_player_app/playlist/view_model/fuctions/playlist_functions.dart';
import 'package:provider/provider.dart';

import '../../../all_songs/view_model/allsongs_provider.dart';

class Playlistsongcheck with ChangeNotifier {
  List selectPlaySong = [];
  showSelectSong(index, BuildContext context) async {
    final checkSong = context
        .read<PlaylistProviderFuctions>()
        .playlistNotifier[index]
        .songList;
    selectPlaySong.clear();
    context.read<PlaylistProviderFuctions>().playloop.clear();
    for (int i = 0; i < checkSong.length; i++) {
      for (int j = 0; j < context.read<AllsongsProvider>().songs.length; j++) {
        if (context.read<AllsongsProvider>().songs[j].id == checkSong[i]) {
          selectPlaySong.add(j);
          context
              .read<PlaylistProviderFuctions>()
              .playloop
              .add(context.read<AllsongsProvider>().songs[j]);
          break;
        }
      }
    }
  }
}
