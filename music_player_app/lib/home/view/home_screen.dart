// ignore_for_file: prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../album/view/album.dart';
import '../../all_songs/view/all_songs.dart';
import '../../artist/view/artist.dart';
import '../../drawer/view/drawer.dart';
import '../../favorites/view/favorites.dart';
import '../../genre/view/genre.dart';
import '../../playlist/view/screen/playlist.dart';
import '../../search/view/search_screen.dart';
import '../../utilities/colors.dart';
import 'widgets/miniplayer_expand.dart';
import 'widgets/miniplayer_mini.dart';

class MusicHome extends StatefulWidget {
  const MusicHome({Key? key}) : super(key: key);

  @override
  State<MusicHome> createState() => _MusicHomeState();
}

class _MusicHomeState extends State<MusicHome> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  void initState() {
    super.initState();
    scan();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(
        seconds: 0,
      ),
      length: 6,
      child: Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 42, 11, 99),
          title: const Text(
            'MalhaaR Music',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
                top: 5,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => Search(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  size: 28,
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            unselectedLabelColor: Colors.white,
            labelColor: Colors.amber,
            isScrollable: true,
            indicatorColor: Colors.amber,
            tabs: [
              Tab(
                child: Text(
                  "SONGS",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "PLAYLIST",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "FAVORITES",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "ALBUMS",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "ARTIST",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "GENRE",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.bottomRight,
                  colors: [background1, background2],
                ),
              ),
              child: const TabBarView(
                children: [
                  Center(
                    child: AllSongs(),
                  ),
                  Center(
                    child: PlayList(),
                  ),
                  Center(
                    child: FavouriteListScreen(),
                  ),
                  Center(
                    child: AlbumScreen(),
                  ),
                  Center(
                    child: ArtistScreen(),
                  ),
                  Center(
                    child: GenreScreen(),
                  ),
                ],
              ),
            ),
            Miniplayer(
              minHeight: 80,
              maxHeight: 350,
              builder: (height, percentage) {
                if (percentage < 0.2) {
                  return const MiniPlayerMini();
                } else {
                  return const MiniPlayerExpand();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> scan() async {
    await Future.delayed(
      const Duration(
        seconds: 15,
      ),
    );
    if (AllSongs.songs.isEmpty) {
      return showTopSnackBar(
        context,
        CustomSnackBar.error(
          iconPositionLeft: 0,
          iconPositionTop: 0,
          iconRotationAngle: 0,
          icon: Icon(
            Icons.abc,
            color: background2,
          ),
          backgroundColor: background2,
          message: "no Songs found",
        ),
      );
    }
    return showTopSnackBar(
      context,
      const CustomSnackBar.success(
        iconPositionLeft: 0,
        iconPositionTop: 0,
        iconRotationAngle: 0,
        icon: Icon(
          Icons.abc,
          color: Colors.amber,
        ),
        backgroundColor: Colors.amber,
        message: "Songs Scanned",
      ),
    );
  }
}
