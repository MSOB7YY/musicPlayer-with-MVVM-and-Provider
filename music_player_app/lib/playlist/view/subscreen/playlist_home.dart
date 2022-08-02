import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../all_songs/view/all_songs.dart';
import '../../../playing_music/view/music_play.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/create_playlist.dart';
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
          return Container(
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
                          createPlaylist(playloop),
                          initialIndex: index,
                        );
                        MusicScreen.audioPlayer.play();
                      }
                    },
                    leading: QueryArtworkWidget(
                      artworkBorder: const BorderRadius.all(
                        Radius.zero,
                      ),
                      artworkHeight: 60,
                      artworkWidth: 60,
                      artworkFit: BoxFit.fill,
                      nullArtworkWidget: Image.asset(
                        "assets/null2.png",
                        fit: BoxFit.fitWidth,
                      ),
                      id: AllSongs
                          .songs[Playlistsongcheck.selectPlaySong.value[index]]
                          .id,
                      type: ArtworkType.AUDIO,
                    ),
                    title: Text(
                      AllSongs
                          .songs[Playlistsongcheck.selectPlaySong.value[index]]
                          .title,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      AllSongs
                          .songs[Playlistsongcheck.selectPlaySong.value[index]]
                          .artist
                          .toString(),
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider(
                    color: Colors.white,
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
                onPrimary: Colors.white,
              ),
              child: const Text("cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                onPrimary: Colors.white,
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
