import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../home/model/duration.dart';
import 'package:rxdart/rxdart.dart';

class MusicUtils with ChangeNotifier {
  AudioPlayer audioPlayer = AudioPlayer();
  List<SongModel> myMusic = [];
  String currentTitle = '';
  int currentIndex = -1;
  Stream<DurationState> get durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
        audioPlayer.positionStream,
        audioPlayer.durationStream,
        (position, duration) =>
            DurationState(position: position, total: duration ?? Duration.zero),
      );
}
