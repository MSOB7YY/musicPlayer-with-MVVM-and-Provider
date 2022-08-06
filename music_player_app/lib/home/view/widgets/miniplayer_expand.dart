import 'package:flutter/material.dart';
import 'package:music_player_app/playing_music/view/widgets/duration_state_widget.dart';
import 'package:music_player_app/playing_music/view/widgets/duration_text.dart';
import 'package:music_player_app/playing_music/view_model/music_functions.dart';
import 'package:music_player_app/playing_music/view_model/music_utilities.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'sub_widets/null_miniplayer.dart';

class MiniPlayerExpand extends StatelessWidget {
  const MiniPlayerExpand({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MusicUtils>(context, listen: false)
          .audioPlayer
          .currentIndexStream
          .listen((index) {
        if (index != null) {
          Provider.of<MusicUtils>(context, listen: false)
              .updateCurrentPlayingSongDetails(index);
        }
      });
      context.read<MusicUtils>().duration;
    });
    return Consumer<MusicUtils>(builder: (context, value, child) {
      return value.audioPlayer.playing ||
              value.audioPlayer.currentIndex != null && value.currentIndex != -1
          ? BodyContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Center(
                          // ignore: sized_box_for_whitespace
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: QueryArtworkWidget(
                              id: value
                                  .myMusic[context
                                      .read<MusicUtils>()
                                      .audioPlayer
                                      .currentIndex!]
                                  .id,
                              type: ArtworkType.AUDIO,
                              artworkBorder: BorderRadius.circular(
                                1.0,
                              ),
                              nullArtworkWidget: Image.asset(
                                "assets/nullMIni.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 28.0),
                              child: Center(
                                child: MainTextWidget(
                                  title: value
                                      .myMusic[context
                                          .read<MusicUtils>()
                                          .audioPlayer
                                          .currentIndex!]
                                      .title,
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 5.0,
                                ),
                                child: MainTextWidget(
                                  title: value
                                      .myMusic[context
                                          .read<MusicUtils>()
                                          .audioPlayer
                                          .currentIndex!]
                                      .artist
                                      .toString(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(18, 58, 18, 0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.zero,
                                    margin: const EdgeInsets.only(bottom: 4.0),
                                    child: const DurationStateWidget(
                                      barHeight: 06,
                                    ),
                                  ),
                                  const MusicDurationTextWidget(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                16.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Provider.of<PlayMusicProvider>(context,
                                          listen: false)
                                      .previousButton(),
                                  Provider.of<PlayMusicProvider>(context,
                                          listen: false)
                                      .playButton(40),
                                  Provider.of<PlayMusicProvider>(context,
                                          listen: false)
                                      .nextButton(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const NullMiniPlayer();
    });
  }
}
