import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../playing_music/view/music_play.dart';
import '../../playing_music/view_model/music_utilities.dart';
import '../../utilities/bottom_sheet.dart';
import '../../utilities/create_playlist.dart';

class AlbumHomeScreen extends StatefulWidget {
  final AlbumModel albumModel;
  const AlbumHomeScreen({Key? key, required this.albumModel}) : super(key: key);

  @override
  State<AlbumHomeScreen> createState() => _AlbumHomeScreenState();
}

class _AlbumHomeScreenState extends State<AlbumHomeScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> albumSong = [];
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
                title: Text(widget.albumModel.album,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: QueryArtworkWidget(
                  id: widget.albumModel.id,
                  type: ArtworkType.ALBUM,
                  artworkBorder: BorderRadius.circular(
                    1.0,
                  ),
                  artworkFit: BoxFit.fill,
                  nullArtworkWidget: Image.asset(
                    "assets/album.jpg",
                  ),
                ),
              ),
            ),
          ];
        },
        body: FutureBuilder<List<SongModel>>(
          future: _audioQuery.queryAudiosFrom(
            AudiosFromType.ALBUM_ID,
            widget.albumModel.id,
            sortType: null,
            orderType: OrderType.DESC_OR_GREATER,
            ignoreCase: false,
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
              return Column(
                children: [
                  Container(
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
                  ),
                ],
              );
            }
            albumSong.clear;
            albumSong = item.data!;
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
                      context.read<MusicUtils>().myMusic = albumSong;
                      context.read<MusicUtils>().audioPlayer.setAudioSource(
                            createPlaylist(item.data!),
                            initialIndex: index,
                          );
                      context.read<MusicUtils>().audioPlayer.play();
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
                      item.data![index].album.toString(),
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
                        settingModalBottomSheet(context, item.data![index]);
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
      ),
    );
  }
}
