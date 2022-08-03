import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../playing_music/view/music_play.dart';
import '../../utilities/bottom_sheet.dart';
import '../../utilities/create_playlist.dart';

class ArtistHomeScreen extends StatefulWidget {
  final ArtistModel artistModel;

  static final AudioPlayer audioPlayer = AudioPlayer();
  const ArtistHomeScreen({Key? key, required this.artistModel})
      : super(key: key);

  @override
  State<ArtistHomeScreen> createState() => _ArtistHomeScreenState();
}

class _ArtistHomeScreenState extends State<ArtistHomeScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> artistSong = [];

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
              title: Text(widget.artistModel.artist,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontSize: 16.0,
                  )),
              background: QueryArtworkWidget(
                id: widget.artistModel.id,
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
          ),
        ];
      },
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.queryAudiosFrom(
          AudiosFromType.ARTIST_ID,
          widget.artistModel.id,
        ),
        builder: (context, item) {
          if (item.data == null) {
            return Center(
              child: Container(
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
                child: const Center(
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
              child: const Center(
                child: Text(
                  "Nothing found!",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
          artistSong.clear;
          artistSong = item.data!;
          return Container(
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
                    MusicScreen.myMusic = artistSong;
                    MusicScreen.audioPlayer.setAudioSource(
                      createPlaylist(
                        item.data!,
                      ),
                      initialIndex: index,
                    );
                    MusicScreen.audioPlayer.play();
                  },
                  leading: QueryArtworkWidget(
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
                    id: item.data![index].id,
                    type: ArtworkType.AUDIO,
                  ),
                  title: Text(
                    item.data![index].title,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    item.data![index].artist ?? "No Artist",
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.more_vert_outlined,
                      color: Colors.white,
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
                return const Divider(
                  color: Colors.white,
                );
              },
              itemCount: item.data!.length,
            ),
          );
        },
      ),
    ));
  }
}
