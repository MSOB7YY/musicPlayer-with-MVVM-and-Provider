import 'package:flutter/material.dart';
import 'package:music_player_app/playlist/view_model/fuctions/playlist_functions.dart';
import 'package:provider/provider.dart';
import '../../../playlist/model/playlist_model.dart';

class AddPlaylistDialog extends StatelessWidget {
  AddPlaylistDialog({
    Key? key,
  }) : super(key: key);
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amber,
      title: const Text(
        "New Playlist",
      ),
      content: Form(
        key: formkey,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          controller: nameController,
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
            if (formkey.currentState!.validate()) {
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

            final name = nameController.text.trim();

            if (name.isNotEmpty) {
              final playList = PlaylistDbModel(name: name, songList: []);

              Provider.of<PlaylistProviderFuctions>(context, listen: false)
                  .addPlaylist(playList);
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pop();
            }
            nameController.clear();
          },
        ),
      ],
    );
  }
}
