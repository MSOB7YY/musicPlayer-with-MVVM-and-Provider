import 'package:flutter/material.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:music_player_app/utilities/view/query_art.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../playing_music/view/music_play.dart';
import '../../playing_music/view_model/music_utilities.dart';
import '../../utilities/bottom_sheet.dart';
import '../../utilities/create_playlist.dart';
import '../../utilities/view/main_text_widget.dart';

class AllSongs extends StatelessWidget {
  const AllSongs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<AllsongsProvider>(context, listen: false)
            .requestPermission();
      },
    );
    return Scaffold(
      body: Consumer<AllsongsProvider>(
        builder: (context, value, child) {
          return FutureBuilder<List<SongModel>>(
            future:
                Provider.of<AllsongsProvider>(context).audioQuery.querySongs(
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
              item.data!.isEmpty
                  ? BodyContainer(
                      child: Center(
                        child: Text(
                          "Nothing found!",
                          style: TextStyle(
                            color: kWhite,
                          ),
                        ),
                      ),
                    )
                  : value.songs.clear;
              value.songs = item.data!;
              return RefreshIndicator(
                onRefresh: () async {
                  value.scanToast(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: BodyContainer(
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

                            context.read<MusicUtils>().myMusic = value.songs;
                            context
                                .read<MusicUtils>()
                                .audioPlayer
                                .setAudioSource(createPlaylist(item.data!),
                                    initialIndex: index);
                            context.read<MusicUtils>().audioPlayer.play();
                          },
                          leading: QueryArtImage(
                            songModel: item.data![index],
                            artworkType: ArtworkType.AUDIO,
                          ),
                          title: MainTextWidget(
                            title: item.data![index].title,
                          ),
                          subtitle: MainTextWidget(
                            title: item.data![index].artist == '<unknown>'
                                ? "unknown Artist"
                                : item.data![index].artist ?? "No Artist",
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
          );
        },
      ),
    );
  }
}
