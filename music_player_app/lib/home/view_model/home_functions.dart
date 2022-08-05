// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../all_songs/view_model/allsongs_provider.dart';

class HomeFunctions with ChangeNotifier {
  List<SongModel> allSongs = [];
  Future<void> scan(BuildContext context) async {
    await Future.delayed(
      const Duration(
        seconds: 15,
      ),
    );
    if (context.read<AllsongsProvider>().songs.isEmpty) {
      return showTopSnackBar(
        context,
        CustomSnackBar.error(
          iconPositionLeft: 0,
          iconPositionTop: 0,
          iconRotationAngle: 0,
          icon: Icon(
            Icons.abc,
            color: primary1,
          ),
          backgroundColor: primary1,
          message: "no Songs found",
        ),
      );
    }
    return showTopSnackBar(
      context,
      CustomSnackBar.success(
        iconPositionLeft: 0,
        iconPositionTop: 0,
        iconRotationAngle: 0,
        icon: Icon(
          Icons.abc,
          color: kAmber,
        ),
        backgroundColor: kAmber,
        message: "Songs Scanned",
      ),
    );
  }
}
