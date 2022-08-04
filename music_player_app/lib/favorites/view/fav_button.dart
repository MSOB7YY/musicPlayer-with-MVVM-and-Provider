// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:music_player_app/favorites/view_model/favorite_button_provider.dart';
import 'package:provider/provider.dart';
import '../view_model/favorites_function.dart';

class FavoriteButtons extends StatelessWidget {
  FavoriteButtons({Key? key, this.id}) : super(key: key);
  dynamic id;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteFunctions>(
      builder: (context, value, child) {
        return value.favsong.contains(id) == true
            ? IconButton(
                onPressed: () {
                  context
                      .read<FavouriteButtonProvider>()
                      .deleteFavoriteSongButton(
                        context,
                        id,
                      );
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.amber,
                ),
              )
            : IconButton(
                onPressed: () {
                  context.read<FavouriteButtonProvider>().addFavoriteSongButton(
                        context,
                        id,
                      );
                },
                icon: const Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.grey,
                ),
              );
      },
    );
  }
}
