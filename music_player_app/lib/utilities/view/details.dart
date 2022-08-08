import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:music_player_app/utilities/view/query_art.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Details extends StatelessWidget {
  final SongModel songModel;
  const Details({Key? key, required this.songModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primary0,
        title: const Text(
          "Details",
        ),
        centerTitle: true,
      ),
      body: BodyContainer(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      // ignore: sized_box_for_whitespace
                      child: Container(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 2,
                        child: QueryArtImage(
                          songModel: songModel,
                          artworkType: ArtworkType.AUDIO,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 15,
                    ),
                    Center(
                      child: Text(
                        "Title:   songModel.title}",
                        style: TextStyle(
                          color: kWhite,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Artist:   ${songModel.artist}",
                        style: TextStyle(
                          color: kWhite,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 15),
                    Text(
                      "Album: ${songModel.album}",
                      style: TextStyle(
                        color: kWhite,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 15),
                    Text(
                      "Genre:   ${songModel.genre}",
                      style: TextStyle(
                        color: kWhite,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 15),
                    Text(
                      "Size:   ${songModel.size}",
                      style: TextStyle(
                        color: kWhite,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 15),
                    Text(
                      "File Extension:   ${songModel.fileExtension}",
                      style: TextStyle(
                        color: kWhite,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
