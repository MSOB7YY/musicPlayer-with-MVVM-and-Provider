// ignore_for_file: sized_box_for_whitespace, import_of_legacy_library_into_null_safe
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

import '../../favorites/view_model/fav_button.dart';
import '../../home/model/duration.dart';
import '../../search/view/search_screen.dart';
import '../../utilities/colors.dart';
import 'widgets/playlilst_dialog.dart';

MiniplayerController minicntrl = MiniplayerController();

class MusicScreen extends StatefulWidget {
  static AudioPlayer audioPlayer = AudioPlayer();

  static String currentTitle = '';
  static List<SongModel> myMusic = [];
  static int currentIndex = -1;
  const MusicScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MusicScreen> createState() => MusicScreenState();
}

class MusicScreenState extends State<MusicScreen> {
  final Duration _duration = const Duration();

  int flag = 1;
  @override
  void initState() {
    super.initState();
    MusicScreen.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        _updateCurrentPlayingSongDetails(index);
      }
    });
    _duration;
  }

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
        MusicScreen.audioPlayer.positionStream,
        MusicScreen.audioPlayer.durationStream,
        (position, duration) =>
            DurationState(position: position, total: duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.height;
    MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: background1,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background1,
        title: const Text(
          "Now Playing",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => Search(),
                ),
              );
            },
            icon: const Icon(
              Icons.search_rounded,
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/bg.webp",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: QueryArtworkWidget(
                    id: MusicScreen.myMusic[MusicScreen.currentIndex].id,
                    type: ArtworkType.AUDIO,
                    artworkBorder: BorderRadius.circular(
                      14.0,
                    ),
                    nullArtworkWidget: Image.asset(
                      "assets/malhaarNew3Logo.png",
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                ),
                child: Text(
                  MusicScreen.myMusic[MusicScreen.currentIndex].title,
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
                  MusicScreen.myMusic[MusicScreen.currentIndex].artist
                              .toString() ==
                          '<unknown>'
                      ? "unknown Artist"
                      : MusicScreen.myMusic[MusicScreen.currentIndex].artist
                          .toString(),
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: const Color.fromARGB(64, 225, 224, 231),
                    height: 40,
                    width: 40,
                    child: Buttons(
                      id: MusicScreen.myMusic[MusicScreen.currentIndex].id,
                    ),
                  ),
                  Container(
                    color: const Color.fromARGB(64, 225, 224, 231),
                    height: 40,
                    width: 40,
                    child: IconButton(
                      onPressed: () {
                        playlistDialog(
                          context,
                          MusicScreen.myMusic[MusicScreen.currentIndex].id,
                          MusicScreen.myMusic[MusicScreen.currentIndex],
                        );
                      },
                      icon: const Icon(
                        Icons.playlist_add,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  Container(
                    color: const Color.fromARGB(64, 225, 224, 231),
                    height: 40,
                    width: 40,
                    child: InkWell(
                      onTap: () {
                        MusicScreen.audioPlayer.loopMode == LoopMode.one
                            ? MusicScreen.audioPlayer.setLoopMode(LoopMode.off)
                            : MusicScreen.audioPlayer.setLoopMode(LoopMode.one);
                      },
                      child: StreamBuilder<LoopMode>(
                        stream: MusicScreen.audioPlayer.loopModeStream,
                        builder: (context, snapshot) {
                          final loopMode = snapshot.data;
                          if (LoopMode.one == loopMode) {
                            return const Icon(
                              Icons.repeat_one,
                              color: Colors.white70,
                            );
                          }
                          return const Icon(
                            Icons.repeat,
                            color: Colors.white70,
                          );
                        },
                      ),
                    ),
                  )
                ],
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
                      stream: _durationStateStream,
                      builder: (context, snapshot) {
                        final durationState = snapshot.data;
                        final progress =
                            durationState?.position ?? Duration.zero;
                        final total = durationState?.total ?? Duration.zero;

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
                    stream: _durationStateStream,
                    builder: (context, snapshot) {
                      final durationState = snapshot.data;
                      final progress = durationState?.position ?? Duration.zero;
                      final total = durationState?.total ?? Duration.zero;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _previousButton(),
                  _playButton(),
                  _nextButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    MusicScreen.audioPlayer.seek(duration);
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder<PlayerState>(
      builder: (context, snapshot) {
        return IconButton(
          onPressed: () {
            setState(() {
              if (MusicScreen.audioPlayer.playing) {
                MusicScreen.audioPlayer.pause();
              } else {
                MusicScreen.audioPlayer.play();
              }
            });
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

  StreamBuilder<PlayerState> _previousButton() {
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

  StreamBuilder<PlayerState> _nextButton() {
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

  void _updateCurrentPlayingSongDetails(int index) {
    setState(
      () {
        if (MusicScreen.myMusic.isNotEmpty) {
          MusicScreen.currentTitle = MusicScreen.myMusic[index].title;
          MusicScreen.currentIndex = index;
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
