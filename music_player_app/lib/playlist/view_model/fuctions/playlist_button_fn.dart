import 'package:flutter/material.dart';
import 'package:music_player_app/playlist/view_model/Playlist_provider.dart/widget_provider.dart';
import 'package:provider/provider.dart';
import '../../../all_songs/view_model/allsongs_provider.dart';
import '../../model/playlist_model.dart';
import '../Playlist_provider.dart/playlist_provider.dart';
import 'playlist_functions.dart';

class PlaylistButtonFunctions with ChangeNotifier {
  List<dynamic> updatelist = [];
  List<dynamic> dltlist = [];
  List<dynamic> songlist = [];
  deleteFromPlaylist(int folderIndex, BuildContext context, int id, int index) {
    final indexCheck = context
        .read<PlaylistProviderFuctions>()
        .playlistNotifier[folderIndex]
        .songList
        .indexWhere(
          (element) =>
              element == context.read<AllsongsProvider>().songs[index].id,
        );
    context
        .read<PlaylistProviderFuctions>()
        .playlistNotifier[folderIndex]
        .songList
        .removeAt(indexCheck);
    dltlist = [
      songlist,
      context
          .read<PlaylistProviderFuctions>()
          .playlistNotifier[folderIndex]
          .songList
    ].expand((element) => element).toList();
    final model = PlaylistDbModel(
        name: context
            .read<PlaylistProviderFuctions>()
            .playlistNotifier[folderIndex]
            .name,
        songList: dltlist);
    context.read<PlaylistProviderFuctions>().updatePlaylist(folderIndex, model);
    context.read<Playlistsongcheck>().showSelectSong(folderIndex, context);
    notifyListeners();
    context.read<WidgetProvider>().scaffoldMessenge(
          context,
          'song deleted from the playlist  ${context.read<PlaylistProviderFuctions>().playlistNotifier[folderIndex].name},',
        );
  }

  addPlaylistButton(
    BuildContext context,
    int index,
    int folderIndex,
  ) {
    songlist.add(
      context.read<AllsongsProvider>().songs[index].id,
    );
    updatelist = [
      songlist,
      context
          .read<PlaylistProviderFuctions>()
          .playlistNotifier[folderIndex]
          .songList
    ].expand((element) => element).toList();
    final model = PlaylistDbModel(
        name: context
            .read<PlaylistProviderFuctions>()
            .playlistNotifier[folderIndex]
            .name,
        songList: updatelist);
    context.read<PlaylistProviderFuctions>().updatePlaylist(folderIndex, model);
    context.read<PlaylistProviderFuctions>().getallPlaylists();
    context.read<Playlistsongcheck>().showSelectSong(folderIndex, context);
    notifyListeners();
    context.read<WidgetProvider>().scaffoldMessenge(
          context,
          'added song to the playlist ${context.read<PlaylistProviderFuctions>().playlistNotifier[folderIndex].name},',
        );
  }
}
