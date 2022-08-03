import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../playing_music/view/music_play.dart';
import '../../../utilities/body_container.dart';
import '../../../utilities/colors.dart';
import '../../model/duration.dart';
// ignore: depend_on_referenced_packages
import 'package:rxdart/rxdart.dart';

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
    MusicScreen.audioPlayer.currentIndexStream.listen((event) {
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
    if (MusicScreen.audioPlayer.playing ||
        MusicScreen.audioPlayer.currentIndex != null &&
            MusicScreen.currentIndex != -1) {
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
                      child: QueryArtworkWidget(
                        id: MusicScreen
                            .myMusic[MusicScreen.audioPlayer.currentIndex!].id,
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
                            MusicScreen
                                .myMusic[MusicScreen.audioPlayer.currentIndex!]
                                .title,
                            style: const TextStyle(
                              color: Colors.white,
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
                            MusicScreen
                                .myMusic[MusicScreen.audioPlayer.currentIndex!]
                                .artist
                                .toString(),
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
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
                                    baseBarColor: Colors.white,
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
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        total.toString().split(".")[0],
                                        style: const TextStyle(
                                          color: Colors.white70,
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
                            previousButton(),
                            playButton(),
                            nextButton(),
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
    } else {
      return const NullMiniPlayer();
    }
  }

  StreamBuilder<PlayerState> playButton() {
    return StreamBuilder<PlayerState>(
      builder: (context, snapshot) {
        return IconButton(
          onPressed: () {
            if (MusicScreen.audioPlayer.playing) {
              MusicScreen.audioPlayer.pause();
            } else {
              MusicScreen.audioPlayer.play();
            }
          },
          icon: StreamBuilder<bool>(
            stream: MusicScreen.audioPlayer.playingStream,
            builder: (context, snapshot) {
              bool? playingState = snapshot.data;
              if (playingState != null && playingState) {
                return const Icon(
                  Icons.pause_circle_outline,
                  size: 45,
                  color: Colors.amber,
                );
              }
              return const Icon(
                Icons.play_circle_outline,
                size: 45,
                color: Colors.amber,
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
          icon: const Icon(
            Icons.skip_previous_sharp,
            color: Colors.white,
          ),
          iconSize: 45.0,
          onPressed: () {
            if (MusicScreen.audioPlayer.hasPrevious) {
              MusicScreen.audioPlayer.seekToPrevious();
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
          icon: const Icon(
            Icons.skip_next_sharp,
            color: Colors.white,
          ),
          iconSize: 45,
          onPressed: () {
            if (MusicScreen.audioPlayer.hasNext) {
              MusicScreen.audioPlayer.seekToNext();
            }
          },
        );
      },
    );
  }
}

Stream<DurationState> get durationStateStream =>
    Rx.combineLatest2<Duration, Duration?, DurationState>(
      MusicScreen.audioPlayer.positionStream,
      MusicScreen.audioPlayer.durationStream,
      (position, duration) =>
          DurationState(position: position, total: duration ?? Duration.zero),
    );
