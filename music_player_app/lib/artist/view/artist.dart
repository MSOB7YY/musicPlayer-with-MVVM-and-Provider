// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'artist_home.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ArtistModel>>(
        future: context.read<AllsongsProvider>().audioQuery.queryArtists(
              sortType: ArtistSortType.ARTIST,
              orderType: OrderType.ASC_OR_SMALLER,
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
              ? BodyContainer(
                  child: Center(
                    child: Text(
                      "Nothing found!",
                      style: TextStyle(
                        color: kWhite,
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: BodyContainer(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 70.0),
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, index) {
                          return ListTile(
                            leading: QueryArtworkWidget(
                              artworkBorder: const BorderRadius.all(
                                Radius.zero,
                              ),
                              artworkHeight: 60,
                              artworkWidth: 60,
                              artworkFit: BoxFit.fill,
                              nullArtworkWidget: Image.asset(
                                "assets/artist4.jpg",
                                width: 60,
                                fit: BoxFit.fitWidth,
                              ),
                              id: item.data![index].id,
                              type: ArtworkType.ARTIST,
                            ),
                            title: Text(
                              item.data![index].artist,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: kWhite,
                              ),
                            ),
                            subtitle: Text(
                              "${item.data![index].numberOfAlbums.toString()} Albums | ${item.data![index].numberOfTracks.toString()} Tracks",
                              style: const TextStyle(
                                color: Color.fromARGB(151, 255, 255, 255),
                              ),
                            ),
                            onTap: () => {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => ArtistHomeScreen(
                                      artistModel: item.data![index]),
                                ),
                              ),
                            },
                          );
                        },
                        separatorBuilder: (ctx, index) {
                          return Divider(
                            color: kWhite,
                          );
                        },
                        itemCount: item.data!.length,
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
