import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:provider/provider.dart';

import '../../view_model/fuctions/playlist_functions.dart';

class PlaylistBottomSheet extends StatelessWidget {
  final dynamic index;
  const PlaylistBottomSheet({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Divider(
          thickness: 2,
          color: background1,
        ),
        ListTile(
          leading: Container(
            height: 40,
            width: 40,
            color: const Color.fromARGB(64, 33, 149, 243),
            child: Icon(
              Icons.delete_rounded,
              color: background1,
            ),
          ),
          title: const Text(
            'Delete',
          ),
          onTap: () {
            Provider.of<PlaylistProviderFuctions>(context, listen: false)
                .deletePlaylist(index);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
