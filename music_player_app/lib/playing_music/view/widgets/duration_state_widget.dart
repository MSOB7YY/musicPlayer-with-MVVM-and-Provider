import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/home/model/duration.dart';
import 'package:provider/provider.dart';

import '../../view_model/music_utilities.dart';

class DurationStateWidget extends StatelessWidget {
  const DurationStateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DurationState>(
      stream:
          Provider.of<MusicUtils>(context, listen: false).durationStateStream,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.position ?? Duration.zero;
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
            context.read<MusicUtils>().audioPlayer.seek(duration);
          },
        );
      },
    );
  }
}
