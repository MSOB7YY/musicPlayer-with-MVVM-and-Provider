import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/setting_model_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SettingModalProvider with ChangeNotifier {
  settingModalBottomSheet(context, SongModel data) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext ctx) {
        return SettingModalBottom(
          data: data,
        );
      },
    );
  }
}
