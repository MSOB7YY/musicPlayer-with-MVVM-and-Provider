import 'package:flutter/material.dart';
import 'package:music_player_app/playing_music/view_model/music_utilities.dart';
import 'package:music_player_app/playlist/view_model/Playlist_provider.dart/widget_provider.dart';
import 'package:music_player_app/playlist/view_model/fuctions/playlist_functions.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class PlaylistDialogWidget extends StatelessWidget {
  final SongModel songListPlay;
  final dynamic id;
  const PlaylistDialogWidget(
      {Key? key, required this.songListPlay, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProviderFuctions>(
      builder: (context, value, child) {
        return value.playlistNotifier.isEmpty
            ? Container(
                height: MediaQuery.of(context).size.height / 10,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.bottomRight,
                    colors: [
                      primary0,
                      primary1,
                    ],
                  ),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Provider.of<MusicUtils>(context, listen: false)
                          .addPlaylistBtn(context);
                    },
                    style: TextButton.styleFrom(
                        primary: kWhite, elevation: 2, backgroundColor: kAmber),
                    child: Text(
                      "Create Playlist",
                      style: TextStyle(
                        color: kWhite,
                      ),
                    ),
                  ),
                ),
              )
            : BodyContainer(
                child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      title: MainTextWidget(
                        title: value.playlistNotifier[index].name,
                      ),
                      subtitle: MainTextWidget(
                        title:
                            '${value.playlistNotifier[index].songList.length}',
                      ),
                      leading: Icon(
                        Icons.playlist_play_rounded,
                        color: kAmber,
                        size: 40,
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.add_circle_outline,
                          size: 50,
                          color: Color.fromARGB(94, 255, 255, 255),
                        ),
                        onPressed: () {
                          value.playlistNotifier[index].songList.contains(id)
                              ?
                              // Navigator.of(context).pop(),
                              context.read<WidgetProvider>().scaffoldMessenge(
                                    context,
                                    ' ${songListPlay.title} allready exixt in ${value.playlistNotifier[index].name}',
                                  )
                              : Navigator.of(context).pop();
                          value.playlistNotifier[index].songList.add(id);
                          context.read<WidgetProvider>().scaffoldMessenge(
                                context,
                                ' ${songListPlay.title},Added To Playlist ${value.playlistNotifier[index].name}',
                              );
                        },
                      ),
                      onTap: () {},
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return Divider(
                      color: kAmber,
                      indent: 15,
                      endIndent: 10,
                      thickness: 3,
                    );
                  },
                  itemCount: value.playlistNotifier.length,
                ),
              );
      },
    );
  }
}
