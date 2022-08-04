import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../playing_music/view/music_play.dart';
import '../../playing_music/view_model/music_utilities.dart';
import '../create_playlist.dart';
import '../view/body_container.dart';

class UtilityProvider with ChangeNotifier {
  playTheMusic(BuildContext context, List<SongModel> songModel, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MusicScreen(),
      ),
    );
    context.read<MusicUtils>().myMusic = songModel;
    context.read<MusicUtils>().audioPlayer.setAudioSource(
          createPlaylist(songModel),
          initialIndex: index,
        );
    context.read<MusicUtils>().audioPlayer.play();
    notifyListeners();
  }

  itemNull(List<SongModel>? item) {
    if (item == null) {
      return const BodyContainer(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
