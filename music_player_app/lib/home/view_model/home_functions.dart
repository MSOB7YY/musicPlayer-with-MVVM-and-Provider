// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/home/view/widgets/custom_error.dart';
import 'package:music_player_app/home/view/widgets/custom_success.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
        const CustomSnackBarError(),
      );
    }
    return showTopSnackBar(
      context,
      const CustomSnackBarSuccess(),
    );
  }
}
