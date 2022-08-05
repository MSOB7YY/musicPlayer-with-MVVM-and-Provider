import 'package:flutter/material.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/genre/view/genre_silver_appbar.dart';
import 'package:music_player_app/genre/view_model/genre_provider.dart';
import 'package:music_player_app/playing_music/view/music_play.dart';
import 'package:music_player_app/utilities/bottom_sheet.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';
import 'package:music_player_app/utilities/view/query_art.dart';
import 'package:music_player_app/utilities/view_model/utility_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class GenreHomeScreen extends StatelessWidget {
  final GenreModel genreModel;

  const GenreHomeScreen({Key? key, required this.genreModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            GenreSilverAppBar(genreModel: genreModel),
          ];
        },
        body: FutureBuilder<List<SongModel>>(
          future: context.read<AllsongsProvider>().audioQuery.queryAudiosFrom(
                AudiosFromType.GENRE_ID,
                genreModel.id,
              ),
          builder: (context, item) {
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
                :

                // context.read<GenreProvider>().genreSong.clear;
                // context.read<GenreProvider>().genreSong = item.data!;
                BodyContainer(
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
                            context
                                .read<UtilityProvider>()
                                .playTheMusic(context, item.data!, index);
                          },
                          leading: QueryArtImage(
                            songModel: item.data![index],
                            artworkType: ArtworkType.GENRE,
                          ),
                          title: MainTextWidget(
                            title: item.data![index].title,
                          ),
                          subtitle: MainTextWidget(
                            title: item.data![index].artist ?? "No Artist",
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.more_vert_outlined,
                              color: kWhite,
                            ),
                            onPressed: () {
                              settingModalBottomSheet(
                                context,
                                item.data![index],
                              );
                            },
                          ),
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return Divider(
                          color: kWhite,
                        );
                      },
                      itemCount: item.data!.length,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
