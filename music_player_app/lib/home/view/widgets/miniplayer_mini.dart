import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../playing_music/view/music_play.dart';
import '../../../utilities/colors.dart';
import '../../model/duration.dart';
import 'miniplayer_expand.dart';

class MiniPlayerMini extends StatefulWidget {
  const MiniPlayerMini({Key? key}) : super(key: key);

  @override
  State<MiniPlayerMini> createState() => _MiniPlayerMiniState();
}

class _MiniPlayerMiniState extends State<MiniPlayerMini> {
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
  Widget build(BuildContext context) {
    if (MusicScreen.audioPlayer.playing ||
        MusicScreen.audioPlayer.currentIndex != null &&
            MusicScreen.currentIndex != -1) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            colors: [
              background1,
              background2,
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              child: StreamBuilder<DurationState>(
                stream: durationStateStream,
                builder: (context, snapshot) {
                  final durationState = snapshot.data;
                  final progress = durationState?.position ?? Duration.zero;
                  final total = durationState?.total ?? Duration.zero;

                  return ProgressBar(
                    timeLabelLocation: TimeLabelLocation.sides,
                    progress: progress,
                    total: total,
                    barHeight: 3.0,
                    baseBarColor: Colors.white,
                    progressBarColor: Colors.amber,
                    thumbColor: Colors.blue[900],
                    thumbRadius: 2,
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
            ListTile(
              leading: QueryArtworkWidget(
                id: MusicScreen
                    .myMusic[MusicScreen.audioPlayer.currentIndex!].id,
                type: ArtworkType.AUDIO,
                artworkBorder: BorderRadius.circular(
                  14.0,
                ),
                nullArtworkWidget: Image.asset(
                  "assets/malhaarNew3Logo.png",
                ),
              ),
              title: Text(
                MusicScreen
                    .myMusic[MusicScreen.audioPlayer.currentIndex!].title,
                style: const TextStyle(
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Text(
                MusicScreen
                    .myMusic[MusicScreen.audioPlayer.currentIndex!].artist
                    .toString(),
                style: const TextStyle(
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: IconButton(
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
                        Icons.pause,
                        size: 27,
                        color: Colors.amber,
                      );
                    }
                    return const Icon(
                      Icons.play_arrow,
                      size: 27,
                      color: Colors.amber,
                    );
                  },
                ),
              ),
              onTap: () {
                if (MusicScreen.myMusic.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MusicScreen(),
                    ),
                  );
                } else {
                  return;
                }
              },
            ),
          ],
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
          colors: [
            background1,
            background2,
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.zero,
            child: StreamBuilder<DurationState>(
              stream: durationStateStream,
              builder: (context, snapshot) {
                final durationState = snapshot.data;
                final progress = durationState?.position ?? Duration.zero;
                final total = durationState?.total ?? Duration.zero;

                return ProgressBar(
                  timeLabelLocation: TimeLabelLocation.sides,
                  progress: progress,
                  total: total,
                  barHeight: 3.0,
                  baseBarColor: Colors.white,
                  progressBarColor: Colors.amber,
                  thumbColor: Colors.blue[900],
                  thumbRadius: 2,
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
          ListTile(
            leading: Image.asset(
              "assets/malhaarNew3Logo.png",
            ),
            title: const Text(
              "Music Player",
              style: TextStyle(
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: const Text(
              "Artist",
              style: TextStyle(
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.play_arrow,
                size: 27,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
