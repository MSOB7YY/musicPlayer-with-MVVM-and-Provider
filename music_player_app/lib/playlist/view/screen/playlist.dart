import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../model/playlist_model.dart';
import '../../view_model/fuctions/playlist_functions.dart';
import '../subscreen/playlist_home.dart';

class PlayList extends StatefulWidget {
  const PlayList({Key? key}) : super(key: key);

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final nameRenmaeController = TextEditingController();

  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  void initState() {
    super.initState();
    getallPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 42, 11, 99),
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
                addPlaylistBtn(context);
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
        child: ValueListenableBuilder(
          valueListenable: playlistNotifier,
          builder: (BuildContext ctx, List<PlaylistDbModel> playList,
              Widget? child) {
            if (playList.isEmpty) {
              return BodyContainer(
                child: Center(
                  child: Text(
                    "Empty Playlist",
                    style: TextStyle(
                      color: kWhite,
                    ),
                  ),
                ),
              );
            }
            return BodyContainer(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = playList[index];
                    nameRenmaeController.text = playList[index].name;
                    return ListTile(
                      title: Text(
                        data.name,
                        style: TextStyle(
                          color: kWhite,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      subtitle: Text(
                        'Songs: ${data.songList.length}',
                        style: TextStyle(
                          color: kWhite,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      leading: const Icon(
                        Icons.playlist_play_rounded,
                        color: Colors.amber,
                        size: 40,
                      ),
                      trailing: IconButton(
                        color: kWhite,
                        onPressed: () {
                          playlistBottomSheet(context, index);
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
                  itemCount: playList.length,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  myRename(context, index) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Center(
          child: AlertDialog(
            title: const Text(
              "Rename",
            ),
            content: Form(
              child: TextFormField(
                controller: nameRenmaeController,
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 42, 11, 99),
                  onPrimary: kWhite,
                ),
                child: const Text(
                  "cancel",
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  onPrimary: kWhite,
                ),
                child: const Text(
                  "Rename",
                ),
                onPressed: () {
                  // renamePlayList(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  addPlaylistBtn(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(
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
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 42, 11, 99),
                  onPrimary: kWhite,
                ),
                child: const Text("cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  onPrimary: kWhite,
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

                  final name = _nameController.text.trim();

                  if (name.isNotEmpty) {
                    final playList = PlaylistDbModel(name: name, songList: []);

                    addPlaylist(playList);
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

  playlistBottomSheet(context, index) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext ctx) {
        return Wrap(
          children: <Widget>[
            const Divider(
              thickness: 2,
              color: Color.fromARGB(255, 42, 11, 99),
            ),
            // ListTile(
            //   leading: Container(
            //     height: 40,
            //     width: 40,
            //     color: const Color.fromARGB(64, 33, 149, 243),
            //     child: const Icon(
            //       Icons.app_registration,
            //       color: Color.fromARGB(255, 42, 11, 99),
            //     ),
            //   ),
            //   title: const Text(
            //     'Rename',
            //   ),
            //   onTap: () => {
            //     Navigator.of(context).pop(),
            //     myRename(context, index),
            //   },
            // ),
            ListTile(
              leading: Container(
                height: 40,
                width: 40,
                color: const Color.fromARGB(64, 33, 149, 243),
                child: const Icon(
                  Icons.delete_rounded,
                  color: Color.fromARGB(255, 42, 11, 99),
                ),
              ),
              title: const Text(
                'Delete',
              ),
              onTap: () {
                deletePlaylist(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // void renamePlayList(index) {
  //   final name = nameRenmaeController.text;

  //   if (name.isEmpty) {
  //     Navigator.of(context).pop();
  //   } else {
  //     final rename = PlaylistDbModel(name: name, id: index);

  //     if (index != null) {
  //       updatePlaylist(index, rename,);
  //     }
  //   }
  //   _nameController.clear();
  //   Navigator.of(context).pop();
  // }
}
