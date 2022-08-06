import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:provider/provider.dart';

import 'favorites_function.dart';

class FavouriteButtonProvider with ChangeNotifier {
  addFavoriteSongButton(BuildContext context, dynamic id) async {
    await context.read<FavoriteFunctions>().addSongs(id, context);
    final snackBar = SnackBar(
      backgroundColor: kAmber,
      content: const Text(
        'add to favorites ',
      ),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    notifyListeners();
  }

  deleteFavoriteSongButton(BuildContext context, dynamic id) async {
    await context.read<FavoriteFunctions>().deletion(
        context.read<FavoriteFunctions>().favsong.indexWhere(
              (element) => element == id,
            ),
        context);
    const snackbar = SnackBar(
      content: Text(
        'remove from favourites',
      ),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    notifyListeners();
  }
}
