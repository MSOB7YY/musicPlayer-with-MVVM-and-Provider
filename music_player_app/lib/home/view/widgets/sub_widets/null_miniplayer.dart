import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import '../../../../playing_music/view/music_play.dart';
import '../../../../utilities/view/body_container.dart';
import '../../../model/duration.dart';
import '../miniplayer_expand.dart';

class NullMiniPlayer extends StatelessWidget {
  const NullMiniPlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BodyContainer(
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
                    child: Image.asset(
                      "assets/nullMIni.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Center(
                        child: Text(
                          "Music Player",
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
                          "Artist",
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
                              stream: durationStateStream,
                              builder: (context, snapshot) {
                                final durationState = snapshot.data;
                                final progress =
                                    durationState?.position ?? Duration.zero;
                                final total =
                                    durationState?.total ?? Duration.zero;

                                return ProgressBar(
                                  timeLabelLocation: TimeLabelLocation.sides,
                                  progress: progress,
                                  total: total,
                                  barHeight: 6.0,
                                  baseBarColor: kWhite,
                                  progressBarColor: Colors.amber,
                                  thumbColor: Colors.blue[900],
                                  timeLabelTextStyle: const TextStyle(
                                    fontSize: 0,
                                  ),
                                  onSeek: (duration) {
                                    MusicScreen.audioPlayer.seek(duration);
                                  },
                                );
                              },
                            ),
                          ),
                          StreamBuilder<DurationState>(
                            stream: durationStateStream,
                            builder: (context, snapshot) {
                              final durationState = snapshot.data;
                              final progress =
                                  durationState?.position ?? Duration.zero;
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
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.skip_previous,
                              size: 27,
                              color: Colors.amber,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.play_arrow,
                              size: 27,
                              color: Colors.amber,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.skip_next,
                              size: 27,
                              color: Colors.amber,
                            ),
                          ),
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
    );
  }
}
