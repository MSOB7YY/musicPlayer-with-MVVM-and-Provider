import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/bottom_sheet.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';
import 'package:music_player_app/utilities/view/query_art.dart';
import 'package:music_player_app/utilities/view_model/utility_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class ListViewSeprated extends StatelessWidget {
  const ListViewSeprated({Key? key, required this.songModel}) : super(key: key);

  final List<SongModel> songModel;

  @override
  Widget build(BuildContext context) {
    return BodyContainer(
      child: ListView.separated(
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            leading: QueryArtImage(
              songModel: songModel[index],
              artworkType: ArtworkType.AUDIO,
            ),
            title: MainTextWidget(
              title: songModel[index].title,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.more_vert_outlined,
                color: kWhite,
              ),
              onPressed: () {
                settingModalBottomSheet(context, songModel[index]);
              },
            ),
            onTap: () {
              context
                  .read<UtilityProvider>()
                  .playTheMusic(context, songModel, index);
            },
          );
        },
        separatorBuilder: (ctx, index) {
          return Divider(
            color: kWhite,
          );
        },
        itemCount: songModel.length,
      ),
    );
  }
}
