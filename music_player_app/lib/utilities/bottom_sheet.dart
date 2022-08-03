import 'package:flutter/material.dart';
import 'package:music_player_app/playing_music/view_model/music_utilities.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../favorites/view_model/fav_button.dart';
import '../playing_music/view/widgets/playlilst_dialog.dart';
import 'view/details.dart';

settingModalBottomSheet(context, SongModel data) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    context: context,
    builder: (BuildContext ctx) {
      return Wrap(
        children: <Widget>[
          ListTile(
            leading: Text(
              data.title,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: background1,
              ),
            ),
          ),
          Divider(
            thickness: 2,
            color: background1,
          ),
          ListTile(
            leading: Container(
              height: 40,
              width: 40,
              color: const Color.fromARGB(64, 33, 149, 243),
              child: Buttons(id: data.id),
            ),
            title: const Text(
              'Add to Favourites',
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Container(
              height: 40,
              width: 40,
              color: const Color.fromARGB(64, 33, 149, 243),
              child: Icon(
                Icons.info_outline_rounded,
                color: background1,
              ),
            ),
            title: const Text(
              'Details',
            ),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => Details(
                    songModel: data,
                  ),
                ),
              )
            },
          ),
          ListTile(
            leading: Container(
              height: 40,
              width: 40,
              color: const Color.fromARGB(64, 33, 149, 243),
              child: Icon(
                Icons.add_circle,
                color: background1,
              ),
            ),
            title: const Text(
              'Add to playlist',
            ),
            onTap: () => {
              Navigator.of(context).pop(),
              Provider.of<MusicUtils>(context).playlistDialog(
                context,
                data.id,
                data,
              )
            },
          ),
        ],
      );
    },
  );
}
