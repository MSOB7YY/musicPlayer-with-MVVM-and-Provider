// ignore_for_file: invalid_use_of_protected_member, must_be_immutable, invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:music_player_app/utilities/view/query_art.dart';
import 'package:music_player_app/utilities/view_model/utility_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../playing_music/view/music_play.dart';
import '../../playing_music/view_model/music_utilities.dart';

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
        backgroundColor: primary0,
        title: SizedBox(
          width: 1200.0,
          height: 40,
          child: TextField(
            onChanged: (String? value) {
              if (value == null || value.isEmpty) {
                temp.value.addAll(context.read<AllsongsProvider>().songs);
                temp.notifyListeners();
              } else {
                temp.value.clear();
                for (SongModel i in context.read<AllsongsProvider>().songs) {
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
            style: TextStyle(
              color: kWhite,
            ),
            controller: searchController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.close,
                  color: kWhite,
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
      body: BodyContainer(
        child: ValueListenableBuilder(
          valueListenable: temp,
          builder:
              (BuildContext ctx, List<SongModel> searchdata, Widget? child) {
            if (searchdata.isEmpty) {
              return Center(
                child: Text(
                  "search something",
                  style: TextStyle(
                    color: kWhite,
                  ),
                ),
              );
            }
            return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = searchdata[index];
                return ListTile(
                  leading: QueryArtImage(
                    songModel: data,
                    artworkType: ArtworkType.AUDIO,
                  ),
                  title: Text(
                    data.title,
                    style: TextStyle(
                      color: kWhite,
                    ),
                  ),
                  subtitle: Text(
                    data.artist.toString(),
                    style: TextStyle(
                      color: kWhite,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  onTap: () async {
                    context
                        .read<UtilityProvider>()
                        .playTheMusic(context, searchdata, index);
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
