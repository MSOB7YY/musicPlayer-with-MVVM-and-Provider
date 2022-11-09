import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/core.dart';

class FavoritesNullWidget extends StatelessWidget {
  const FavoritesNullWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/couples.png',
              ),
            ),
          ),
          Text(
            "Add your Favorites",
            style: TextStyle(
              color: kWhite,
            ),
          )
        ],
      ),
    );
  }
}
