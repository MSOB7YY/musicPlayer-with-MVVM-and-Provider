import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'genre_home.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({Key? key}) : super(key: key);

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FutureBuilder<List<GenreModel>>(
          future: _audioQuery.queryGenres(
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

            if (item.data!.isEmpty) {
              return Container(
                width: double.infinity,
                height: double.infinity,
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
                  child: Text(
                    "Nothing found!",
                    style: TextStyle(
                      color: kWhite,
                    ),
                  ),
                ),
              );
            }
            return BodyContainer(
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
                      title: Text(
                        item.data![index].genre,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: kWhite,
                        ),
                      ),
                      subtitle: Text(
                        "Songs: ${item.data![index].numOfSongs}".toString(),
                        style: const TextStyle(
                          color: Color.fromARGB(151, 255, 255, 255),
                        ),
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
