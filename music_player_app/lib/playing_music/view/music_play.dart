// ignore_for_file: sized_box_for_whitespace, import_of_legacy_library_into_null_safe
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../favorites/view_model/fav_button.dart';
import '../../home/model/duration.dart';
import '../../utilities/view/colors.dart';
import '../view_model/music_functions.dart';
import '../view_model/music_utilities.dart';
import 'widgets/playlilst_dialog.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({
    Key? key,
  }) : super(key: key);

  final Duration duration = const Duration();
  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.height;
    MediaQuery.of(context).size.width;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MusicUtils>(context, listen: false)
          .audioPlayer
          .currentIndexStream
          .listen((index) {
        if (index != null) {
          Provider.of<MusicUtils>(context, listen: false)
              .updateCurrentPlayingSongDetails(index);
        }
      });
      duration;
    });
    return Scaffold(
      backgroundColor: background1,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background1,
        title: const Text(
          "Now Playing",
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (ctx) => Search(),
              //   ),
              // );
            },
            icon: const Icon(
              Icons.search_rounded,
            ),
          )
        ],
      ),
      body: Consumer<MusicUtils>(builder: (context, value, child) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/bg.webp",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50.0,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: QueryArtworkWidget(
                      id: value.myMusic[value.currentIndex].id,
                      type: ArtworkType.AUDIO,
                      artworkBorder: BorderRadius.circular(
                        14.0,
                      ),
                      nullArtworkWidget: Image.asset(
                        "assets/malhaarNew3Logo.png",
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Text(
                    value.myMusic[value.currentIndex].title,
                    style: const TextStyle(
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                  ),
                  child: Text(
                    value.myMusic[value.currentIndex].artist.toString() ==
                            '<unknown>'
                        ? "unknown Artist"
                        : value.myMusic[value.currentIndex].artist.toString(),
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      color: const Color.fromARGB(64, 225, 224, 231),
                      height: 40,
                      width: 40,
                      child: Buttons(
                        id: value.myMusic[value.currentIndex].id,
                      ),
                    ),
                    Container(
                      color: const Color.fromARGB(64, 225, 224, 231),
                      height: 40,
                      width: 40,
                      child: IconButton(
                        onPressed: () {
                          playlistDialog(
                            context,
                            value.myMusic[value.currentIndex].id,
                            value.myMusic[value.currentIndex],
                          );
                        },
                        icon: const Icon(
                          Icons.playlist_add,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    Container(
                      color: const Color.fromARGB(64, 225, 224, 231),
                      height: 40,
                      width: 40,
                      child: InkWell(
                        onTap: () {
                          value.audioPlayer.loopMode == LoopMode.one
                              ? value.audioPlayer.setLoopMode(LoopMode.off)
                              : value.audioPlayer.setLoopMode(LoopMode.one);
                        },
                        child: StreamBuilder<LoopMode>(
                          stream: value.audioPlayer.loopModeStream,
                          builder: (context, snapshot) {
                            final loopMode = snapshot.data;
                            if (LoopMode.one == loopMode) {
                              return const Icon(
                                Icons.repeat_one,
                                color: Colors.white70,
                              );
                            }
                            return const Icon(
                              Icons.repeat,
                              color: Colors.white70,
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 58, 18, 0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      margin: const EdgeInsets.only(bottom: 4.0),
                      child: StreamBuilder<DurationState>(
                        stream: value.durationStateStream,
                        builder: (context, snapshot) {
                          final durationState = snapshot.data;
                          final progress =
                              durationState?.position ?? Duration.zero;
                          final total = durationState?.total ?? Duration.zero;

                          return ProgressBar(
                            timeLabelLocation: TimeLabelLocation.sides,
                            progress: progress,
                            total: total,
                            barHeight: 6.0,
                            baseBarColor: Colors.white,
                            progressBarColor: Colors.amber,
                            thumbColor: Colors.blue[900],
                            timeLabelTextStyle: const TextStyle(
                              fontSize: 0,
                            ),
                            onSeek: (duration) {
                              context
                                  .read<MusicUtils>()
                                  .audioPlayer
                                  .seek(duration);
                            },
                          );
                        },
                      ),
                    ),
                    StreamBuilder<DurationState>(
                      stream: value.durationStateStream,
                      builder: (context, snapshot) {
                        final durationState = snapshot.data;
                        final progress =
                            durationState?.position ?? Duration.zero;
                        final total = durationState?.total ?? Duration.zero;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Text(
                                progress.toString().split(".")[0],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                total.toString().split(".")[0],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    context.read<PlayMusicProvider>().previousButton(),
                    context.read<PlayMusicProvider>().playButton(),
                    context.read<PlayMusicProvider>().nextButton(),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
