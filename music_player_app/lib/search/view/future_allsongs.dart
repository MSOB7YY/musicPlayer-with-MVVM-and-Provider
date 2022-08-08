import 'package:flutter/material.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/search/view/allsongs_list_search.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class FutureAllSongs extends StatelessWidget {
  const FutureAllSongs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: Provider.of<AllsongsProvider>(context).audioQuery.querySongs(
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
        return AllSongsSearchListView(
          songModel: item.data!,
        );
      },
    );
  }
}
