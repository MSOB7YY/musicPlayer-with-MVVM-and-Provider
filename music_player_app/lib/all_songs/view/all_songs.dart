import 'package:flutter/material.dart';
import 'package:music_player_app/all_songs/view/allsongs_listview.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

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
              if (item.data!.isEmpty) {
                return BodyContainer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/white_music.png"),
                      Center(
                        child: Text(
                          "No music found!",
                          style: TextStyle(
                            color: kWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              value.songs.clear();
              value.songs = item.data!;
              return AllSongsListView(
                songModel: item.data!,
              );
            },
          );
        },
      ),
    );
  }
}
