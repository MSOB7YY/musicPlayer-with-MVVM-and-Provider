import 'package:flutter/material.dart';
import 'package:music_player_app/album/view/listview_seprate.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/genre/view/genre_silver_appbar.dart';
import 'package:music_player_app/genre/view_model/genre_provider.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view_model/null_safety.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class GenreHomeScreen extends StatelessWidget {
  final GenreModel genreModel;

  const GenreHomeScreen({Key? key, required this.genreModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (
          BuildContext context,
          bool innerBoxIsScrolled,
        ) {
          return <Widget>[
            GenreSilverAppBar(
              genreModel: genreModel,
            ),
          ];
        },
        body: FutureBuilder<List<SongModel>>(
          future: context.read<AllsongsProvider>().audioQuery.queryAudiosFrom(
                AudiosFromType.GENRE_ID,
                genreModel.id,
              ),
          builder: (context, item) {
            return item.data == null
                ? const BodyContainer(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : context.read<NullSafetyProvider>().nullChecking(
                      context,
                      item.data!,
                      context.read<GenreProvider>().genreSong,
                      ListViewSeprated(
                        songModel: item.data!,
                      ),
                    );
          },
        ),
      ),
    );
  }
}
