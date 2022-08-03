import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../playlist/model/playlist_model.dart';
import '../../../playlist/view_model/fuctions/playlist_functions.dart';
import '../../../utilities/colors.dart';

playlistDialog(context, id, SongModel songListPlay) {
  getallPlaylists();
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    context: context,
    builder: (BuildContext ctx) {
      return ValueListenableBuilder(
        valueListenable: playlistNotifier,
        builder:
            (BuildContext ctx, List<PlaylistDbModel> playList, Widget? child) {
          if (playList.isEmpty) {
            return Container(
              height: MediaQuery.of(context).size.height / 10,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.bottomRight,
                  colors: [
                    background1,
                    background2,
                  ],
                ),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    addPlaylistBtn(context);
                  },
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      elevation: 2,
                      backgroundColor: Colors.amber),
                  child: const Text(
                    "Create Playlist",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 42, 11, 99),
                  Color.fromARGB(235, 48, 14, 34),
                ],
              ),
            ),
            child: ListView.separated(
              itemBuilder: (ctx, index) {
                final data = playList[index];
                return ListTile(
                  title: Text(
                    data.name,
                    style: const TextStyle(
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: Text(
                    '${data.songList.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  leading: const Icon(
                    Icons.playlist_play_rounded,
                    color: Colors.amber,
                    size: 40,
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.add_circle_outline,
                      size: 50,
                      color: Color.fromARGB(94, 255, 255, 255),
                    ),
                    onPressed: () {
                      if (playlistNotifier.value[index].songList.contains(id)) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            ' ${songListPlay.title} allready exixt in ${playlistNotifier.value[index].name}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.amber,
                          behavior: SnackBarBehavior.floating,
                        ));
                      } else {
                        Navigator.of(context).pop();
                        playlistNotifier.value[index].songList.add(id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              ' ${songListPlay.title},Added To Playlist ${playlistNotifier.value[index].name}',
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.blue[900],
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                  ),
                  onTap: () {},
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider(
                  color: Colors.amber,
                  indent: 15,
                  endIndent: 10,
                  thickness: 3,
                );
              },
              itemCount: playList.length,
            ),
          );
        },
      );
    },
  );
}

final _formkey = GlobalKey<FormState>();
final _nameController = TextEditingController();
addPlaylistBtn(context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: AlertDialog(
          backgroundColor: Colors.amber,
          title: const Text(
            "New Playlist",
          ),
          content: Form(
            key: _formkey,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: _nameController,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 42, 11, 99),
                onPrimary: Colors.white,
              ),
              child: const Text("cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.amber,
              ),
              child: const Text(
                "Create",
              ),
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.amber,
                      content: Text(
                        'Playlist Added Successfully....',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                }

                final _name = _nameController.text.trim();

                if (_name.isNotEmpty) {
                  final _playList = PlaylistDbModel(name: _name, songList: []);

                  addPlaylist(_playList);
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                }
                _nameController.clear();
              },
            ),
          ],
        ),
      );
    },
  );
}
