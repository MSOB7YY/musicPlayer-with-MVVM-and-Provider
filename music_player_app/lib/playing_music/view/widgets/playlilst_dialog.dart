import 'package:flutter/material.dart';
import 'package:music_player_app/playlist/model/playlist_model.dart';
import 'package:music_player_app/playlist/view_model/fuctions/playlist_functions.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:provider/provider.dart';

class AddPlaylistDialog extends StatelessWidget {
  AddPlaylistDialog({
    Key? key,
  }) : super(key: key);
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kAmber,
      title: const Text(
        "New Playlist",
      ),
      content: Form(
        key: formkey,
        child: TextFormField(
          validator: (value) {
            return value == null || value.isEmpty
                ? 'Please enter some text'
                : null;
          },
          controller: nameController,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: kWhite,
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
            primary: kWhite,
            onPrimary: kAmber,
          ),
          child: const Text(
            "Create",
          ),
          onPressed: () {
            if (formkey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kAmber,
                  content: const Text(
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
