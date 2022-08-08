import 'package:flutter/material.dart';
import 'package:music_player_app/playlist/view/delete_alert.dart';
import 'package:music_player_app/utilities/view/core.dart';

class PlaylistBottomSheet extends StatelessWidget {
  final dynamic index;
  final String name;
  const PlaylistBottomSheet({Key? key, required this.index, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Divider(
          thickness: 2,
          color: primary0,
        ),
        ListTile(
          leading: Container(
            height: 40,
            width: 40,
            color: const Color.fromARGB(64, 33, 149, 243),
            child: Icon(
              Icons.delete_rounded,
              color: primary0,
            ),
          ),
          title: const Text(
            'Delete',
          ),
          onTap: () {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return DeletionPlaylistAlertBox(index: index, name: name);
              },
            );
          },
        ),
      ],
    );
  }
}
