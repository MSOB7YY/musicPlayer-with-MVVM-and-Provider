import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../all_songs/view/all_songs.dart';
import '../../playing_music/view/music_play.dart';
import '../../playing_music/view_model/music_utilities.dart';
import '../../utilities/create_playlist.dart';
import '../view_model/favorites_function.dart';

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
              return BodyContainer(
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
                      Text(
                        "Add your Favorites",
                        style: TextStyle(
                          color: kWhite,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return BodyContainer(
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
                        style: TextStyle(
                          color: kWhite,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      subtitle: Text(
                        AllSongs.songs[value[index]].artist.toString(),
                        style: TextStyle(
                          color: kWhite,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                backgroundColor: kWhite,
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

                        context.read<MusicUtils>().myMusic = DbFav.favloop;
                        context.read<MusicUtils>().audioPlayer.setAudioSource(
                              context
                                  .read<CreatePlaylist>()
                                  .createPlaylist(DbFav.favloop),
                              initialIndex: index,
                            );
                        context.read<MusicUtils>().audioPlayer.play();
                      },
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return Divider(
                      color: kWhite,
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
