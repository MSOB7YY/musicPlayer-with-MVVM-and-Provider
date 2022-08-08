import 'package:flutter/material.dart';
import 'package:music_player_app/album/view/listview_seprate.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/artist/view/siver_artist_appbar.dart';
import 'package:music_player_app/artist/view_model/artist_provider.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view_model/null_safety.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class ArtistHomeScreen extends StatelessWidget {
  final ArtistModel artistModel;

  const ArtistHomeScreen({Key? key, required this.artistModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SilverArtistAppbar(artistModel: artistModel),
          ];
        },
        body: FutureBuilder<List<SongModel>>(
          future: context.read<AllsongsProvider>().audioQuery.queryAudiosFrom(
                AudiosFromType.ARTIST_ID,
                artistModel.id,
              ),
          builder: (context, item) {
            return item.data == null
                ? const Center(
                    child: BodyContainer(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : context.read<NullSafetyProvider>().nullChecking(
                      context,
                      item.data!,
                      context.read<ArtistProvider>().artistSong,
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
