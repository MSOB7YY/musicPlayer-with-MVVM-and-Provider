import 'package:flutter/material.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/utilities/bottom_sheet.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';
import 'package:music_player_app/utilities/view/query_art.dart';
import 'package:music_player_app/utilities/view_model/utility_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class AllSongsSearchListView extends StatelessWidget {
  const AllSongsSearchListView({Key? key, required this.songModel})
      : super(key: key);
  final List<SongModel> songModel;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<AllsongsProvider>().scanToast(context);
      },
      child: BodyContainer(
        child: ListView.separated(
          itemBuilder: (BuildContext context, index) {
            return ListTile(
              onTap: () {
                context
                    .read<UtilityProvider>()
                    .playTheMusic(context, songModel, index);
              },
              leading: QueryArtImage(
                songModel: songModel[index],
                artworkType: ArtworkType.AUDIO,
              ),
              title: MainTextWidget(
                title: songModel[index].title,
              ),
              subtitle: MainTextWidget(
                title: songModel[index].artist == '<unknown>'
                    ? "unknown Artist"
                    : songModel[index].artist ?? "No Artist",
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: kWhite,
                ),
                onPressed: () {
                  context.read<SettingModalProvider>().settingModalBottomSheet(
                        context,
                        songModel[index],
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
          itemCount: songModel.length,
        ),
      ),
    );
  }
}
