import 'package:flutter/material.dart';
import 'package:music_player_app/favorites/view/fav_button.dart';
import 'package:music_player_app/playing_music/view_model/music_utilities.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:music_player_app/utilities/view/details.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SettingModalBottom extends StatelessWidget {
  const SettingModalBottom({Key? key, required this.data}) : super(key: key);
  final SongModel data;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        ListTile(
          leading: Text(
            data.title,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primary0,
            ),
          ),
        ),
        Divider(
          thickness: 2,
          color: primary0,
        ),
        ListTile(
          leading: Container(
            height: 40,
            width: 40,
            color: const Color.fromARGB(64, 33, 149, 243),
            child: FavoriteButtons(id: data.id),
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
              color: primary0,
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
              color: primary0,
            ),
          ),
          title: const Text(
            'Add to playlist',
          ),
          onTap: () => {
            Provider.of<MusicUtils>(context, listen: false).playlistDialog(
              context,
              data.id,
              data,
            )
          },
        ),
      ],
    );
  }
}
