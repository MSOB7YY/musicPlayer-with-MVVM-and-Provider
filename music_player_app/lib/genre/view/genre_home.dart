import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:music_player_app/utilities/view/query_art.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../playing_music/view/music_play.dart';
import '../../playing_music/view_model/music_utilities.dart';
import '../../utilities/bottom_sheet.dart';
import '../../utilities/create_playlist.dart';

class GenreHomeScreen extends StatefulWidget {
  final GenreModel genreModel;

  static final AudioPlayer audioPlayer = AudioPlayer();
  const GenreHomeScreen({Key? key, required this.genreModel}) : super(key: key);

  @override
  State<GenreHomeScreen> createState() => _GenreHomeScreenState();
}

class _GenreHomeScreenState extends State<GenreHomeScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> genreSong = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.amber,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(widget.genreModel.genre,
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 16.0,
                    )),
                background: QueryArtworkWidget(
                  id: widget.genreModel.id,
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
            ),
          ];
        },
        body: FutureBuilder<List<SongModel>>(
          future: _audioQuery.queryAudiosFrom(
            AudiosFromType.GENRE_ID,
            widget.genreModel.id,
          ),
          builder: (context, item) {
            if (item.data == null) {
              return const Center(
                child: BodyContainer(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }

            if (item.data!.isEmpty) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 42, 11, 99),
                      Color.fromARGB(235, 48, 14, 34),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    "Nothing found!",
                    style: TextStyle(
                      color: kWhite,
                    ),
                  ),
                ),
              );
            }
            genreSong.clear;
            genreSong = item.data!;
            return BodyContainer(
              child: ListView.separated(
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MusicScreen(),
                        ),
                      );
                      context.read<MusicUtils>().myMusic = genreSong;
                      context.read<MusicUtils>().audioPlayer.setAudioSource(
                            createPlaylist(
                              item.data!,
                            ),
                            initialIndex: index,
                          );
                      context.read<MusicUtils>().audioPlayer.play();
                    },
                    leading: QueryArtImage(
                      songModel: item.data![index],
                      artworkType: ArtworkType.GENRE,
                    ),
                    title: Text(
                      item.data![index].title,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: kWhite,
                      ),
                    ),
                    subtitle: Text(
                      item.data![index].artist ?? "No Artist",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: kWhite,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.more_vert_outlined,
                        color: kWhite,
                      ),
                      onPressed: () {
                        settingModalBottomSheet(
                          context,
                          item.data![index],
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return Divider(
                    color: kWhite,
                  );
                },
                itemCount: item.data!.length,
              ),
            );
          },
        ),
      ),
    );
  }
}
