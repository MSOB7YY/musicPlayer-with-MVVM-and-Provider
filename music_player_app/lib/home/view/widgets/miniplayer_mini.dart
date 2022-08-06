import 'package:flutter/material.dart';
import 'package:music_player_app/home/view/widgets/sub_widets/mini_null_miniplayer.dart';
import 'package:music_player_app/playing_music/view/music_play.dart';
import 'package:music_player_app/playing_music/view/widgets/duration_state_widget.dart';
import 'package:music_player_app/playing_music/view_model/music_functions.dart';
import 'package:music_player_app/playing_music/view_model/music_utilities.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MiniPlayerMini extends StatelessWidget {
  const MiniPlayerMini({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<MusicUtils>(context, listen: false)
            .audioPlayer
            .currentIndexStream
            .listen((index) {
          index != null
              ? Provider.of<MusicUtils>(context, listen: false)
                  .updateCurrentPlayingSongDetails(index)
              : null;
        });
        context.read<MusicUtils>().duration;
      },
    );

    return Consumer<MusicUtils>(
      builder: (context, value, child) {
        return value.audioPlayer.playing ||
                value.audioPlayer.currentIndex != null &&
                    value.currentIndex != -1
            ? BodyContainer(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      child: const DurationStateWidget(
                        barHeight: 3,
                        thumbRadius: 2,
                      ),
                    ),
                    ListTile(
                      leading: QueryArtworkWidget(
                        id: value
                            .myMusic[context
                                .read<MusicUtils>()
                                .audioPlayer
                                .currentIndex!]
                            .id,
                        type: ArtworkType.AUDIO,
                        artworkBorder: BorderRadius.circular(
                          14.0,
                        ),
                        nullArtworkWidget: Image.asset(
                          "assets/malhaarNew3Logo.png",
                        ),
                      ),
                      title: MainTextWidget(
                        title: value
                            .myMusic[context
                                .read<MusicUtils>()
                                .audioPlayer
                                .currentIndex!]
                            .title,
                      ),
                      subtitle: MainTextWidget(
                        title: value
                            .myMusic[context
                                .read<MusicUtils>()
                                .audioPlayer
                                .currentIndex!]
                            .artist
                            .toString(),
                      ),
                      trailing:
                          Provider.of<PlayMusicProvider>(context, listen: false)
                              .playButton(27),
                      onTap: () {
                        context.read<MusicUtils>().myMusic.isNotEmpty
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MusicScreen(),
                                ),
                              )
                            : null;
                      },
                    ),
                  ],
                ),
              )
            : const MiniNullWidget();
      },
    );
  }
}
