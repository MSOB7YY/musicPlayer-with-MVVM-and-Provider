// ignore_for_file: invalid_use_of_protected_member, must_be_immutable, invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:music_player_app/search/view/text_field_widget.dart';
import 'package:music_player_app/search/view_model/search_provider.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:music_player_app/utilities/view/query_art.dart';
import 'package:music_player_app/utilities/view_model/utility_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: primary0,
        title: const SizedBox(
          width: 1200.0,
          height: 40,
          child: SearchTextField(),
        ),
      ),
      body: BodyContainer(
        child: Consumer<SearchProvider>(
          builder: (context, value, child) {
            if (value.temp.isEmpty) {
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
                final data = value.temp[index];
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
                        .playTheMusic(context, value.temp, index);
                  },
                );
              },
              separatorBuilder: (ctx, index) {
                return Divider(
                  thickness: 3,
                  color: kWhite,
                );
              },
              itemCount: value.temp.length,
            );
          },
        ),
      ),
    );
  }
}
