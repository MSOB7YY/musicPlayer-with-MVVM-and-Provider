// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/drawer/view_model/scan_provider.dart';
import 'package:provider/provider.dart';

class ScanFunctionProvider with ChangeNotifier {
  isPlayinFunction(BuildContext context) {
    if (context.read<ScanProvider>().isplaying) {
      context.read<ScanProvider>().animationController.repeat();
      context.read<AllsongsProvider>().scanToast(context).then(
          (value) => context.read<ScanProvider>().animationController.stop());
    }

    context.read<ScanProvider>().isplaying =
        !context.read<ScanProvider>().isplaying;
    context.read<ScanProvider>().scan = "Scannig";
    notifyListeners();
  }
}
