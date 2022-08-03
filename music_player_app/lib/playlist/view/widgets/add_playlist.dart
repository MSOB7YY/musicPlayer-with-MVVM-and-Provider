import 'package:flutter/material.dart';
import 'package:music_player_app/playlist/view/widgets/playlist_button.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../../all_songs/view_model/allsongs_provider.dart';
import '../../view_model/fuctions/playlist_functions.dart';

class AddSongsToPlayList extends StatefulWidget {
  final int folderIndex;
  const AddSongsToPlayList({Key? key, required this.folderIndex})
      : super(key: key);

  @override
  State<AddSongsToPlayList> createState() => _AddSongsToPlayListState();
}

class _AddSongsToPlayListState extends State<AddSongsToPlayList> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  bool isAdded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
            "Songs are adding to ${playlistNotifier.value[widget.folderIndex].name} "),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: audioQuery.querySongs(
          sortType: SongSortType.DURATION,
          orderType: OrderType.DESC_OR_GREATER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          if (item.data == null) {
            return Column(
              children: [
                Container(
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
              ],
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
          context.read<AllsongsProvider>().songs.clear;
          context.read<AllsongsProvider>().songs = item.data!;
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
                  onTap: () async {},
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
                    id: context.read<AllsongsProvider>().songs[index].id,
                    type: ArtworkType.AUDIO,
                  ),
                  title: Text(
                    context.read<AllsongsProvider>().songs[index].title,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    context.read<AllsongsProvider>().songs[index].artist ??
                        "No Artist",
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                    ),
                  ),
                  trailing: PlaylistButton(
                    index: index,
                    folderindex: widget.folderIndex,
                    id: context.read<AllsongsProvider>().songs[index].id,
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider(
                  color: Colors.white,
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
