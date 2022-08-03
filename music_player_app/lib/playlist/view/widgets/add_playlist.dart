import 'package:flutter/material.dart';
import 'package:music_player_app/playlist/view/widgets/playlist_button.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';
import 'package:music_player_app/utilities/view/query_art.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../../all_songs/view_model/allsongs_provider.dart';
import '../../../utilities/view/main_empty_widget.dart';
import '../../view_model/fuctions/playlist_functions.dart';

class AddSongsToPlayList extends StatelessWidget {
  final int folderIndex;
  AddSongsToPlayList({Key? key, required this.folderIndex}) : super(key: key);

  final OnAudioQuery audioQuery = OnAudioQuery();
  final bool isAdded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAmber,
        title: Text(
            "Songs are adding to ${context.read<PlaylistProviderFuctions>().playlistNotifier[folderIndex].name} "),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: audioQuery.querySongs(
            sortType: SongSortType.DURATION,
            orderType: OrderType.DESC_OR_GREATER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true),
        builder: (context, item) {
          if (item.data == null) {
            return Column(
              children: const [
                BodyContainer(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            );
          }
          item.data!.isEmpty
              ? const MainItemEmpty()
              : context.read<AllsongsProvider>().songs.clear;
          context.read<AllsongsProvider>().songs = item.data!;
          return BodyContainer(
            child: ListView.separated(
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  onTap: () async {},
                  leading: QueryArtImage(
                    songModel: context.read<AllsongsProvider>().songs[index],
                    artworkType: ArtworkType.AUDIO,
                  ),
                  title: MainTextWidget(
                    title: context.read<AllsongsProvider>().songs[index].title,
                  ),
                  subtitle: MainTextWidget(
                    title:
                        context.read<AllsongsProvider>().songs[index].artist ??
                            "No Artist",
                  ),
                  trailing: PlaylistButton(
                    index: index,
                    folderindex: folderIndex,
                    id: context.read<AllsongsProvider>().songs[index].id,
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return Divider(
                  color: kWhite,
                );
              },
              itemCount: context.read<AllsongsProvider>().songs.length,
            ),
          );
        },
      ),
    );
  }
}
