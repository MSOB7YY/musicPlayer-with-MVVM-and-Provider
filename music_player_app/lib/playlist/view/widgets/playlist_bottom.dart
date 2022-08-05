import 'package:flutter/material.dart';
import 'package:music_player_app/playlist/view_model/fuctions/playlist_functions.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:provider/provider.dart';

class PlaylistBottomSheet extends StatelessWidget {
  final dynamic index;
  const PlaylistBottomSheet({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Divider(
          thickness: 2,
          color: primary0,
        ),
        ListTile(
          leading: Container(
            height: 40,
            width: 40,
            color: const Color.fromARGB(64, 33, 149, 243),
            child: Icon(
              Icons.delete_rounded,
              color: primary0,
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
