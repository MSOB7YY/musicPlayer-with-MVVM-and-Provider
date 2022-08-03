// ignore_for_file: must_be_immutable, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/playlist/view_model/Playlist_provider.dart/playlist_provider.dart';
import 'package:provider/provider.dart';
import '../../model/playlist_model.dart';
import '../../view_model/fuctions/playlist_functions.dart';

class PlaylistButton extends StatefulWidget {
  PlaylistButton(
      {Key? key,
      required this.index,
      required this.folderindex,
      required this.id})
      : super(key: key);

  int? index;
  int? folderindex;
  int? id;
  List<dynamic> songlist = [];
  static List<dynamic> updatelist = [];
  static List<dynamic> dltlist = [];
  @override
  State<PlaylistButton> createState() => _PlaylistButtonState();
}

class _PlaylistButtonState extends State<PlaylistButton> {
  @override
  Widget build(BuildContext context) {
    final checkIndex = context
        .read<PlaylistProviderFuctions>()
        .playlistNotifier[widget.folderindex!]
        .songList
        .contains(widget.id);
    final indexCheck = context
        .read<PlaylistProviderFuctions>()
        .playlistNotifier[widget.folderindex!]
        .songList
        .indexWhere(
          (element) =>
              element ==
              context.read<AllsongsProvider>().songs[widget.index!].id,
        );
    return checkIndex != true
        ? IconButton(
            onPressed: () {
              widget.songlist.add(
                context.read<AllsongsProvider>().songs[widget.index!].id,
              );
              PlaylistButton.updatelist = [
                widget.songlist,
                context
                    .read<PlaylistProviderFuctions>()
                    .playlistNotifier[widget.folderindex!]
                    .songList
              ].expand((element) => element).toList();
              final model = PlaylistDbModel(
                name: context
                    .read<PlaylistProviderFuctions>()
                    .playlistNotifier[widget.folderindex!]
                    .name,
                songList: PlaylistButton.updatelist,
              );
              context
                  .read<PlaylistProviderFuctions>()
                  .updatePlaylist(widget.folderindex!, model);
              context.read<PlaylistProviderFuctions>().getallPlaylists();
              context
                  .read<Playlistsongcheck>()
                  .showSelectSong(widget.folderindex, context);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'added song to the playlist ${context.read<PlaylistProviderFuctions>().playlistNotifier[widget.folderindex!].name},',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.amber,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.lightGreen,
            ),
          )
        : IconButton(
            onPressed: () async {
              await context
                  .read<PlaylistProviderFuctions>()
                  .playlistNotifier[widget.folderindex!]
                  .songList
                  .removeAt(indexCheck);
              PlaylistButton.dltlist = [
                widget.songlist,
                context
                    .read<PlaylistProviderFuctions>()
                    .playlistNotifier[widget.folderindex!]
                    .songList
              ].expand((element) => element).toList();
              final model = PlaylistDbModel(
                name: context
                    .read<PlaylistProviderFuctions>()
                    .playlistNotifier[widget.folderindex!]
                    .name,
                songList: PlaylistButton.dltlist,
              );
              context
                  .read<PlaylistProviderFuctions>()
                  .updatePlaylist(widget.folderindex!, model);
              context
                  .read<Playlistsongcheck>()
                  .showSelectSong(widget.folderindex, context);

              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'song deleted from the playlist  ${context.read<PlaylistProviderFuctions>().playlistNotifier[widget.folderindex!].name},',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.amber,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(
              Icons.minimize_rounded,
              color: Colors.red,
            ),
          );
  }
}
