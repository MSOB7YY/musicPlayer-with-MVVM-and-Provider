import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AllsongsProvider with ChangeNotifier {
  List<SongModel> songs = [];
  final SongSortType songSortType = SongSortType.DISPLAY_NAME;
  final OnAudioQuery audioQuery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();
  requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await audioQuery.permissionsRequest();
      }
      notifyListeners();
    }
  }

  Future<void> scanToast(BuildContext context) async {
    await Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
    // ignore: use_build_context_synchronously
    showTopSnackBar(
      context,
      CustomSnackBar.success(
        iconPositionLeft: 0,
        iconPositionTop: 0,
        iconRotationAngle: 0,
        icon: const Icon(
          Icons.abc,
          color: Colors.amber,
        ),
        backgroundColor: Colors.amber,
        message: "Songs Scanned Total songs:${songs.length} ",
      ),
    );
  }

  SongSortType sortFn() {
    return songSortType;
  }
}
