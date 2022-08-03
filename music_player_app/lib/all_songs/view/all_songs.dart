import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../playing_music/view/music_play.dart';
import '../../playing_music/view_model/music_utilities.dart';
import '../../utilities/bottom_sheet.dart';
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
            return const BodyContainer(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (item.data!.isEmpty) {
            return BodyContainer(
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
          AllSongs.songs.clear;
          AllSongs.songs = item.data!;
          return RefreshIndicator(
            onRefresh: () async {
              scanToast();
              // result = true;
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: BodyContainer(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, index) {
                    return ListTile(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const MusicScreen(),
                        //   ),
                        // );

                        // context.read<MusicUtils>().myMusic = AllSongs.songs;
                        // context.read<MusicUtils>().audioPlayer.setAudioSource(
                        //       Provider.of<CreatePlaylist>(context)
                        //           .createPlaylist(item.data!),
                        //       initialIndex: index,
                        //     );
                        Provider.of<MusicUtils>(context).audioPlayer.play();
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
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: kWhite,
                        ),
                      ),
                      subtitle: Text(
                        item.data![index].artist == '<unknown>'
                            ? "unknown Artist"
                            : item.data![index].artist ?? "No Artist",
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
