import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/home/view/widgets/icon_buttons.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../../playing_music/view/music_play.dart';
import '../../../playing_music/view_model/music_utilities.dart';
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
    context.read<MusicUtils>().audioPlayer.currentIndexStream.listen((event) {
      if (event != null) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (context.read<MusicUtils>().audioPlayer.playing ||
        context.read<MusicUtils>().audioPlayer.currentIndex != null &&
            context.read<MusicUtils>().currentIndex != -1) {
      return BodyContainer(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              child: StreamBuilder<DurationState>(
                stream: context.read<MusicUtils>().durationStateStream,
                builder: (context, snapshot) {
                  final durationState = snapshot.data;
                  final progress = durationState?.position ?? Duration.zero;
                  final total = durationState?.total ?? Duration.zero;

                  return ProgressBar(
                    timeLabelLocation: TimeLabelLocation.sides,
                    progress: progress,
                    total: total,
                    barHeight: 3.0,
                    baseBarColor: kWhite,
                    progressBarColor: Colors.amber,
                    thumbColor: Colors.blue[900],
                    thumbRadius: 2,
                    timeLabelTextStyle: const TextStyle(
                      fontSize: 0,
                    ),
                    onSeek: (duration) {
                      context.read<MusicUtils>().audioPlayer.seek(duration);
                    },
                  );
                },
              ),
            ),
            ListTile(
              leading: QueryArtworkWidget(
                id: context
                    .read<MusicUtils>()
                    .myMusic[
                        context.read<MusicUtils>().audioPlayer.currentIndex!]
                    .id,
                type: ArtworkType.AUDIO,
                artworkBorder: BorderRadius.circular(
                  14.0,
                ),
                nullArtworkWidget: Image.asset(
                  "assets/malhaarNew3Logo.png",
                ),
              ),
              title: Text(
                context
                    .read<MusicUtils>()
                    .myMusic[
                        context.read<MusicUtils>().audioPlayer.currentIndex!]
                    .title,
                style: TextStyle(
                  color: kWhite,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Text(
                context
                    .read<MusicUtils>()
                    .myMusic[
                        context.read<MusicUtils>().audioPlayer.currentIndex!]
                    .artist
                    .toString(),
                style: TextStyle(
                  color: kWhite,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    if (context.read<MusicUtils>().audioPlayer.playing) {
                      context.read<MusicUtils>().audioPlayer.pause();
                    } else {
                      context.read<MusicUtils>().audioPlayer.play();
                    }
                  });
                },
                icon: StreamBuilder<bool>(
                  stream: context.read<MusicUtils>().audioPlayer.playingStream,
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
                if (context.read<MusicUtils>().myMusic.isNotEmpty) {
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
    return BodyContainer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.zero,
            child: StreamBuilder<DurationState>(
              stream: context.read<MusicUtils>().durationStateStream,
              builder: (context, snapshot) {
                final durationState = snapshot.data;
                final progress = durationState?.position ?? Duration.zero;
                final total = durationState?.total ?? Duration.zero;

                return ProgressBar(
                  timeLabelLocation: TimeLabelLocation.sides,
                  progress: progress,
                  total: total,
                  barHeight: 3.0,
                  baseBarColor: kWhite,
                  progressBarColor: kAmber,
                  thumbColor: Colors.blue[900],
                  thumbRadius: 2,
                  timeLabelTextStyle: const TextStyle(
                    fontSize: 0,
                  ),
                  onSeek: (duration) {
                    context.read<MusicUtils>().audioPlayer.seek(duration);
                  },
                );
              },
            ),
          ),
          ListTile(
            leading: Image.asset(
              "assets/malhaarNew3Logo.png",
            ),
            title: Text(
              "Music Player",
              style: TextStyle(
                color: kWhite,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: Text(
              "Artist",
              style: TextStyle(
                color: kWhite,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            trailing: const IconButtons(
              icon: Icons.play_arrow,
              size: 27,
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
