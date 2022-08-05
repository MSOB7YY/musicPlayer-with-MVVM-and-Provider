import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GenreSilverAppBar extends StatelessWidget {
  const GenreSilverAppBar({
    Key? key,
    required this.genreModel,
  }) : super(key: key);

  final GenreModel genreModel;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.amber,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(genreModel.genre,
            style: TextStyle(
              color: kWhite,
              fontSize: 16.0,
            )),
        background: QueryArtworkWidget(
          id: genreModel.id,
          type: ArtworkType.GENRE,
          artworkBorder: BorderRadius.circular(
            1.0,
          ),
          artworkFit: BoxFit.fill,
          nullArtworkWidget: Image.asset(
            "assets/artwrk.jpg",
          ),
        ),
      ),
    );
  }
}
