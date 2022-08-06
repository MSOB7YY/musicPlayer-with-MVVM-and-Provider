import 'package:flutter/material.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/favorites/view/widgets/unable_delete.dart';
import 'package:music_player_app/favorites/view_model/favorites_function.dart';
import 'package:music_player_app/favorites/view_model/widgets_favourites.dart';
import 'package:music_player_app/playing_music/view_model/music_utilities.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';
import 'package:music_player_app/utilities/view/query_art.dart';
import 'package:music_player_app/utilities/view_model/utility_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'widgets/favorites_null_widget.dart';

class FavouriteListScreen extends StatelessWidget {
  const FavouriteListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<FavoriteFunctions>(context, listen: false)
            .getAllFavorites(context);
      },
    );
    return Scaffold(
      body: Consumer<FavoriteFunctions>(
        builder: (context, value, child) {
          return value.favourites.isEmpty
              ? const BodyContainer(
                  child: FavoritesNullWidget(),
                )
              : BodyContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          leading: QueryArtImage(
                            artworkType: ArtworkType.AUDIO,
                            songModel: context
                                .read<AllsongsProvider>()
                                .songs[value.favourites[index]],
                          ),
                          title: MainTextWidget(
                            title: context
                                .read<AllsongsProvider>()
                                .songs[value.favourites[index]]
                                .title
                                .toString(),
                          ),
                          subtitle: MainTextWidget(
                            title: context
                                .read<AllsongsProvider>()
                                .songs[value.favourites[index]]
                                .artist
                                .toString(),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              context
                                          .read<MusicUtils>()
                                          .myMusic[context
                                              .read<MusicUtils>()
                                              .currentIndex]
                                          .id ==
                                      context
                                          .read<AllsongsProvider>()
                                          .songs[value.favourites[index]]
                                          .id
                                  ? showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return const UnableToDelete();
                                      })
                                  : context
                                      .read<FavoritesWidget>()
                                      .showFavoriteDeletionBox(context, index);
                            },
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(
                                  Icons.favorite,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            context.read<UtilityProvider>().playTheMusic(
                                context,
                                context.read<FavoriteFunctions>().favloop,
                                index);
                          },
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return Divider(
                          color: kWhite,
                          thickness: 0.5,
                        );
                      },
                      itemCount: value.favourites.length,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
