import 'package:flutter/widgets.dart';
import 'package:music_player_app/utilities/view/main_empty_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NullSafetyProvider with ChangeNotifier {
  nullChecking(BuildContext context, List<SongModel> item,
      List<SongModel> providerList, Widget widget) {
    if (item.isEmpty) {
      return const MainItemEmpty();
    } else {
      providerList.clear();
      providerList = item;
      return widget;
    }
  }
}
