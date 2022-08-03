import 'package:flutter/material.dart';
import 'package:music_player_app/playing_music/view_model/music_utilities.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';
import 'package:provider/provider.dart';
import '../../model/playlist_model.dart';
import '../../view_model/fuctions/playlist_functions.dart';
import '../subscreen/playlist_home.dart';

class PlayList extends StatelessWidget {
  PlayList({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final nameRenmaeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<PlaylistProviderFuctions>(context, listen: false)
            .getallPlaylists();
      },
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: background1,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text("PlayList"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 15.0,
            ),
            child: IconButton(
              onPressed: () {
                Provider.of<MusicUtils>(context, listen: false)
                    .addPlaylistBtn(context);
              },
              icon: const Icon(
                Icons.add_box_rounded,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: Consumer<PlaylistProviderFuctions>(
          builder: (context, value, child) {
            return value.playlistNotifier.isEmpty
                ? BodyContainer(
                    child: Center(
                      child: Text(
                        "Empty Playlist",
                        style: TextStyle(
                          color: kWhite,
                        ),
                      ),
                    ),
                  )
                : BodyContainer(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 70.0),
                      child: ListView.separated(
                        itemBuilder: (ctx, index) {
                          final data = value.playlistNotifier[index];
                          nameRenmaeController.text =
                              value.playlistNotifier[index].name;
                          return ListTile(
                            title: MainTextWidget(
                              title: data.name,
                            ),
                            subtitle: MainTextWidget(
                              title: 'Songs: ${data.songList.length}',
                            ),
                            leading: Icon(
                              Icons.playlist_play_rounded,
                              color: kAmber,
                              size: 40,
                            ),
                            trailing: IconButton(
                              color: kWhite,
                              onPressed: () {
                                context
                                    .read<PlaylistProviderFuctions>()
                                    .playlistBottomSheet(context, index);
                              },
                              icon: const Icon(
                                Icons.more_vert_outlined,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => PlayListHomeScreen(
                                    folderIndex: index,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (ctx, index) {
                          return Divider(
                            color: kWhite,
                            thickness: 1,
                          );
                        },
                        itemCount: value.playlistNotifier.length,
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  // myRename(context, index) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext ctx) {
  //       return Center(
  //         child: AlertDialog(
  //           title: const Text(
  //             "Rename",
  //           ),
  //           content: Form(
  //             child: TextFormField(
  //               controller: nameRenmaeController,
  //             ),
  //           ),
  //           actions: <Widget>[
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 primary: const Color.fromARGB(255, 42, 11, 99),
  //                 onPrimary: kWhite,
  //               ),
  //               child: const Text(
  //                 "cancel",
  //               ),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 primary: Colors.amber,
  //                 onPrimary: kWhite,
  //               ),
  //               child: const Text(
  //                 "Rename",
  //               ),
  //               onPressed: () {
  //                 // renamePlayList(index);
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
