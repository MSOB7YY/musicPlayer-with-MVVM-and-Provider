// import 'package:flutter/material.dart';
// import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
// import 'package:music_player_app/playlist/model/playlist_model.dart';
// import 'package:music_player_app/playlist/view/widgets/add_playlist.dart';
// import 'package:provider/provider.dart';
// import 'playlist_functions.dart';

// class PlaylistButtonFunctions with ChangeNotifier {
//   static List<dynamic> updatelist = [];
//   static List<dynamic> dltlist = [];
//   playlistButton(BuildContext context, int? index, int? folderindex, int? id) {
//     List<dynamic> songlist = [];

//     final checkIndex = context
//         .read<PlaylistProviderFuctions>()
//         .playlistNotifier[folderindex!]
//         .songList
//         .contains(id);
//     final indexCheck = context
//         .read<PlaylistProviderFuctions>()
//         .playlistNotifier[folderindex]
//         .songList
//         .indexWhere(
//           (element) =>
//               element == context.read<AllsongsProvider>().songs[index!].id,
//         );
//     if (checkIndex != true) {
//       return IconButton(
//         onPressed: () {
//           songlist.add(
//             context.read<AllsongsProvider>().songs[index!].id,
//           );
//           AddSongsToPlayList.updatelist = [
//             songlist,
//             context
//                 .read<PlaylistProviderFuctions>()
//                 .playlistNotifier[folderindex]
//                 .songList
//           ].expand((element) => element).toList();
//           final model = PlaylistDbModel(
//             name: context
//                 .read<PlaylistProviderFuctions>()
//                 .playlistNotifier[folderindex]
//                 .name,
//             songList: AddSongsToPlayList.updatelist,
//           );
//           context
//               .read<PlaylistProviderFuctions>()
//               .updatePlaylist(folderindex, model);
//           context.read<PlaylistProviderFuctions>().getallPlaylists();
//           context
//               .read<PlaylistProviderFuctions>()
//               .showSelectSong(context, folderindex);
//           notifyListeners();
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 'added song to the playlist ${context.read<PlaylistProviderFuctions>().playlistNotifier[folderindex].name},',
//                 style: const TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//               backgroundColor: Colors.amber,
//               behavior: SnackBarBehavior.floating,
//             ),
//           );
//         },
//         icon: const Icon(
//           Icons.add,
//           color: Colors.lightGreen,
//         ),
//       );
//     }
//     return IconButton(
//       onPressed: () {
//         context
//             .read<PlaylistProviderFuctions>()
//             .playlistNotifier[folderindex]
//             .songList
//             .removeAt(indexCheck);
//         AddSongsToPlayList.dltlist = [
//           songlist,
//           context
//               .read<PlaylistProviderFuctions>()
//               .playlistNotifier[folderindex]
//               .songList
//         ].expand((element) => element).toList();
//         final model = PlaylistDbModel(
//           name: context
//               .read<PlaylistProviderFuctions>()
//               .playlistNotifier[folderindex]
//               .name,
//           songList: AddSongsToPlayList.dltlist,
//         );
//         context
//             .read<PlaylistProviderFuctions>()
//             .updatePlaylist(folderindex, model);
//         context
//             .read<PlaylistProviderFuctions>()
//             .showSelectSong(context, folderindex);

//         notifyListeners();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'song deleted from the playlist  ${context.read<PlaylistProviderFuctions>().playlistNotifier[folderindex].name},',
//               style: const TextStyle(color: Colors.white),
//             ),
//             backgroundColor: Colors.amber,
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       },
//       icon: const Icon(
//         Icons.minimize_rounded,
//         color: Colors.red,
//       ),
//     );
//   }
// }
