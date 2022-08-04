import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../utilities/view/images.dart';

class MusicPlayArtwork extends StatelessWidget {
  MusicPlayArtwork({Key? key, required this.id}) : super(key: key);
  dynamic id;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: QueryArtworkWidget(
        id: id,
        type: ArtworkType.AUDIO,
        artworkBorder: BorderRadius.circular(
          14.0,
        ),
        nullArtworkWidget: Image.asset(
          newLogo,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
        ),
      ),
    );
  }
}
