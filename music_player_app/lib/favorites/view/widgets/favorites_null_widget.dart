import 'package:flutter/material.dart';

class FavoritesNullWidget extends StatelessWidget {
  const FavoritesNullWidget({
    Key? key,
  }) : super(key: key);

  get kWhite => null;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/emptyFav1.png',
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
