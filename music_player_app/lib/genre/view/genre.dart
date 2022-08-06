import 'package:flutter/material.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'genre_home.dart';

class GenreScreen extends StatelessWidget {
  const GenreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FutureBuilder<List<GenreModel>>(
          future: context.read<AllsongsProvider>().audioQuery.queryGenres(
                sortType: null,
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
                : BodyContainer(
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
                                "assets/artwrk.jpg",
                                height: 60,
                                width: 60,
                                fit: BoxFit.fitWidth,
                              ),
                              id: item.data![index].id,
                              type: ArtworkType.GENRE,
                            ),
                            title: MainTextWidget(
                              title: item.data![index].genre,
                            ),
                            subtitle: MainTextWidget(
                              title: "Songs: ${item.data![index].numOfSongs}"
                                  .toString(),
                              color: const Color.fromARGB(151, 255, 255, 255),
                            ),
                            onTap: () => {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => GenreHomeScreen(
                                    genreModel: item.data![index],
                                  ),
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
                  );
          },
        ),
      ),
    );
  }
}
