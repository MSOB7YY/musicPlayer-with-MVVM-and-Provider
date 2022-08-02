import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Main_Widgets/edit_tag.dart';
import '../Tab_Widgets/Tab_Home_Widgets/Playlist_Home/dialog_add_playlist.dart';
import '../Tab_Widgets/Tab_Home_Widgets/Playlist_Home/favorite_button.dart';

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
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 42, 11, 99),
              ),
            ),
          ),
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
          //       Icons.sort,
          //       color: Color.fromARGB(255, 42, 11, 99),
          //     ),
          //   ),
          //   title: const Text(
          //     'Sort List',
          //   ),
          //   onTap: () => {},
          // ),
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
              child: const Icon(
                Icons.info_outline_rounded,
                color: Color.fromARGB(255, 42, 11, 99),
              ),
            ),
            title: const Text(
              'Details',
            ),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => EditTag(
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
              child: const Icon(
                Icons.add_circle,
                color: Color.fromARGB(255, 42, 11, 99),
              ),
            ),
            title: const Text(
              'Add to playlist',
            ),
            onTap: () => {
              Navigator.of(context).pop(),
              playlistDialog(
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
