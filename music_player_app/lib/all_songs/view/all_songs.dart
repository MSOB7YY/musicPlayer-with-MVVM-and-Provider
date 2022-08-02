import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../playing_music/view/music_play.dart';
import '../../utilities/bottom_sheet.dart';
import '../../utilities/colors.dart';
import '../../utilities/create_playlist.dart';

class AllSongs extends StatefulWidget {
  const AllSongs({Key? key}) : super(key: key);

  static List<SongModel> songs = [];
  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<SongModel>>(
        future: audioQuery.querySongs(
          sortType: SongSortType.DISPLAY_NAME,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          if (item.data == null) {
            return Container(
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
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (item.data!.isEmpty) {
            return Container(
              width: double.infinity,
              height: double.infinity,
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
          AllSongs.songs.clear;
          AllSongs.songs = item.data!;
          return RefreshIndicator(
            onRefresh: () async {
              scanToast();
              // result = true;
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: Container(
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
                        if (MusicScreen.currentIndex != index) {
                          MusicScreen.myMusic = AllSongs.songs;
                          MusicScreen.audioPlayer.setAudioSource(
                            createPlaylist(item.data!),
                            initialIndex: index,
                          );
                          MusicScreen.audioPlayer.play();
                        }
                      },
                      leading: QueryArtworkWidget(
                        artworkBorder: BorderRadius.circular(14),
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
                        item.data![index].artist == '<unknown>'
                            ? "unknown Artist"
                            : item.data![index].artist ?? "No Artist",
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
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> scanToast() async {
    await Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
    // ignore: use_build_context_synchronously
    showTopSnackBar(
      context,
      CustomSnackBar.success(
        iconPositionLeft: 0,
        iconPositionTop: 0,
        iconRotationAngle: 0,
        icon: const Icon(
          Icons.abc,
          color: Colors.amber,
        ),
        backgroundColor: Colors.amber,
        message: "Songs Scanned Total songs:${AllSongs.songs.length} ",
      ),
    );
  }
}
