// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'album_home_screen.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyContainer(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: FutureBuilder<List<AlbumModel>>(
            future: context.read<AllsongsProvider>().audioQuery.queryAlbums(
                  sortType: AlbumSortType.NUM_OF_SONGS,
                  orderType: OrderType.DESC_OR_GREATER,
                  ignoreCase: true,
                ),
            builder: (context, item) {
              if (item.data == null) {
                return const Center(
                  child: BodyContainer(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
              return item.data!.isEmpty
                  ? const BodyContainer(
                      child: Center(
                        child: Text(
                          "Nothing found!",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 3.5,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: item.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Container(
                              height: MediaQuery.of(context).size.height / 6,
                              color: const Color.fromARGB(57, 253, 253, 251),
                              child: QueryArtworkWidget(
                                artworkBorder: const BorderRadius.all(
                                  Radius.zero,
                                ),
                                artworkHeight: double.infinity,
                                artworkWidth: double.infinity,
                                artworkFit: BoxFit.fill,
                                nullArtworkWidget: Image.asset(
                                  "assets/album.jpg",
                                  fit: BoxFit.fitWidth,
                                ),
                                id: item.data![index].id,
                                type: ArtworkType.ALBUM,
                              ),
                            ),
                            subtitle: Container(
                              height: MediaQuery.of(context).size.height / 12,
                              color: const Color.fromARGB(162, 168, 167, 162),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: ListTile(
                                  title: MainTextWidget(
                                    title: item.data![index].album,
                                  ),
                                  subtitle: Text(
                                    "songs: ${item.data![index].numOfSongs.toString()}",
                                  ),
                                  textColor: Colors.white,
                                ),
                              ),
                            ),
                            onTap: () => {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => AlbumHomeScreen(
                                    albumModel: item.data![index],
                                  ),
                                ),
                              ),
                            },
                          );
                        },
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
