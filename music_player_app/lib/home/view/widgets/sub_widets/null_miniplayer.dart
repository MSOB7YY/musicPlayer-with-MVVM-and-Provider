import 'package:flutter/material.dart';
import 'package:music_player_app/home/view/widgets/icon_buttons.dart';
import 'package:music_player_app/playing_music/view/widgets/duration_state_widget.dart';
import 'package:music_player_app/playing_music/view/widgets/duration_text.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';

class NullMiniPlayer extends StatelessWidget {
  const NullMiniPlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BodyContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(
                      nullMiniExpandImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Center(
                        child: Text(
                          "Music Player",
                          style: TextStyle(
                            color: kWhite,
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
                        child: MainTextWidget(
                          title: "Artist",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 58, 18, 0),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.zero,
                            margin: const EdgeInsets.only(bottom: 4.0),
                            child: const DurationStateWidget(
                              barHeight: 06,
                            ),
                          ),
                          const MusicDurationTextWidget(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          IconButtons(
                            icon: Icons.skip_previous,
                            size: 27,
                          ),
                          IconButtons(
                            icon: Icons.play_arrow,
                            size: 27,
                          ),
                          IconButtons(
                            icon: Icons.skip_next,
                            size: 27,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
