import 'package:flutter/material.dart';
import 'package:music_player_app/album/view/listview_seprate.dart';
import 'package:music_player_app/album/view/silver_appbar_widget.dart';
import 'package:music_player_app/album/view_model/album_provider.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view_model/null_safety.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class AlbumHomeScreen extends StatelessWidget {
  final AlbumModel albumModel;
  const AlbumHomeScreen({Key? key, required this.albumModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SilverAppbarWidget(
              albumModel: albumModel,
              image: "assets/album.jpg",
            ),
          ];
        },
        body: FutureBuilder<List<SongModel>>(
          future: context.read<AlbumProvider>().audioQuery.queryAudiosFrom(
                AudiosFromType.ALBUM_ID,
                albumModel.id,
                sortType: null,
                orderType: OrderType.DESC_OR_GREATER,
                ignoreCase: false,
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
                      context.read<AlbumProvider>().albumSong,
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
