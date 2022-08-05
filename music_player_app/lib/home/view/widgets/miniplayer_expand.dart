import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/home/model/duration.dart';
import 'package:music_player_app/playing_music/view_model/music_functions.dart';
import 'package:music_player_app/playing_music/view_model/music_utilities.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'sub_widets/null_miniplayer.dart';

class MiniPlayerExpand extends StatefulWidget {
  const MiniPlayerExpand({Key? key}) : super(key: key);

  @override
  State<MiniPlayerExpand> createState() => _MiniPlayerExpandState();
}

class _MiniPlayerExpandState extends State<MiniPlayerExpand> {
  @override
  void initState() {
    super.initState();
    context.read<MusicUtils>().audioPlayer.currentIndexStream.listen((event) {
      if (event != null) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return context.read<MusicUtils>().audioPlayer.playing ||
            context.read<MusicUtils>().audioPlayer.currentIndex != null &&
                context.read<MusicUtils>().currentIndex != -1
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
                            id: context
                                .read<MusicUtils>()
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
                              child: Text(
                                context
                                    .read<MusicUtils>()
                                    .myMusic[context
                                        .read<MusicUtils>()
                                        .audioPlayer
                                        .currentIndex!]
                                    .title,
                                style: TextStyle(
                                  color: kWhite,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 5.0,
                              ),
                              child: Text(
                                context
                                    .read<MusicUtils>()
                                    .myMusic[context
                                        .read<MusicUtils>()
                                        .audioPlayer
                                        .currentIndex!]
                                    .artist
                                    .toString(),
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: kWhite,
                                ),
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
                                  child: StreamBuilder<DurationState>(
                                    stream: context
                                        .read<MusicUtils>()
                                        .durationStateStream,
                                    builder: (context, snapshot) {
                                      final durationState = snapshot.data;
                                      final progress =
                                          durationState?.position ??
                                              Duration.zero;
                                      final total =
                                          durationState?.total ?? Duration.zero;

                                      return ProgressBar(
                                        timeLabelLocation:
                                            TimeLabelLocation.sides,
                                        progress: progress,
                                        total: total,
                                        barHeight: 6.0,
                                        baseBarColor: kWhite,
                                        progressBarColor: kAmber,
                                        thumbColor: Colors.blue[900],
                                        timeLabelTextStyle: const TextStyle(
                                          fontSize: 0,
                                        ),
                                        onSeek: (duration) {
                                          context
                                              .read<MusicUtils>()
                                              .audioPlayer
                                              .seek(duration);
                                        },
                                      );
                                    },
                                  ),
                                ),
                                StreamBuilder<DurationState>(
                                  stream: context
                                      .read<MusicUtils>()
                                      .durationStateStream,
                                  builder: (context, snapshot) {
                                    final durationState = snapshot.data;
                                    final progress = durationState?.position ??
                                        Duration.zero;
                                    final total =
                                        durationState?.total ?? Duration.zero;

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            progress.toString().split(".")[0],
                                            style: TextStyle(
                                              color: kWhite,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            total.toString().split(".")[0],
                                            style: TextStyle(
                                              color: kWhite,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                              16.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Provider.of<PlayMusicProvider>(context,
                                        listen: false)
                                    .previousButton(),
                                Provider.of<PlayMusicProvider>(context,
                                        listen: false)
                                    .playButton(),
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
  }
}
