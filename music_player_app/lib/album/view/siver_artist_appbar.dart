import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SilverArtistAppbar extends StatelessWidget {
  const SilverArtistAppbar({
    Key? key,
    required this.artistModel,
  }) : super(key: key);

  final ArtistModel artistModel;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: kAmber,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(artistModel.artist,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: kWhite,
              fontSize: 16.0,
            )),
        background: QueryArtworkWidget(
          id: artistModel.id,
          type: ArtworkType.ARTIST,
          artworkBorder: BorderRadius.circular(
            1.0,
          ),
          artworkFit: BoxFit.fitWidth,
          nullArtworkWidget: Image.asset(
            "assets/artist4.jpg",
          ),
        ),
      ),
    );
  }
}
