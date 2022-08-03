import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'colors.dart';

bool? result;

class Details extends StatefulWidget {
  final SongModel songModel;
  const Details({Key? key, required this.songModel}) : super(key: key);

  @override
  State<Details> createState() => _EditTagState();
}

class _EditTagState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 42, 11, 99),
        title: const Text(
          "Details",
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.bottomRight,
            colors: [
              background1,
              background2,
            ],
          ),
        ),
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
                        child: QueryArtworkWidget(
                          artworkBorder: const BorderRadius.all(
                            Radius.zero,
                          ),
                          artworkHeight: 60,
                          artworkWidth: 60,
                          artworkFit: BoxFit.fill,
                          nullArtworkWidget: Image.asset(
                            "assets/null2.png",
                            fit: BoxFit.fitWidth,
                          ),
                          id: widget.songModel.id,
                          type: ArtworkType.AUDIO,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 15),
                    Center(
                      child: Text(
                        "Title:   ${widget.songModel.title}",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Artist:   ${widget.songModel.artist}",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 15),
                    Text(
                      "Album: ${widget.songModel.album}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 15),
                    Text(
                      "Genre:   ${widget.songModel.genre}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 15),
                    Text(
                      "Size:   ${widget.songModel.size}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 15),
                    Text(
                      "File Extension:   ${widget.songModel.fileExtension}",
                      style: const TextStyle(
                        color: Colors.white,
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
