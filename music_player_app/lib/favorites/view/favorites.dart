import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../all_songs/view/all_songs.dart';
import '../../playing_music/view/music_play.dart';

class FavouriteListScreen extends StatefulWidget {
  static bool isFav = false;
  static List<SongModel> favourites = [];
  const FavouriteListScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteListScreen> createState() => _FavouriteListScreenState();
}

class _FavouriteListScreenState extends State<FavouriteListScreen> {
  @override
  void initState() {
    super.initState();
    DbFav.getAllsongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: DbFav.favourites,
          builder: (BuildContext context, List<dynamic> value, Widget? child) {
            if (value.isEmpty) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 42, 11, 99),
                      Color.fromARGB(235, 48, 14, 34),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(
                            'assets/emptyFav1.png',
                          ),
                        ),
                      ),
                      const Text(
                        "Add your Favorites",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              );
            }
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 42, 11, 99),
                    Color.fromARGB(235, 48, 14, 34),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    return ListTile(
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
                        id: AllSongs.songs[value[index]].id,
                        type: ArtworkType.AUDIO,
                      ),
                      title: Text(
                        AllSongs.songs[value[index]].title.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      subtitle: Text(
                        AllSongs.songs[value[index]].artist.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                content: const Text(
                                  'Do you want to remove song from favorites?',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      DbFav.deletion(index);
                                      const snackBar = SnackBar(
                                        content: Text('Remove from favourites'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text(
                                      'Remove',
                                      style: TextStyle(color: Colors.amber),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.favorite,
                              color: Colors.amber,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MusicScreen(),
                          ),
                        );

                        MusicScreen.myMusic = DbFav.favloop;
                        MusicScreen.audioPlayer.setAudioSource(
                          createPlaylist(DbFav.favloop),
                          initialIndex: index,
                        );
                        MusicScreen.audioPlayer.play();
                      },
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider(
                      color: Colors.white,
                      thickness: 0.5,
                    );
                  },
                  itemCount: value.length,
                ),
              ),
            );
          }),
    );
  }
}
