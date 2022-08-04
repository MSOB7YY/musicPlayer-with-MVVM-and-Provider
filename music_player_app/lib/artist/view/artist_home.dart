import 'package:flutter/material.dart';
import 'package:music_player_app/album/view/siver_artist_appbar.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/artist/view_model/artist_provider.dart';
import 'package:music_player_app/playing_music/view/music_play.dart';
import 'package:music_player_app/playing_music/view_model/music_utilities.dart';
import 'package:music_player_app/utilities/bottom_sheet.dart';
import 'package:music_player_app/utilities/create_playlist.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/colors.dart';
import 'package:music_player_app/utilities/view/main_empty_widget.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';
import 'package:music_player_app/utilities/view/query_art.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class ArtistHomeScreen extends StatelessWidget {
  final ArtistModel artistModel;

  const ArtistHomeScreen({Key? key, required this.artistModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SilverArtistAppbar(artistModel: artistModel),
        ];
      },
      body: FutureBuilder<List<SongModel>>(
        future: context.read<AllsongsProvider>().audioQuery.queryAudiosFrom(
              AudiosFromType.ARTIST_ID,
              artistModel.id,
            ),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(
              child: BodyContainer(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }

          if (item.data!.isEmpty) {
            return const MainItemEmpty();
          }
          context.read<ArtistProvider>().artistSong.clear;
          context.read<ArtistProvider>().artistSong = item.data!;
          return BodyContainer(
            child: ListView.separated(
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MusicScreen(),
                      ),
                    );
                    context.read<MusicUtils>().myMusic =
                        context.read<ArtistProvider>().artistSong;
                    context.read<MusicUtils>().audioPlayer.setAudioSource(
                          createPlaylist(
                            item.data!,
                          ),
                          initialIndex: index,
                        );
                    context.read<MusicUtils>().audioPlayer.play();
                  },
                  leading: QueryArtImage(
                    songModel: item.data![index],
                    artworkType: ArtworkType.AUDIO,
                  ),
                  title: MainTextWidget(
                    title: item.data![index].title,
                  ),
                  subtitle: MainTextWidget(
                    title: item.data![index].artist ?? "No Artist",
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.more_vert_outlined,
                      color: kWhite,
                    ),
                    onPressed: () {
                      settingModalBottomSheet(
                        context,
                        item.data![index],
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
              itemCount: item.data!.length,
            ),
          );
        },
      ),
    ));
  }
}
