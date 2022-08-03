import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'images.dart';

class QueryArtImage extends StatelessWidget {
  final SongModel songModel;
  final ArtworkType artworkType;
  const QueryArtImage(
      {Key? key, required this.songModel, required this.artworkType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      artworkBorder: const BorderRadius.all(
        Radius.zero,
      ),
      artworkHeight: 60,
      artworkWidth: 60,
      artworkFit: BoxFit.fill,
      nullArtworkWidget: Image.asset(
        nullImage,
        fit: BoxFit.fitWidth,
      ),
      id: songModel.id,
      type: artworkType,
    );
  }
}
