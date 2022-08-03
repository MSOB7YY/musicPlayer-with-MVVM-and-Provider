// ignore_for_file: prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:music_player_app/home/view_model/home_functions.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:provider/provider.dart';
import '../../album/view/album.dart';
import '../../all_songs/view/all_songs.dart';
import '../../artist/view/artist.dart';
import '../../drawer/view/drawer.dart';
import '../../favorites/view/favorites.dart';
import '../../genre/view/genre.dart';
import '../../playlist/view/screen/playlist.dart';
import '../../search/view/search_screen.dart';
import '../../utilities/view/body_container.dart';
import '../../utilities/view/texts.dart';
import 'widgets/miniplayer_expand.dart';
import 'widgets/miniplayer_mini.dart';

class MusicHome extends StatelessWidget {
  const MusicHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeFunctions>(context, listen: false).scan(context);
    });
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
          title: Text(
            appName,
            style: const TextStyle(
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
          bottom: TabBar(
            unselectedLabelColor: kWhite,
            labelColor: Colors.amber,
            isScrollable: true,
            indicatorColor: Colors.amber,
            tabs: [
              const Tab(
                child: Text(
                  "SONGS",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const Tab(
                child: Text(
                  "PLAYLIST",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const Tab(
                child: Text(
                  "FAVORITES",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const Tab(
                child: Text(
                  "ALBUMS",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const Tab(
                child: Text(
                  "ARTIST",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const Tab(
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
            const BodyContainer(
              child: TabBarView(
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
}
