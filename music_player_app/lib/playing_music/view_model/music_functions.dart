import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/playing_music/view_model/music_utilities.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:provider/provider.dart';

class PlayMusicProvider with ChangeNotifier {
  StreamBuilder<PlayerState> playButton(double size) {
    return StreamBuilder<PlayerState>(
      builder: (context, snapshot) {
        return IconButton(
          onPressed: () {
            if (context.read<MusicUtils>().audioPlayer.playing) {
              context.read<MusicUtils>().audioPlayer.pause();
            } else {
              context.read<MusicUtils>().audioPlayer.play();
            }
          },
          icon: StreamBuilder<bool>(
            stream: context.read<MusicUtils>().audioPlayer.playingStream,
            builder: (context, snapshot) {
              bool? playingState = snapshot.data;
              if (playingState != null && playingState) {
                return Icon(
                  Icons.pause_circle_outline,
                  size: 45,
                  color: kAmber,
                );
              }
              return Icon(
                Icons.play_circle_outline,
                size: 45,
                color: kAmber,
              );
            },
          ),
        );
      },
    );
  }

  StreamBuilder<PlayerState> previousButton() {
    return StreamBuilder<PlayerState>(
      builder: (context, snapshot) {
        return IconButton(
          icon: Icon(
            Icons.skip_previous_sharp,
            color: kWhite,
          ),
          iconSize: 45.0,
          onPressed: () {
            if (context.read<MusicUtils>().audioPlayer.hasPrevious) {
              context.read<MusicUtils>().audioPlayer.seekToPrevious();
            }
          },
        );
      },
    );
  }

  StreamBuilder<PlayerState> nextButton() {
    return StreamBuilder<PlayerState>(
      builder: (context, snapshot) {
        return IconButton(
          icon: Icon(
            Icons.skip_next_sharp,
            color: kWhite,
          ),
          iconSize: 45,
          onPressed: () {
            if (context.read<MusicUtils>().audioPlayer.hasNext) {
              context.read<MusicUtils>().audioPlayer.seekToNext();
            }
          },
        );
      },
    );
  }
}
