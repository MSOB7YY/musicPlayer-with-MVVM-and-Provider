import 'package:flutter/material.dart';
import 'package:music_player_app/favorites/view_model/favorites_function.dart';
import 'package:music_player_app/playlist/view_model/fuctions/playlist_functions.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:provider/provider.dart';

class DeletionPlaylistAlertBox extends StatelessWidget {
  const DeletionPlaylistAlertBox({
    Key? key,
    required this.index,
    required this.name,
  }) : super(key: key);
  final dynamic index;
  final String name;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kWhite,
      content: Text(
        'Do you want to delete $name from Playlist?',
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Provider.of<PlaylistProviderFuctions>(context, listen: false)
                .deletePlaylist(index);
            const snackBar = SnackBar(
              content: Text('Removed from Playlist'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.of(context).pop();
          },
          child: const Text(
            'Remove',
            style: TextStyle(color: Colors.amber),
          ),
        )
      ],
    );
  }
}
