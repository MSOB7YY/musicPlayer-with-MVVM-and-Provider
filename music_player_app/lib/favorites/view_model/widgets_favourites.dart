import 'package:flutter/material.dart';
import 'package:music_player_app/favorites/view_model/favorites_function.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:provider/provider.dart';

class FavoritesWidget with ChangeNotifier {
  showFavoriteDeletionBox(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          backgroundColor: kWhite,
          content: const Text(
            'Do you want to remove song from favorites?',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<FavoriteFunctions>().deletion(index, context);
                const snackBar = SnackBar(
                  content: Text('Remove from favourites'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.of(ctx).pop();
              },
              child: const Text(
                'Remove',
                style: TextStyle(color: Colors.amber),
              ),
            )
          ],
        );
      },
    );
  }
}
