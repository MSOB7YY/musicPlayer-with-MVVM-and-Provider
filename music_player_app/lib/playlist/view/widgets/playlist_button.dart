import 'package:flutter/material.dart';
import 'package:music_player_app/playlist/view_model/fuctions/playlist_button_fn.dart';
import 'package:provider/provider.dart';

class PlaylistButton extends StatelessWidget {
  const PlaylistButton(
      {Key? key,
      required this.index,
      required this.folderindex,
      required this.id})
      : super(key: key);

  final int? index;
  final int? folderindex;
  final int? id;

  @override
  @override
  Widget build(BuildContext context) {
    return checkIndex != true
        ? IconButton(
            onPressed: () {
              context
                  .read<PlaylistButtonFunctions>()
                  .addPlaylistButton(context, index!, folderindex!);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.lightGreen,
            ),
          )
        : IconButton(
            onPressed: () async {
              await context
                  .read<PlaylistButtonFunctions>()
                  .deleteFromPlaylist(folderindex!, context, id!, index!);
            },
            icon: const Icon(
              Icons.minimize_rounded,
              color: Colors.red,
            ),
          );
  }
}
