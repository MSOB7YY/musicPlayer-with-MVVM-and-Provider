import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../all_songs/view_model/allsongs_provider.dart';
import '../../model/playlist_model.dart';
import '../Playlist_provider.dart/playlist_provider.dart';
import 'playlist_functions.dart';

class PlaylistButtonFunctions with ChangeNotifier {
  List<dynamic> updatelist = [];
  List<dynamic> dltlist = [];
  List<dynamic> songlist = [];

  deleteFromPlaylist(int folderindex, BuildContext context, int id, int index,
      int indexCheck) {
    print('deleteFromPlaylist');
    context
        .read<PlaylistProviderFuctions>()
        .playlistNotifier[folderindex]
        .songList
        .removeAt(indexCheck);
    dltlist = [
      songlist,
      context
          .read<PlaylistProviderFuctions>()
          .playlistNotifier[folderindex]
          .songList
    ].expand((element) => element).toList();
    final model = PlaylistDbModel(
      name: context
          .read<PlaylistProviderFuctions>()
          .playlistNotifier[folderindex]
          .name,
      songList: dltlist,
    );
    context.read<PlaylistProviderFuctions>().updatePlaylist(folderindex, model);
    context.read<Playlistsongcheck>().showSelectSong(context, folderindex);
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'song deleted from the playlist  ${context.read<PlaylistProviderFuctions>().playlistNotifier[folderindex].name},',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  addPlaylistButton(
    BuildContext context,
    int index,
    int folderindex,
  ) {
    print('addPlaylistButton');
    songlist.add(
      context.read<AllsongsProvider>().songs[index].id,
    );
    updatelist = [
      songlist,
      context
          .read<PlaylistProviderFuctions>()
          .playlistNotifier[folderindex]
          .songList
    ].expand((element) => element).toList();
    final model = PlaylistDbModel(
      name: context
          .read<PlaylistProviderFuctions>()
          .playlistNotifier[folderindex]
          .name,
      songList: updatelist,
    );
    context.read<PlaylistProviderFuctions>().updatePlaylist(folderindex, model);
    context.read<PlaylistProviderFuctions>().getallPlaylists();
    context.read<Playlistsongcheck>().showSelectSong(context, folderindex);
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'added song to the playlist ${context.read<PlaylistProviderFuctions>().playlistNotifier[folderindex].name},',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.amber,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
