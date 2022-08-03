// ignore_for_file: invalid_use_of_protected_member, must_be_immutable, invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../all_songs/view/all_songs.dart';
import '../../playing_music/view/music_play.dart';
import '../../utilities/create_playlist.dart';

class Search extends StatelessWidget {
  ValueNotifier<List<SongModel>> temp = ValueNotifier([]);
  Search({Key? key}) : super(key: key);
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 42, 11, 99),
        title: SizedBox(
          width: 1200.0,
          height: 40,
          child: TextField(
            onChanged: (String? value) {
              if (value == null || value.isEmpty) {
                temp.value.addAll(AllSongs.songs);
                temp.notifyListeners();
              } else {
                temp.value.clear();
                for (SongModel i in AllSongs.songs) {
                  if (i.title.toLowerCase().contains(
                            value.toLowerCase(),
                          ) ||
                      (i.artist!.toLowerCase().contains(
                            value.toLowerCase(),
                          ))) {
                    temp.value.add(i);
                  }
                  temp.notifyListeners();
                }
              }
            },
            style: const TextStyle(
              color: Colors.white,
            ),
            controller: searchController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  searchController.clear();
                },
              ),
              filled: true,
              fillColor: const Color.fromARGB(55, 255, 255, 255),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              hintText: 'Search Library',
              hintStyle: const TextStyle(
                height: 0.5,
                color: Color.fromARGB(213, 255, 255, 255),
              ),
            ),
          ),
        ),
      ),
      body: Container(
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
        child: ValueListenableBuilder(
          valueListenable: temp,
          builder:
              (BuildContext ctx, List<SongModel> searchdata, Widget? child) {
            if (searchdata.isEmpty) {
              return const Center(
                child: Text(
                  "search something",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }
            return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = searchdata[index];
                return ListTile(
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
                    id: data.id,
                    type: ArtworkType.AUDIO,
                  ),
                  title: Text(
                    data.title,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    data.artist.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MusicScreen(),
                      ),
                    );

                    MusicScreen.myMusic = searchdata;
                    await MusicScreen.audioPlayer.setAudioSource(
                      createPlaylist(searchdata),
                      initialIndex: index,
                    );
                    await MusicScreen.audioPlayer.play();
                  },
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: searchdata.length,
            );
          },
        ),
      ),
    );
  }
}
