import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/core.dart';

class WidgetProvider with ChangeNotifier {
  scaffoldMessenge(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: kWhite,
          ),
        ),
        backgroundColor: Colors.amber,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
