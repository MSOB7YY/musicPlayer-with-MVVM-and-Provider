// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/favorites/view/fav_button.dart';
import 'package:music_player_app/playing_music/view/widgets/icon_sub_container.dart';
import 'package:music_player_app/playing_music/view_model/music_utilities.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:on_audio_query_platform_interface/details/on_audio_query_helper.dart';
import 'package:provider/provider.dart';

class MusicIconsWidget extends StatelessWidget {
  const MusicIconsWidget({Key? key, required this.myMusic}) : super(key: key);
  final SongModel myMusic;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            color: const Color.fromARGB(64, 225, 224, 231),
            height: 40,
            width: 40,
            child: FavoriteButtons(
              id: myMusic.id,
            ),
          ),
          IconsSubContainers(
            widget: IconButton(
              onPressed: () {
                context.read<MusicUtils>().playlistDialog(
                      context,
                      context
                          .read<MusicUtils>()
                          .myMusic[context.read<MusicUtils>().currentIndex]
                          .id,
                      context
                          .read<MusicUtils>()
                          .myMusic[context.read<MusicUtils>().currentIndex],
                    );
              },
              icon: Icon(
                Icons.playlist_add,
                color: kWhite,
                size: 28,
              ),
            ),
          ),
          IconsSubContainers(
            widget: InkWell(
              onTap: () {
                context.read<MusicUtils>().audioPlayer.loopMode == LoopMode.one
                    ? context
                        .read<MusicUtils>()
                        .audioPlayer
                        .setLoopMode(LoopMode.off)
                    : context
                        .read<MusicUtils>()
                        .audioPlayer
                        .setLoopMode(LoopMode.one);
              },
              child: StreamBuilder<LoopMode>(
                stream: context.read<MusicUtils>().audioPlayer.loopModeStream,
                builder: (context, snapshot) {
                  final loopMode = snapshot.data;
                  return LoopMode.one == loopMode
                      ? const Icon(
                          Icons.repeat_one,
                          color: Colors.white70,
                        )
                      : const Icon(
                          Icons.repeat,
                          color: Colors.white70,
                        );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
