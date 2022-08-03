import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/create_playlist.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:music_player_app/utilities/view/query_art.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../all_songs/view/all_songs.dart';
import '../../../playing_music/view/music_play.dart';
import '../../view_model/fuctions/playlist_functions.dart';
import '../widgets/add_playlist.dart';

class PlayListHomeScreen extends StatefulWidget {
  final int folderIndex;
  const PlayListHomeScreen({Key? key, required this.folderIndex})
      : super(key: key);

  @override
  State<PlayListHomeScreen> createState() => _PlayListHomeScreenState();
}

class _PlayListHomeScreenState extends State<PlayListHomeScreen> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  List<SongModel> playlistSongs = [];
  int tempIndex = 0;
  @override
  void initState() {
    super.initState();
    getallPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    Playlistsongcheck.showSelectSong(widget.folderIndex);
    return Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: true,
        title: Text(
          playlistNotifier.value[widget.folderIndex].name,
        ),
        backgroundColor: Colors.amber,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => AddSongsToPlayList(
                      folderIndex: widget.folderIndex,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.playlist_add,
              ),
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     showdeleteBox(context);
          //   },
          //   icon: const Icon(
          //     Icons.more_vert_outlined,
          //   ),
          // ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: playlistNotifier,
        builder:
            (BuildContext ctx, List<dynamic> selectedsongs, Widget? child) {
          return BodyContainer(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MusicScreen(),
                        ),
                      );
                      if (MusicScreen.currentIndex != index) {
                        MusicScreen.myMusic = playloop;
                        MusicScreen.audioPlayer.setAudioSource(
                          context
                              .read<CreatePlaylist>()
                              .createPlaylist(playloop),
                          initialIndex: index,
                        );
                        MusicScreen.audioPlayer.play();
                      }
                    },
                    leading: QueryArtImage(
                      songModel: AllSongs
                          .songs[Playlistsongcheck.selectPlaySong.value[index]],
                      artworkType: ArtworkType.AUDIO,
                    ),
                    title: Text(
                      AllSongs
                          .songs[Playlistsongcheck.selectPlaySong.value[index]]
                          .title,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: kWhite,
                      ),
                    ),
                    subtitle: Text(
                      AllSongs
                          .songs[Playlistsongcheck.selectPlaySong.value[index]]
                          .artist
                          .toString(),
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: kWhite,
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return Divider(
                    color: kWhite,
                  );
                },
                itemCount: Playlistsongcheck.selectPlaySong.value.length,
              ),
            ),
          );
        },
      ),
    );
  }

  showdeleteBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text(
            "Details",
          ),
          content: const Text(
            "Clear Playlist",
            style: TextStyle(
              color: Color.fromARGB(117, 0, 0, 0),
              fontSize: 18,
              fontWeight: FontWeight.bold,
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
                "Clear",
              ),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }
}
