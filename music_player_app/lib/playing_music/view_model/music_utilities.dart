import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/playlist/view_model/fuctions/playlist_functions.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../home/model/duration.dart';
import 'package:rxdart/rxdart.dart';
import '../../utilities/create_playlist.dart';
import '../view/widgets/playlilst_dialog.dart';
import '../view/widgets/playlist_dialog_widget.dart';

class MusicUtils with ChangeNotifier {
  AudioPlayer audioPlayer = AudioPlayer();
  List<SongModel> myMusic = [];
  String currentTitle = '';
  int currentIndex = 0;
  Stream<DurationState> get durationStateStream {
    return Rx.combineLatest2<Duration, Duration?, DurationState>(
      audioPlayer.positionStream,
      audioPlayer.durationStream,
      (position, duration) =>
          DurationState(position: position, total: duration ?? Duration.zero),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  void updateCurrentPlayingSongDetails(int index) {
    if (myMusic.isNotEmpty) {
      currentTitle = myMusic[index].title;
      currentIndex = index;
    }
    notifyListeners();
  }

  void playCheck(BuildContext context, int index) {
    if (currentIndex != index) {
      myMusic = context.read<PlaylistProviderFuctions>().playloop;
      audioPlayer.setAudioSource(
        createPlaylist(context.read<PlaylistProviderFuctions>().playloop),
        initialIndex: index,
      );
      audioPlayer.play();
    }
  }

  playlistDialog(context, id, SongModel songListPlay) {
    Provider.of<PlaylistProviderFuctions>(context, listen: false)
        .getallPlaylists();
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext ctx) {
        return PlaylistDialogWidget(songListPlay: songListPlay, id: id);
      },
    );
  }

  addPlaylistBtn(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AddPlaylistDialog(),
        );
      },
    );
  }
}
