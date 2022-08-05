import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SilverAppbarWidget extends StatelessWidget {
  const SilverAppbarWidget(
      {Key? key, required this.albumModel, required this.image})
      : super(key: key);

  final AlbumModel albumModel;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: kAmber,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(albumModel.album,
            style: TextStyle(
              color: kWhite,
              fontSize: 16.0,
            )),
        background: QueryArtworkWidget(
          id: albumModel.id,
          type: ArtworkType.ALBUM,
          artworkBorder: BorderRadius.circular(
            1.0,
          ),
          artworkFit: BoxFit.fill,
          nullArtworkWidget: Image.asset(
            image,
          ),
        ),
      ),
    );
  }
}
