// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/playlist/view_model/fuctions/playlist_button_fn.dart';
import 'package:provider/provider.dart';

import '../../view_model/fuctions/playlist_functions.dart';

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
    return Consumer<PlaylistButtonFunctions>(
      builder: (context, value, child) {
        final checkIndex = context
            .read<PlaylistProviderFuctions>()
            .playlistNotifier[folderindex!]
            .songList
            .contains(id);
        final indexCheck = context
            .read<PlaylistProviderFuctions>()
            .playlistNotifier[folderindex!]
            .songList
            .indexWhere(
              (element) =>
                  element == context.read<AllsongsProvider>().songs[index!].id,
            );

        if (checkIndex != true) {
          return IconButton(
            onPressed: () {
              value.addPlaylistButton(context, index!, folderindex!);
            },
            icon: const Icon(
              Icons.add_box_rounded,
              color: Colors.lightGreen,
            ),
          );
        }
        return IconButton(
          onPressed: () {
            value.deleteFromPlaylist(
                folderindex!, context, id!, index!, indexCheck);
          },
          icon: const Icon(
            Icons.check_box_outline_blank_sharp,
            color: Colors.red,
          ),
        );
      },
    );
  }
}
  //   return context
  //               .read<PlaylistProviderFuctions>()
  //               .playlistNotifier[folderindex]
  //               .songList
  //               .contains(id) =
  //           true
  //       ? IconButton(
  //           onPressed: () {
  //             context
  //                 .read<PlaylistButtonFunctions>()
  //                 .addPlaylistButton(context, index, folderindex);
  //           },
  //           icon: const Icon(
  //             Icons.add,
  //             color: Colors.lightGreen,
  //           ),
  //         )
  //       : IconButton(
  //           onPressed: () async {
  //             await context
  //                 .read<PlaylistButtonFunctions>()
  //                 .deleteFromPlaylist(folderindex, context, id, index);
  //           },
  //           icon: const Icon(
  //             Icons.minimize_rounded,
  //             color: Colors.red,
  //           ),
  //         );
  // }
