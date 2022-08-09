// ignore_for_file: prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:music_player_app/album/view/album.dart';
import 'package:music_player_app/all_songs/view/all_songs.dart';
import 'package:music_player_app/artist/view/artist.dart';
import 'package:music_player_app/drawer/view/drawer.dart';
import 'package:music_player_app/favorites/view/favorites.dart';
import 'package:music_player_app/genre/view/genre.dart';
import 'package:music_player_app/home/view_model/home_functions.dart';
import 'package:music_player_app/playing_music/view_model/music_utilities.dart';
import 'package:music_player_app/playlist/view/screen/playlist.dart';
import 'package:music_player_app/search/view/search_screen.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:music_player_app/utilities/view/texts.dart';
import 'package:provider/provider.dart';
import 'widgets/miniplayer_expand.dart';
import 'widgets/miniplayer_mini.dart';
import 'widgets/text_widget.dart';

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
          backgroundColor: primary0,
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
                      builder: (ctx) => const Search(),
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
            labelColor: kAmber,
            isScrollable: true,
            indicatorColor: kAmber,
            tabs: [
              const Tab(
                child: TextWidget(
                  title: "SONGS",
                ),
              ),
              const Tab(
                child: TextWidget(
                  title: "PLAYLIST",
                ),
              ),
              const Tab(
                child: TextWidget(
                  title: "FAVORITES",
                ),
              ),
              const Tab(
                child: TextWidget(
                  title: "ALBUMS",
                ),
              ),
              const Tab(
                child: TextWidget(
                  title: "ARTIST",
                ),
              ),
              const Tab(
                child: TextWidget(
                  title: "GENRE",
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            BodyContainer(
              child: TabBarView(
                children: [
                  const Center(
                    child: AllSongs(),
                  ),
                  Center(
                    child: PlayList(),
                  ),
                  const Center(
                    child: FavouriteListScreen(),
                  ),
                  const Center(
                    child: AlbumScreen(),
                  ),
                  const Center(
                    child: ArtistScreen(),
                  ),
                  const Center(
                    child: GenreScreen(),
                  ),
                ],
              ),
            ),
            Consumer<MusicUtils>(builder: (context, value, child) {
              return Miniplayer(
                minHeight: 80,
                maxHeight: 350,
                builder: (height, percentage) {
                  return percentage < 0.2
                      ? const MiniPlayerMini()
                      : const MiniPlayerExpand();
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
