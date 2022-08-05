import 'package:flutter/material.dart';
import 'package:music_player_app/album/view/silver_appbar_widget.dart';
import 'package:music_player_app/album/view_model/album_provider.dart';
import 'package:music_player_app/utilities/bottom_sheet.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:music_player_app/utilities/view/main_empty_widget.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';
import 'package:music_player_app/utilities/view/query_art.dart';
import 'package:music_player_app/utilities/view_model/utility_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class AlbumHomeScreen extends StatelessWidget {
  final AlbumModel albumModel;
  const AlbumHomeScreen({Key? key, required this.albumModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SilverAppbarWidget(
              albumModel: albumModel,
              image: "assets/album.jpg",
            ),
          ];
        },
        body: FutureBuilder<List<SongModel>>(
          future: context.read<AlbumProvider>().audioQuery.queryAudiosFrom(
                AudiosFromType.ALBUM_ID,
                albumModel.id,
                sortType: null,
                orderType: OrderType.DESC_OR_GREATER,
                ignoreCase: false,
              ),
          builder: (context, item) {
            return item.data!.isEmpty
                ? const MainItemEmpty()
                : BodyContainer(
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, index) {
                        context
                            .read<AlbumProvider>()
                            .albumProviderFn(albumModel, context, item.data!);

                        return ListTile(
                          leading: QueryArtImage(
                            songModel: item.data![index],
                            artworkType: ArtworkType.AUDIO,
                          ),
                          title: MainTextWidget(
                            title: item.data![index].title,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.more_vert_outlined,
                              color: kWhite,
                            ),
                            onPressed: () {
                              settingModalBottomSheet(
                                  context, item.data![index]);
                            },
                          ),
                          onTap: () {
                            context
                                .read<UtilityProvider>()
                                .playTheMusic(context, item.data!, index);
                          },
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return Divider(
                          color: kWhite,
                        );
                      },
                      itemCount: item.data!.length,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
