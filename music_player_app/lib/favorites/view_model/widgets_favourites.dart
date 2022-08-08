import 'package:flutter/material.dart';
import 'package:music_player_app/favorites/view/widgets/delete_alert.dart';

class FavoritesWidget with ChangeNotifier {
  showFavoriteDeletionBox(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return DeletionAlertBox(
          index: index,
        );
      },
    );
  }
}
