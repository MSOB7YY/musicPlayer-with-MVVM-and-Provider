import 'package:flutter/material.dart';
import 'package:music_player_app/home/model/duration.dart';
import 'package:music_player_app/playing_music/view_model/music_utilities.dart';
import 'package:provider/provider.dart';

class MusicDurationTextWidget extends StatelessWidget {
  const MusicDurationTextWidget({
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
    );
  }
}
